import 'package:Nimaz_App_Demo/Controllers/mainPage_controller.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() => MainPageController());
    Get.put(PersistentTabController());
  }
}
