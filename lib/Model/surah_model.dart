import 'dart:convert';

SurahModel surahModelFromMap(String str) => SurahModel.fromMap(json.decode(str));

String surahModelToMap(SurahModel data) => json.encode(data.toMap());

class SurahModel {
  SurahModel({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  String revelationType;

  factory SurahModel.fromMap(Map<String, dynamic> json) => SurahModel(
    number: json["number"],
    name: json["name"],
    englishName: json["englishName"],
    englishNameTranslation: json["englishNameTranslation"],
    numberOfAyahs: json["numberOfAyahs"],
    revelationType: json["revelationType"],
  );

  Map<String, dynamic> toMap() => {
    "number": number,
    "name": name,
    "englishName": englishName,
    "englishNameTranslation": englishNameTranslation,
    "numberOfAyahs": numberOfAyahs,
    "revelationType": revelationType,
  };
}