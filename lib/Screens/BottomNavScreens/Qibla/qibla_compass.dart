import 'dart:async';
import 'dart:math' show pi;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'location_error_widget.dart';

class QiblaCompass extends StatefulWidget {
  @override
  _QiblaCompassState createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CupertinoActivityIndicator();
          if (snapshot.data.enabled == true) {
            switch (snapshot.data.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: _checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: _checkLocationStatus,
                );
              // case GeolocationStatus.unknown:
              //   return LocationErrorWidget(
              //     error: "Unknown Location service error",
              //     callback: _checkLocationStatus,
              //   );
              default:
                return Container();
            }
          } else {
            return LocationErrorWidget(
              error: "Please enable Location service",
              callback: _checkLocationStatus,
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblahCompassWidget extends StatefulWidget {
  @override
  _QiblahCompassWidgetState createState() => _QiblahCompassWidgetState();
}

class _QiblahCompassWidgetState extends State<QiblahCompassWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CupertinoActivityIndicator();

        final qiblahDirection = snapshot.data;
        var _angle = ((qiblahDirection.qiblah ?? 0) * (pi / 180) * -1);
        //var _angle = 1 - qiblahDirection.qiblah/360;
        // if (_angle < 5 && _angle > -5) print('IN RANGE');
        //print(qiblahDirection.direction);
        //print(qiblahDirection.direction - qiblahDirection.offset);
        //print((1 - qiblahDirection.qiblah/360).abs());
        String angleValue = _angle.abs().toString().substring(0, 4);

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // BD Image
            Container(
                alignment: Alignment.bottomCenter,
                constraints: BoxConstraints.expand(),
                child: Image.asset('assets/qibla/BGmosque.png',
                    fit: BoxFit.contain)),

            // Angle text
            Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Container(
                        child: Text('QIBLA',
                            style: TextStyle(
                                color: Colors.white, fontSize: 24))),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          'Warning: Please Keep your Phone Horizontal to get better results!',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.center,
                        )),
                  ],
                )),
// Goog Direction Dots Shows
            Container(
                margin: EdgeInsets.only(top: 170),
                alignment: Alignment.topCenter,
                child: Transform.rotate(
                    angle: _angle,
                    child: double.parse(angleValue) < 6.36 && double.parse(angleValue) > 6.20
                        ? Image.asset('assets/qibla/good_Direction.png',
                            height: 20, width: 20)
                        : Image.asset('assets/qibla/wrong_Direction.png',
                            height: 20, width: 20))),
            Transform.rotate(
              angle: _angle,
              child: Image.asset('assets/qibla/qibla.png',
                  height: 200,
                  width: 200, // compass
                  color: Colors.white),
            ),
          ],
        );
      },
    );
  }
}
