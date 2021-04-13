import 'package:Nimaz_App_Demo/Controllers/qibla_controller.dart';
import 'package:Nimaz_App_Demo/Screens/BottomNavScreens/Qibla/qibla_compass.dart';
import 'package:flutter/material.dart';

import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class QiblaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _iblaController = Get.find<QiblaController>();

    return Scaffold(
      backgroundColor: HexColor('#2a2b3d'),
      body: FutureBuilder(
        future: _iblaController.deviceSupport,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );

          if (snapshot.hasError)
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          // call the Compass Class
          if (snapshot.hasData)
            return QiblaCompass();
          else
            return Container(
              child: Text('Error'),
            );
        },
      ),
    );
  }
}
