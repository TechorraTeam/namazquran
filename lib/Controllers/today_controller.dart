import 'package:Nimaz_App_Demo/Notifiction/notificationPlugin.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:async';
import 'package:Nimaz_App_Demo/Model/prayer_time_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class User {
  String currentDate;
  String formattedTime;
  String nimazName;
  String getminutes;

  String showNimazTime;
  String pickDate;

  // String maghribflag;
  User({
    this.currentDate,
    this.formattedTime,
    this.nimazName,
    this.getminutes,
    this.showNimazTime,
    this.pickDate,
  });
}

class TodayController extends GetxController {
  static double pLat = 0.0;
  static double pLong = 0.0;
  RxInt fajrflag = 0.obs;
  RxInt dhuhrflag = 0.obs;
  RxInt asrflag = 0.obs;
  RxInt maghribflag = 0.obs;
  RxInt ishaflag = 0.obs;

  String showNimaz;
  String nameofNimaz;
  static final DateTime nowDate = DateTime.now();
  final user = User(
    getminutes: '23',
    nimazName: 'wer',
    showNimazTime: '',
    pickDate: '',
  ).obs;

// calling the model
  PrayerTimeModel prayerTimeModel = PrayerTimeModel();

  Future getnimazSchedule(String datetime) async {
    // user(User(maghribflag: 'true'));
    // print("Thi is flag:::::::::::::::::::::::::::::::::::::");
    // print(user().maghribflag);

    // uuse for get current location
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    pLat = position.latitude;
    pLong = position.longitude;

    final DateFormat formatter = DateFormat('yy-MM-dd');
    // method 4 for fatching the region
    int method = 4; //
    // Api number 1 from the aladhan.com/prayer_time , and I pick 11 uber api
    // bcz its contains the date, Latitude and ongitude that is used for get location
    DateTime datetimes;
    datetimes = DateTime.parse(datetime);
    if (datetime == null) {
      datetimes = new DateTime.now();
    }
    final String formatted = formatter.format(datetimes);

    final url =
        "http://api.aladhan.com/v1/timings/$formatted?latitude=$pLat&longitude=$pLong&method=$method";

    print(url);

    http.Response res = await http.get(Uri.encodeFull(url), headers: {
      "Accept":
      "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
    });

    final data = json.decode(res.body);
    print(data);
    prayerTimeModel = PrayerTimeModel.fromRawJson(res.body);
    print(prayerTimeModel.toJson());
    return prayerTimeModel;
  }

// ClosNitification BEll For nimaz
// void closeNificationRing(){
//   maghribflag.value=
// }

// Nimaz time controller
//
  Timer timer;
  void notificationPeriodicTimer(String fajar, zohar, asr, maghrib, isha) {
    timer = Timer.periodic(Duration(minutes: 1), (Timer t) async {
      DateTime now = DateTime.now();
      // print(DateFormat.Hm().format(now));
      user(User(formattedTime: DateFormat.Hm().format(now)));
      if (user().formattedTime == fajar) {
        if (fajrflag.value == 0) {
          await notificationPlugin.showNotification('Fajar',
              'Its Fajar Time. Allah Says: Call upon me I will responed you');
        }
        user(User(nimazName: 'Dhuhr'));
      }
      if (user().formattedTime == zohar) {
        if (dhuhrflag.value == 0) {
          await notificationPlugin.showNotification('Dhuhr',
              'Its Dhuhr Time. Allah Says: Call upon me I will responed you');
          user(User(nimazName: 'Asr'));
        }
      }
      if (user().formattedTime == asr) {
        if (asrflag.value == 0) {
          await notificationPlugin.showNotification('Asr',
              'Its Asr Time. Allah Says: Call upon me I will responed you');
        }
        user(User(nimazName: 'Maghrib'));
      }
      if (user().formattedTime == maghrib) {
        if (maghribflag.value == 0) {
          await notificationPlugin.showNotification('Maghrib',
              'Its Maghrib Time. Allah Says: Call upon me I will responed you');
        }

        user(User(nimazName: 'Isha'));
      }
      if (user().formattedTime == isha) {
        if (ishaflag.value == 0) {
          await notificationPlugin.showNotification('Isha',
              'Its Isha Time. Allah Says: Call upon me I will responed you');
        }
        user(User(nimazName: 'Fajar'));
      }
    });
  }

// getnimazName and Time When USe Start the application
  String ishNimazUpdateCheck;
  void getNimaz(String fjr, zohar, asar, mag, ish) {
    ishNimazUpdateCheck = 'false';
    DateTime now = DateTime.now();
    String nowTime = DateFormat.Hm().format(now);
    var format = DateFormat.Hm();
    // Fajar Section
    DateTime fjrtime = DateFormat('HH:mm').parse(fjr);
    String fjrtime2 = DateFormat.Hm().format(fjrtime);
    var fjrtime3 = format.parse(fjrtime2);
    // zohar Section
    DateTime zohartime = DateFormat('HH:mm').parse(zohar);
    String zohartime2 = DateFormat.Hm().format(zohartime);
    var zohartime3 = format.parse(zohartime2);
    // Asar Section
    DateTime asrtime = DateFormat('HH:mm').parse(asar);
    String asrtime2 = DateFormat.Hm().format(asrtime);
    var asrtime3 = format.parse(asrtime2);
    // Maghrib Section
    DateTime magtime = DateFormat('HH:mm').parse(mag);
    String magtime2 = DateFormat.Hm().format(magtime);
    var magtime3 = format.parse(magtime2);
    // Ishahrib Section
    DateTime ishatime = DateFormat('HH:mm').parse(ish);
    String ishatime2 = DateFormat.Hm().format(ishatime);
    var ishatime3 = format.parse(ishatime2);

    var nimazlist = new List(5);
    nimazlist[0] = fjrtime3;
    nimazlist[1] = zohartime3;
    nimazlist[2] = asrtime3;
    nimazlist[3] = magtime3;
    nimazlist[4] = ishatime3;
    var nimaz_Diff = new List(5);
    // var nimaz_minutes_Diff = new List(5);

    for (int i = 0; i < 5; i++) {
      var timeNow = format.parse(nowTime);

      String diff = "${nimazlist[i].difference(timeNow)}".substring(0, 2);
      if (diff != null) {
        if (diff.contains(':')) {
          diff = diff.substring(0, 1);
        }

        print(int.parse(diff));

        nimaz_Diff[i] = diff;
      } else {
        nimaz_Diff[i] = diff;
      }
    }

    int smallest_value = int.parse(nimaz_Diff[0]);
    // incex number for finding the name of nimaz
    int index_number = 0;
    // int zero_index;

    for (int i = 0; i < nimaz_Diff.length; i++) {
      if (nimaz_Diff[i].toString().contains('-')) {
        nimaz_Diff[i] = '12';
        index_number++;
      }
    }
    // //Loop through the array
    for (int i = 0; i < nimaz_Diff.length; i++) {
      //Compare elements of array with min and less then 2 bcz between  we want to elemniate the smaller value bcz its will not chnage the name of nimaz

      if (int.parse(nimaz_Diff[i]) < smallest_value) {
        smallest_value = int.parse(nimaz_Diff[i]);
        index_number = i;
      }
    }
    // print("Nimazzzzzzzzzzzzzzzzzzz Minutess Differenceeeeeeeeeeeeeeeee:::::;");
    // print(nimaz_minutes_Diff);

    print("Smallest value in the list : ${smallest_value}");

    print(index_number);
    index_number == 0
        ? user(User(nimazName: 'Fajar'))
        : index_number == 1
        ? user(User(nimazName: 'Dhuhr'))
        : index_number == 2
        ? user(User(nimazName: 'Asr'))
        : index_number == 3
        ? user(User(nimazName: 'Maghrib'))
        : index_number == 4
        ? user(User(nimazName: 'Isha'))
        : user(User(nimazName: 'Fajar'));

    showNimaz = user().nimazName;
    print("Nimaz");
    print(nimazlist);
    print("Difference::::");
    print(nimaz_Diff);

    // user(User(showNimazName: user().nimazName));

    print("Assigned nimaz");
    print(showNimaz);
    print(user().nimazName);
  }

// Notification Flag Changer Function;;
  void flagchangingFunction(String nimazName, RxInt flagValue) {
    // print("tapeddddddddddddddddddddddddddddddddddddd");
    if (flagValue.value == 0) {
      // print(nimazName + "::::::::: Tappedd:");
      flagValue.value = 1;
    } else {
      flagValue.value = 0;
    }
    // print("Thi is flag:::::::::::::::::::::::::::::::::::::");
    print(flagValue.value);
  }
}