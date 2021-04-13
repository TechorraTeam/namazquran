import 'package:Nimaz_App_Demo/Controllers/mainPage_controller.dart';
import 'package:Nimaz_App_Demo/Notifiction/Notification.dart';
import 'package:Nimaz_App_Demo/Notifiction/notificationPlugin.dart';
import 'package:Nimaz_App_Demo/Notifiction/notificationScreens.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'dart:async';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final _quranController = Get.find<MainPageController>();
    final _persistantTaBController = Get.find<PersistentTabController>();
    // persistant Tab change the Style olor and items, screens
    return PersistentTabView(
      context,
      controller: _persistantTaBController,
      screens: _quranController.buildScreens(),
      items: _quranController.navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: _quranController.navBarColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        // borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}
