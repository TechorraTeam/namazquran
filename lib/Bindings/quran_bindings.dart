import 'package:Nimaz_App_Demo/Controllers/today_controller.dart';
import 'package:get/get.dart';

class QuranBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodayController>(() => TodayController());
  }
}
