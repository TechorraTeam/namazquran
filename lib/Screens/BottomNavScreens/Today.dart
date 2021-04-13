import 'package:Nimaz_App_Demo/Controllers/today_controller.dart';
import 'package:Nimaz_App_Demo/Notifiction/notificationPlugin.dart';
import 'package:Nimaz_App_Demo/Screens/MainPage/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class TodaySection extends StatefulWidget {
  @override
  _TodaySectionState createState() => _TodaySectionState();
}

class _TodaySectionState extends State<TodaySection> {
  final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey(debugLabel: "Main Navigator");

  String getminutesfortext = 'asd';
  String gethoursfortext;
  String getTheTime = "2:44";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(minutes: 1), (Timer t) async {
      decrementtheTime();
    });
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

// Notification Calling methods that USed in InitState of Today Setion;
  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
    navigatorKey.currentState
        .push(MaterialPageRoute(builder: (_) => MainPage()));
  }

  String delayNimazTime(DateTime now, String delayNimazTime) {
    // DateTime now = DateTime.now();
    print("Deay Time is ::");
    print(delayNimazTime);
    String todayDate1 = DateFormat.Hm().format(now);
    var format = DateFormat.Hm();
    // Fajar Section

    DateTime todayDate = DateFormat('HH:mm').parse(delayNimazTime);
    String todayDate2 = DateFormat.Hm().format(todayDate);
    var one = format.parse(todayDate1);
    var two = format.parse(todayDate2);

    // String ss = (two.difference(one).toString()).substring(0, 1);
    String time = "${two.difference(one)}".substring(0, 5);

    if (time[1] == ':') {
      time = "${two.difference(one)}".substring(0, 4);
    } else {
      time = "${two.difference(one)}".substring(0, 4);
    }

    String hours, minutes;
    String dhours, dminutes;
    getTheTime = time.toString();
    if (getTheTime.contains('-')) {
      String todayDate2 = "24:00";

      var two = format.parse(todayDate2);
      time = "${two.difference(one)}".substring(0, 4);
      if (time.substring(0, 2).contains(':')) {
        hours = time.substring(0, 1);
        minutes = time.substring(2, 4);
      } else {
        hours = time.substring(0, 2);
        minutes = time.substring(2, 4);
      }
      print(delayNimazTime.toString().substring(0, 2));
      dhours = delayNimazTime.toString().substring(0, 2);
      dminutes = delayNimazTime.toString().substring(3, 5);
      // Time Designing For Fajar
      String addhours = (int.parse(hours) + int.parse(dhours)).toString();
      String addminutes = (int.parse(minutes) + int.parse(dminutes)).toString();

      if (int.parse(addminutes) >= 60) {
        addhours = (int.parse(addhours) + (1)).toString();
        addminutes = (int.parse(addminutes) - (60)).toString();
      }
      String designTime = addhours + ":" + addminutes;
      time = designTime;

      getTheTime = time.toString();
    }
    return time;
  }

  // int intointminutes;
  void decrementtheTime() {
    String getminutes = getTheTime.substring(2, 4);
    String gethours = getTheTime.substring(0, 1);

    int intointminutes = int.parse(getminutes);
    int intointHours = int.parse(gethours);
    if (intointminutes <= 59) {
      intointminutes--;

      if (intointminutes < 0) {
        intointHours--;
        setState(() {
          intointminutes = 59;
        });
      }
    }
    setState(() {
      getminutesfortext = intointminutes.toString();
    });
    setState(() {
      gethoursfortext = intointHours.toString();
    });
    getTheTime = gethoursfortext + ':' + getminutesfortext;
  }

// variables of Days Controller
  int incount = 0;

  var daysFromNow;
  var preDaysFrom;
  String currentDate = DateTime.now().toString();
  void incrmentDate() {
    incount++;
    var daysFromNow = DateTime.now().add(new Duration(days: incount));

    setState(() {
      currentDate = datetimeFormatter(daysFromNow);
    });

    // return datetimeFormatter(currentDate);
  }

  void decrementDate() {
    preDaysFrom = DateTime.now().add(new Duration(days: incount--));
    setState(() {
      currentDate = datetimeFormatter(preDaysFrom);
    });
    // return datetimeFormatter(currentDate);
  }

