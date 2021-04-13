
import 'package:Nimaz_App_Demo/Controllers/get_quran_data.dart';
import 'package:get/get.dart';

class QuranBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuranDataController>(() => QuranDataController());
  }
}