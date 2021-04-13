// To parse this JSON data, do
//
//     final prayerCalendarModel = prayerCalendarModelFromJson(jsonString);

import 'dart:convert';

class PrayerCalendarModel {
  PrayerCalendarModel({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  List<Datum> data;

  factory PrayerCalendarModel.fromRawJson(String str) => PrayerCalendarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrayerCalendarModel.fromJson(Map<String, dynamic> json) => PrayerCalendarModel(
    code: json["code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.timings,
    this.date,
    this.meta,
  });

  Timings timings;
  Date date;
  Meta meta;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    this.gregorian,
    this.hijri,
  });

  String readable;
  String timestamp;
  Gregorian gregorian;
  Hijri hijri;

  factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    readable: json["readable"],
    timestamp: json["timestamp"],
    gregorian: Gregorian.fromJson(json["gregorian"]),
    hijri: Hijri.fromJson(json["hijri"]),
  );

  Map<String, dynamic> toJson() => {
    "readable": readable,
    "timestamp": timestamp,
    "gregorian": gregorian.toJson(),
    "hijri": hijri.toJson(),
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
  Format format;
  String day;
  GregorianWeekday weekday;
  GregorianMonth month;
  String year;
  Designation designation;

  factory Gregorian.fromRawJson(String str) => Gregorian.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
    date: json["date"],
    format: formatValues.map[json["format"]],
    day: json["day"],
    weekday: GregorianWeekday.fromJson(json["weekday"]),
    month: GregorianMonth.fromJson(json["month"]),
    year: json["year"],
    designation: Designation.fromJson(json["designation"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "format": formatValues.reverse[format],
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

  Abbreviated abbreviated;
  Expanded expanded;

  factory Designation.fromRawJson(String str) => Designation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    abbreviated: abbreviatedValues.map[json["abbreviated"]],
    expanded: expandedValues.map[json["expanded"]],
  );

  Map<String, dynamic> toJson() => {
    "abbreviated": abbreviatedValues.reverse[abbreviated],
    "expanded": expandedValues.reverse[expanded],
  };
}

enum Abbreviated { AD, AH }

final abbreviatedValues = EnumValues({
  "AD": Abbreviated.AD,
  "AH": Abbreviated.AH
});

enum Expanded { ANNO_DOMINI, ANNO_HEGIRAE }

final expandedValues = EnumValues({
  "Anno Domini": Expanded.ANNO_DOMINI,
  "Anno Hegirae": Expanded.ANNO_HEGIRAE
});

enum Format { DD_MM_YYYY }

final formatValues = EnumValues({
  "DD-MM-YYYY": Format.DD_MM_YYYY
});

class GregorianMonth {
  GregorianMonth({
    this.number,
    this.en,
  });

  int number;
  PurpleEn en;

  factory GregorianMonth.fromRawJson(String str) => GregorianMonth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
    number: json["number"],
    en: purpleEnValues.map[json["en"]],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "en": purpleEnValues.reverse[en],
  };
}

enum PurpleEn { APRIL }

final purpleEnValues = EnumValues({
  "April": PurpleEn.APRIL
});

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
    this.holidays,
  });

  String date;
  Format format;
  String day;
  HijriWeekday weekday;
  HijriMonth month;
  String year;
  Designation designation;
  List<String> holidays;

  factory Hijri.fromRawJson(String str) => Hijri.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
    date: json["date"],
    format: formatValues.map[json["format"]],
    day: json["day"],
    weekday: HijriWeekday.fromJson(json["weekday"]),
    month: HijriMonth.fromJson(json["month"]),
    year: json["year"],
    designation: Designation.fromJson(json["designation"]),
    holidays: List<String>.from(json["holidays"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "format": formatValues.reverse[format],
    "day": day,
    "weekday": weekday.toJson(),
    "month": month.toJson(),
    "year": year,
    "designation": designation.toJson(),
    "holidays": List<dynamic>.from(holidays.map((x) => x)),
  };
}

class HijriMonth {
  HijriMonth({
    this.number,
    this.en,
    this.ar,
  });

  int number;
  FluffyEn en;
  Ar ar;

  factory HijriMonth.fromRawJson(String str) => HijriMonth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
    number: json["number"],
    en: fluffyEnValues.map[json["en"]],
    ar: arValues.map[json["ar"]],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "en": fluffyEnValues.reverse[en],
    "ar": arValues.reverse[ar],
  };
}

enum Ar { EMPTY, AR }

final arValues = EnumValues({
  "رَمَضان": Ar.AR,
  "شَعْبان": Ar.EMPTY
});

enum FluffyEn { SHA_BN, RAMAN }

final fluffyEnValues = EnumValues({
  "Ramaḍān": FluffyEn.RAMAN,
  "Shaʿbān": FluffyEn.SHA_BN
});

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
    this.latitude,
    this.longitude,
    this.timezone,
    this.method,
    this.latitudeAdjustmentMethod,
    this.midnightMode,
    this.school,
    this.offset,
  });

  double latitude;
  double longitude;
  Timezone timezone;
  Method method;
  LatitudeAdjustmentMethod latitudeAdjustmentMethod;
  MidnightMode midnightMode;
  MidnightMode school;
  Map<String, int> offset;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    timezone: timezoneValues.map[json["timezone"]],
    method: Method.fromJson(json["method"]),
    latitudeAdjustmentMethod: latitudeAdjustmentMethodValues.map[json["latitudeAdjustmentMethod"]],
    midnightMode: midnightModeValues.map[json["midnightMode"]],
    school: midnightModeValues.map[json["school"]],
    offset: Map.from(json["offset"]).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "timezone": timezoneValues.reverse[timezone],
    "method": method.toJson(),
    "latitudeAdjustmentMethod": latitudeAdjustmentMethodValues.reverse[latitudeAdjustmentMethod],
    "midnightMode": midnightModeValues.reverse[midnightMode],
    "school": midnightModeValues.reverse[school],
    "offset": Map.from(offset).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

enum LatitudeAdjustmentMethod { ANGLE_BASED }

final latitudeAdjustmentMethodValues = EnumValues({
  "ANGLE_BASED": LatitudeAdjustmentMethod.ANGLE_BASED
});

class Method {
  Method({
    this.id,
    this.name,
    this.params,
  });

  int id;
  Name name;
  Params params;

  factory Method.fromRawJson(String str) => Method.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Method.fromJson(Map<String, dynamic> json) => Method(
    id: json["id"],
    name: nameValues.map[json["name"]],
    params: Params.fromJson(json["params"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "params": params.toJson(),
  };
}

enum Name { ISLAMIC_SOCIETY_OF_NORTH_AMERICA_ISNA }

final nameValues = EnumValues({
  "Islamic Society of North America (ISNA)": Name.ISLAMIC_SOCIETY_OF_NORTH_AMERICA_ISNA
});

class Params {
  Params({
    this.fajr,
    this.isha,
  });

  int fajr;
  int isha;

  factory Params.fromRawJson(String str) => Params.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    fajr: json["Fajr"],
    isha: json["Isha"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr,
    "Isha": isha,
  };
}

enum MidnightMode { STANDARD }

final midnightModeValues = EnumValues({
  "STANDARD": MidnightMode.STANDARD
});

enum Timezone { EUROPE_LONDON }

final timezoneValues = EnumValues({
  "Europe/London": Timezone.EUROPE_LONDON
});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
