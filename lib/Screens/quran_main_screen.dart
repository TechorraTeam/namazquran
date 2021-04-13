
import 'package:Nimaz_App_Demo/Controllers/get_quran_data.dart';
import 'package:Nimaz_App_Demo/Screens/quran_sub_list_screen.dart';
import 'package:Nimaz_App_Demo/constants/my_decoration.dart';
import 'package:Nimaz_App_Demo/constants/my_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class QuranMainScreen extends StatefulWidget {
  static double heightStep, widthStep;

  @override
  _QuranMainScreenState createState() => _QuranMainScreenState();
}

class _QuranMainScreenState extends State<QuranMainScreen> {
  QuranDataController quranDataController = Get.put(QuranDataController());
  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 2.0,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        "Quran",
        style: myTextStyle,
      ),
    );
  }

  Widget _buildSingleMainContainer(
      {String count, String arabicTitle, String totalAyahs, String revelationType,
        String title, String subTitle, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(30)
        ),
        margin: EdgeInsets.only(top: 15, left: 5, right: 5),
        height: QuranMainScreen.heightStep * 140,
        alignment: Alignment.center,
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: QuranMainScreen.heightStep * 38,
            backgroundColor: Colors.black,
            backgroundImage: AssetImage(
              "assets/images/star.png",
            ),
            child: Text(
              count,
              style: TextStyle(
                color: Colors.lightGreenAccent.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          title: Text(
            title,
            style: myTextStyle,
          ),
          subtitle: Text(
            subTitle,
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                arabicTitle,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                revelationType,
                style: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontSize: 10,
                ),
              ),
              Text(
                totalAyahs + ' verses',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    QuranMainScreen.widthStep = MediaQuery.of(context).size.width / 1000;
    QuranMainScreen.heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _buildMyAppBar(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: myDecoration,
        padding: EdgeInsets.symmetric(
          vertical: QuranMainScreen.widthStep * 30,
        ),
        child: GetBuilder<QuranDataController>(
          init: quranDataController,
          initState: quranDataController.getQuranData(),
          builder: (controller) {
            return quranDataController.surahModelList.isEmpty? Center(child: CircularProgressIndicator(),)
                :SafeArea(
              child: ListView.builder(
                itemCount: controller.surahModelList.length,
                itemBuilder: (ctx, index) {
                  return _buildSingleMainContainer(
                      count: controller.surahModelList[index].number.toString(),
                      onTap: () {
                        controller.getQuranAyahData(name: controller.surahModelList[index].englishName,
                          number: controller.surahModelList[index].number.toString(),);
                        Get.to(QuranSubListScreen(
                          name: controller.surahModelList[index].englishName,
                          surahNumber: controller.surahModelList[index].number.toString(),
                        ));
                      },
                      subTitle: controller.surahModelList[index].englishNameTranslation,
                      title: controller.surahModelList[index].englishName,
                      arabicTitle: controller.surahModelList[index].name,
                      revelationType: controller.surahModelList[index].revelationType,
                      totalAyahs: controller.surahModelList[index].numberOfAyahs.toString()
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
