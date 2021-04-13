
import 'package:Nimaz_App_Demo/Controllers/get_quran_data.dart';
import 'package:Nimaz_App_Demo/Screens/quran_main_screen.dart';
import 'package:Nimaz_App_Demo/constants/my_decoration.dart';
import 'package:Nimaz_App_Demo/constants/my_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class QuranSubListScreen extends StatelessWidget {
  final String name;
  final String surahNumber;

  QuranSubListScreen({
    this.name, this.surahNumber
  });

  static TextStyle myStyle;
  QuranDataController quranDataController = Get.find();
  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          quranDataController.stopAudio();
          Get.back();
        },
      ),
      title: Text(
        name,
        style: myTextStyle,
      ),
    );
  }

  Widget _buildSingleTextContainer({String count, String textArabic, String audioLink, String textEnglish, String textTrans, String totalNumber, int index}) {
    return InkWell(
      onTap: (){
        quranDataController.playAudio(index, audioLink);
      },
      child: GetBuilder<QuranDataController>(
        init: quranDataController,
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
                color: controller.playAyah.isNotEmpty && controller.playAyah[index]?Colors.white24:Colors.white10,
                borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.only(top: widthStep * 30, left: 5, right: 5),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: controller.playAyah.isNotEmpty && controller.playAyah[index]?
                  Container(
                    width: 20,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/play.png',
                        ),
                      ),
                    ),
                  ):Container(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: widthStep * 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                maxRadius: QuranMainScreen.heightStep * 25,
                                backgroundColor: Colors.black,
                                backgroundImage: AssetImage(
                                  "assets/images/star.png",
                                ),
                                child: Text(
                                  count,
                                  style: TextStyle(
                                    color: Colors.lightGreenAccent.shade700,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                width: widthStep*750,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    textArabic,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.green.shade300,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Text(
                              textTrans,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.limeAccent,
                                      fontSize: 14,
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Text(
                              textEnglish,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          );
        }
      ),
    );
  }

  static double heightStep, widthStep;
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    myStyle = TextStyle(
      fontSize: widthStep * 45,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
    );
    QuranDataController getQuranData = QuranDataController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildMyAppBar(context),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: heightStep * 20),
        decoration: myDecoration,
        child: SafeArea(
          child: FutureBuilder(
              future: getQuranData.getQuranAyahData(name: name, number: surahNumber),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, index) {
                        return _buildSingleTextContainer(
                          count: snapshot.data[index].numberInSurah.toString(),
                          textArabic: snapshot.data[index].textArabic,
                          textEnglish: snapshot.data[index].textEnglish,
                          totalNumber: snapshot.data[index].ayahNumber,
                          audioLink: snapshot.data[index].audioLink,
                          textTrans: snapshot.data[index].textTrans,
                          index: index,
                        );
                      }
                      );

                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
