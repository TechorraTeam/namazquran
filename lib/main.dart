import 'package:Nimaz_App_Demo/Bindings/mainPage_binding.dart';
import 'package:Nimaz_App_Demo/Bindings/qibla_bindings.dart';
import 'package:Nimaz_App_Demo/Bindings/quran_bindings.dart';
import 'package:Nimaz_App_Demo/Screens/BottomNavScreens/Qibla/Qibla.dart';
import 'package:flutter/material.dart';
import 'package:Nimaz_App_Demo/Screens/MainPage/MainScreen.dart';
import 'package:get/get.dart';

void main() {
  MainPageBindings().dependencies();
  QuranBinding().dependencies();
  QiblaBindings().dependencies();
  QuranBinding().dependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(name: "/MainPage", page: () => MainPage()),
        GetPage(
            name: "/QiblaSection",
            page: () => QiblaSection(),
            binding: QiblaBindings()),
        GetPage(
            name: "/QuranSection",
            page: () => MainPage(),
            binding: QuranBinding()),
      ],
      initialRoute: "/MainPage",
      // home: notification(title: "Fajar", body: "Fajar"),
    );
  }
}
