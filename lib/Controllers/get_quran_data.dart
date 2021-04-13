
import 'package:Nimaz_App_Demo/Model/ayat_model.dart';
import 'package:Nimaz_App_Demo/Model/surah_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class QuranDataController extends GetxController {
  List<SurahModel> surahModelList = [];
  List<AyahsModel> ayahsModelList = [];
  List<bool> playAyah = [];
  AudioPlayer audioPlayer = AudioPlayer();


  int currentIndex = 0;

  getQuranData(){
    if(surahModelList.isNotEmpty) return;
    String url = "https://api.alquran.cloud/v1/surah";
    http.get(url).then((response){
      var responseData = jsonDecode(response.body);
      if (responseData["status"] == "OK") {
        responseData["data"].forEach((element) {
          SurahModel _surahModel = SurahModel.fromMap(element);
          surahModelList.add(_surahModel);
          update();
        });
      }
    });

  }

  Future<List<AyahsModel>> getQuranAyahData({String name, String number}) async {
    ayahsModelList = [];
    playAyah = [];
    String url = "http://api.alquran.cloud/v1/surah/$number/ar.alafasy";
    String urlAsad = "http://api.alquran.cloud/v1/surah/$number/en.asad";
    String urlEng = "https://api.quran.sutanlab.id/surah/$number/";

    http.Response response = await http.get(Uri.encodeFull(url));
    http.Response responseAsad = await http.get(Uri.encodeFull(urlAsad));
    http.Response responseEng = await http.get(Uri.encodeFull(urlEng));


    var responseData = jsonDecode(response.body);
    var responseDataAsad = jsonDecode(responseAsad.body);
    var responseDataEng = jsonDecode(responseEng.body);


    if (responseData["status"] == "OK") {
      responseData["data"]["ayahs"].forEach((element) {
            AyahsModel _ayahsModel = AyahsModel(
                numberInSurah: element["numberInSurah"],
                ayahNumber: element['number'].toString(),
                textArabic: element["text"],
                audioLink: element['audio']
            );
            ayahsModelList.add(_ayahsModel);
            playAyah.add(false);
            update();
      });
    }

    if (responseDataAsad["status"] == "OK") {
      for(int i = 0; i < ayahsModelList.length; i++){
        ayahsModelList[i].textEnglish = responseDataAsad['data']['ayahs'][i]['text'];
      }
    }

    if(responseDataEng["code"] == 200){
      for(int i = 0; i < ayahsModelList.length; i++){
        ayahsModelList[i].textTrans = responseDataEng['data']['verses'][i]['text']['transliteration']['en'];
      }
    }
    return ayahsModelList;
  }

  updatePlayingBool(index, value){
    playAyah[index] = value;
    update();
  }

  resetAllAudio(){
    playAyah = List.filled(playAyah.length, false);
    stopAudio();
    update();
  }

  playAudio(index, audioLink){
    if(audioPlayer.playing){
      resetAllAudio();
      if(currentIndex != index)
      audioPlayer.setUrl(audioLink).then((value){
        audioPlayer.play();
        updatePlayingBool(index, true);
      });
      else{
        resetAllAudio();
      }
    }else{
      audioPlayer.setUrl(audioLink).then((value){
        audioPlayer.play();
        updatePlayingBool(index, true);
      });
    }
    currentIndex = index;

  }

  stopAudio(){
    if(audioPlayer.playing){
      audioPlayer.stop();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    audioPlayer.playerStateStream.listen((event) {
      if(event.processingState == ProcessingState.completed){
        resetAllAudio();
        if(currentIndex >= ayahsModelList.length-1) return;
        playAudio(currentIndex+1, ayahsModelList[currentIndex+1].audioLink);
        //_scrollToIndex(currentIndex);
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    audioPlayer.dispose();
    super.onClose();
  }

}
