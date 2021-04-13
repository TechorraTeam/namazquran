import 'package:Nimaz_App_Demo/Screens/BottomNavScreens/Quran.dart';
import 'package:Nimaz_App_Demo/Screens/quran_main_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:Nimaz_App_Demo/Screens/BottomNavScreens/More.dart';
import 'package:Nimaz_App_Demo/Screens/BottomNavScreens/Qibla/Qibla.dart';
import 'package:Nimaz_App_Demo/Screens/BottomNavScreens/Today.dart';
import 'package:Nimaz_App_Demo/Screens/BottomNavScreens/Today.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPageController extends GetxController {
  final Color navBarColor = HexColor('#2a2b3d');

  // Screens
  List<Widget> buildScreens() {
    return [TodaySection(), QiblaSection(), QuranMainScreen(), More()];
  }

// Botton Nav bar name, icons, that used above
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/home_screen/today.png',
        ),
        title: ("Prayer"),
        activeColorPrimary: HexColor('#16a884'),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/home_screen/kaaba.png',
        ),
        title: ("Qibla"),
        activeColorPrimary: HexColor('#16a884'),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/home_screen/quran.png'),
        title: ("Quran"),
        activeColorPrimary: HexColor('#16a884'),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.menu),
        title: ("More"),
        activeColorPrimary: HexColor('#16a884'),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
