// To parse this JSON data, do
//
//     final prayerTimeModel = prayerTimeModelFromJson(jsonString);

import 'dart:convert';

class PrayerTimeModel {
  PrayerTimeModel({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  Data data;

  factory PrayerTimeModel.fromRawJson(String str) => PrayerTimeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) => PrayerTimeModel(
    code: json["code"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.timings,
    this.date,
    this.meta,
  });

  Timings timings;
  Date date;
  Meta meta;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    timings: Timings.fromJson(json["timings"]),
    date: Date.fromJson(json["date"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "timings": timings.toJson(),
    "date": date.toJson(),
    "meta": meta.toJson(),
  };
}

class Date {
  Date({
    this.readable,
    this.timestamp,
    this.hijri,
    this.gregorian,
  });

  String readable;
  String timestamp;
  Hijri hijri;
  Gregorian gregorian;

  factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    readable: json["readable"],
    timestamp: json["timestamp"],
    hijri: Hijri.fromJson(json["hijri"]),
    gregorian: Gregorian.fromJson(json["gregorian"]),
  );

  Map<String, dynamic> toJson() => {
    "readable": readable,
    "timestamp": timestamp,
    "hijri": hijri.toJson(),
    "gregorian": gregorian.toJson(),
  };
}

class Gregorian {
  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
  });

  String date;
  String format;
  String day;
  GregorianWeekday weekday;
  GregorianMonth month;
  String year;
  Designation designation;

  factory Gregorian.fromRawJson(String str) => Gregorian.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
    date: json["date"],
    format: json["format"],
    day: json["day"],
    weekday: GregorianWeekday.fromJson(json["weekday"]),
    month: GregorianMonth.fromJson(json["month"]),
    year: json["year"],
    designation: Designation.fromJson(json["designation"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "format": format,
    "day": day,
    "weekday": weekday.toJson(),
    "month": month.toJson(),
    "year": year,
    "designation": designation.toJson(),
  };
}

class Designation {
  Designation({
    this.abbreviated,
    this.expanded,
  });

  String abbreviated;
  String expanded;

  factory Designation.fromRawJson(String str) => Designation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    abbreviated: json["abbreviated"],
    expanded: json["expanded"],
  );

  Map<String, dynamic> toJson() => {
    "abbreviated": abbreviated,
    "expanded": expanded,
  };
}

class GregorianMonth {
  GregorianMonth({
    this.number,
    this.en,
  });

  int number;
  String en;

  factory GregorianMonth.fromRawJson(String str) => GregorianMonth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
    number: json["number"],
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "en": en,
  };
}

class GregorianWeekday {
  GregorianWeekday({
    this.en,
  });

  String en;

  factory GregorianWeekday.fromRawJson(String str) => GregorianWeekday.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) => GregorianWeekday(
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
  };
}

class Hijri {
  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
  });

  String date;
  String format;
  String day;
  HijriWeekday weekday;
  HijriMonth month;
  String year;
  Designation designation;

  factory Hijri.fromRawJson(String str) => Hijri.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
    date: json["date"],
    format: json["format"],
    day: json["day"],
    weekday: HijriWeekday.fromJson(json["weekday"]),
    month: HijriMonth.fromJson(json["month"]),
    year: json["year"],
    designation: Designation.fromJson(json["designation"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "format": format,
    "day": day,
    "weekday": weekday.toJson(),
    "month": month.toJson(),
    "year": year,
    "designation": designation.toJson(),
  };
}

class HijriMonth {
  HijriMonth({
    this.number,
    this.en,
    this.ar,
  });

  int number;
  String en;
  String ar;

  factory HijriMonth.fromRawJson(String str) => HijriMonth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
    number: json["number"],
    en: json["en"],
    ar: json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "en": en,
    "ar": ar,
  };
}

class HijriWeekday {
  HijriWeekday({
    this.en,
    this.ar,
  });

  String en;
  String ar;

  factory HijriWeekday.fromRawJson(String str) => HijriWeekday.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
    en: json["en"],
    ar: json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "ar": ar,
  };
}

class Meta {
  Meta({

    this.timezone,

    this.school,
  });


  String timezone;

  String school;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    timezone: json["timezone"],
    school: json["school"],
  );

  Map<String, dynamic> toJson() => {

    "timezone": timezone,

    "school": school,
  };
}

class Timings {
  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
  });

  String fajr;
  String sunrise;
  String dhuhr;
  String asr;
  String sunset;
  String maghrib;
  String isha;
  String imsak;
  String midnight;

  factory Timings.fromRawJson(String str) => Timings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
    fajr: json["Fajr"],
    sunrise: json["Sunrise"],
    dhuhr: json["Dhuhr"],
    asr: json["Asr"],
    sunset: json["Sunset"],
    maghrib: json["Maghrib"],
    isha: json["Isha"],
    imsak: json["Imsak"],
    midnight: json["Midnight"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr,
    "Sunrise": sunrise,
    "Dhuhr": dhuhr,
    "Asr": asr,
    "Sunset": sunset,
    "Maghrib": maghrib,
    "Isha": isha,
    "Imsak": imsak,
    "Midnight": midnight,
  };
}