// Days Controller Funtions;;;;
  String datetimeFormatter(DateTime now) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  // Date Picker
  DateTime nowDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: nowDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != nowDate)
      setState(() {
        // nowDate = pickedDate;
        currentDate = datetimeFormatter(pickedDate);
      });

    print("Picked Date::::::::::::::::::::::::::;");
    print(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final _todayController = Get.put(TodayController());
    _todayController.onStart();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: HexColor("#100F17"),
          ),
          FutureBuilder(
            future: _todayController.getnimazSchedule(currentDate),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                _todayController.notificationPeriodicTimer(
                    snapshot.data.data.timings.fajr,
                    snapshot.data.data.timings.dhuhr,
                    snapshot.data.data.timings.asr,
                    snapshot.data.data.timings.maghrib,
                    snapshot.data.data.timings.isha);
                _todayController.getNimaz(
                    snapshot.data.data.timings.fajr,
                    snapshot.data.data.timings.dhuhr,
                    snapshot.data.data.timings.asr,
                    snapshot.data.data.timings.maghrib,
                    snapshot.data.data.timings.isha);
                return Container(
                    child: Column(
                      children: <Widget>[
                        // Stack of Above Image, Isha text, Adnd location
                        Stack(
                          children: [
                            Container(
                              height: orientation == Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.3
                                  : MediaQuery.of(context).size.height * 0.4,
                              color: Colors.blueAccent,
                              child: Image.asset(
                                'assets/home_screen/main_frame.jpg',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: orientation == Orientation.portrait
                                    ? MediaQuery.of(context).size.height * 0.3
                                    : MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black54,),
                            ),
                            Center(
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: orientation == Orientation.portrait
                                            ? EdgeInsets.only(top: 70)
                                            : EdgeInsets.only(top: 5),
                                        child: Text(
                                            _todayController.showNimaz.toString(),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 40))),
                                    Padding(
                                        padding: orientation == Orientation.portrait
                                            ? EdgeInsets.only(top: 10)
                                            : EdgeInsets.only(top: 0),
                                        child: Text(
                                            _todayController.showNimaz.toString() ==
                                                "Fajar"
                                                ? delayNimazTime(
                                              DateTime.now(),
                                              snapshot.data.data.timings.fajr,
                                            )
                                                : _todayController.showNimaz
                                                .toString() ==
                                                "Dhuhr"
                                                ? delayNimazTime(
                                              DateTime.now(),
                                              snapshot
                                                  .data.data.timings.dhuhr,
                                            )
                                                : _todayController.showNimaz
                                                .toString() ==
                                                "Asr"
                                                ? delayNimazTime(
                                              DateTime.now(),
                                              snapshot
                                                  .data.data.timings.asr,
                                            )
                                                : _todayController.showNimaz
                                                .toString() ==
                                                "Maghrib"
                                                ? delayNimazTime(
                                              DateTime.now(),
                                              snapshot.data.data
                                                  .timings.maghrib,
                                            )
                                                : _todayController.showNimaz
                                                .toString() ==
                                                "Isha"
                                                ? delayNimazTime(
                                              DateTime.now(),
                                              snapshot.data.data
                                                  .timings.isha,
                                            )
                                                : getTheTime,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 30))),
                                    SizedBox(
                                        width: 200,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.location_on,
                                            color: HexColor('#16a884'),
                                            size: 30,
                                          ),
                                          title: Text(snapshot.data.data.meta.timezone,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15)),
                                        ))
                                  ],
                                )),
                          ],
                        ),
                        // hijrii BAr With Date
                        Container(
                            height: orientation == Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.14
                                : MediaQuery.of(context).size.height * 0.18,
                            color: HexColor('#2c2b3b'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: HexColor('#16a884'),
                                        size: 30,
                                      )),
                                  onTap: () {
                                    decrementDate();
                                  },
                                ),
                                Container(
                                    alignment: Alignment.topCenter,
                                    width: MediaQuery.of(context).size.width * 0.63,
                                    child: Padding(
                                        padding:
                                        EdgeInsets.only(left: 10, bottom: 32, top: 15),
                                        child: SizedBox(
                                          width: 230,
                                          child: ListTile(
                                            //  Hijrii
                                            title: Text(
                                                snapshot.data.data.date.hijri.day+" "+
                                                snapshot.data.data.date.hijri.month
                                                    .en +
                                                    ' ' +
                                                    snapshot
                                                        .data.data.date.hijri.year,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            // date
                                            subtitle: Center(
                                                child: Text(
                                                  snapshot.data.data.date.readable,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                )),
                                            trailing: GestureDetector(
                                                child: Image.asset(
                                                  'assets/home_screen/today.png',
                                                  height: 30,
                                                  width: 20,
                                                  color: HexColor('#16a884'),
                                                )),
                                            onTap: () {
                                              _selectDate(context);
                                              setState(() {});
                                            },
                                          ),
                                        ))),
                                GestureDetector(
                                    onTap: () {
                                      incrmentDate();
                                    },
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: HexColor('#16a884'),
                                          size: 30,
                                        ))),
                              ],
                            )),
                        // Body Part that Contains Nima name,time,alarm settings,
                        Container(
                            height: orientation == Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.46
                                : MediaQuery.of(context).size.height * 0.30,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  nimazTimeTile(
                                    'assets/home_screen/sunrise_for_calendar/sunrise.png',
                                    'Fajr',
                                    snapshot.data.data.timings.fajr,
                                    snapshot.data.data.timings.fajr,
                                  ),
                                  nimazTimeTile(
                                    'assets/home_screen/sunrise_for_calendar/sun.png',
                                    'Dhuhr',
                                    snapshot.data.data.timings.dhuhr,
                                    snapshot.data.data.timings.dhuhr,
                                  ),
                                  nimazTimeTile(
                                    'assets/home_screen/sunrise_for_calendar/sun.png',
                                    'Asr',
                                    snapshot.data.data.timings.asr,
                                    snapshot.data.data.timings.asr,
                                  ),
                                  nimazTimeTile(
                                    'assets/home_screen/sunrise_for_calendar/sunset.png',
                                    'Maghrib',
                                    snapshot.data.data.timings.maghrib,
                                    snapshot.data.data.timings.maghrib,
                                  ),
                                  nimazTimeTile(
                                    'assets/home_screen/sunrise_for_calendar/night.png',
                                    'Isha',
                                    snapshot.data.data.timings.isha,
                                    snapshot.data.data.timings.isha,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  // NomazTilee for each Nimaz
  Widget nimazTimeTile(
      String leadingicon,
      String nimazName,
      String nimazTime,
      String alaramIconTime,
      ) {
    final _todayController = Get.find<TodayController>();

    return Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
            Widget>[
          // Fetch the nimaz name and Shows Icon
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: ImageIcon(
                      AssetImage(leadingicon),
                      size: 25,
                      color: Colors.white,
                      // color: Color(0xFF3A5A98),
                    )),
                Text(
                  nimazName,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ])),

          // Alaram bell notification Icons With Time

          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(nimazTime,
                        style: TextStyle(color: Colors.white, fontSize: 17))),
                Obx(() => (nimazName == 'Fajr')
                    ? notifiationIcon('Fajr', _todayController.fajrflag)
                    : (nimazName == 'Dhuhr')
                    ? notifiationIcon('Dhuhr', _todayController.dhuhrflag)
                    : (nimazName == 'Asr')
                    ? notifiationIcon('Asr', _todayController.asrflag)
                    : (nimazName == 'Maghrib')
                    ? notifiationIcon(
                    'Maghrib', _todayController.maghribflag)
                    : (nimazName == 'Isha')
                    ? notifiationIcon(
                    'Isha', _todayController.ishaflag)
                    : ImageIcon(
                  AssetImage(
                      'assets/home_screen/notification.png'),
                  size: 25,
                  color: HexColor('#16a884'),
                )),
              ])),
        ]));
  }

// Notification Icon Enable and Disable Widget
  Widget notifiationIcon(String nimazName, RxInt iconChangeFlag) {
    final _todayController = Get.find<TodayController>();
    return GestureDetector(
        child: iconChangeFlag == 0
            ? ImageIcon(
          AssetImage('assets/home_screen/notification.png'),
          size: 25,
          color: HexColor('#16a884'),
        )
            : ImageIcon(
          AssetImage('assets/home_screen/notification.png'),
          size: 25,
          color: HexColor('#2c2b3b'),
        ),
        onTap: () {
          (nimazName == 'Fajr')
              ? _todayController.flagchangingFunction(
              'Fajr', _todayController.fajrflag)
              : (nimazName == 'Dhuhr')
              ? _todayController.flagchangingFunction(
              'Dhuhr', _todayController.dhuhrflag)
              : (nimazName == 'Asr')
              ? _todayController.flagchangingFunction(
              'Asr', _todayController.asrflag)
              : (nimazName == 'Maghrib')
              ? _todayController.flagchangingFunction(
              'Maghrib', _todayController.maghribflag)
              : (nimazName == 'Isha')
              ? _todayController.flagchangingFunction(
              'Isha', _todayController.ishaflag)
              : 'Null';
        });
  }
}