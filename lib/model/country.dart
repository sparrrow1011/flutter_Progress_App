

import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    required this.data,
  });

  final List<Datum> data;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.name,
    required this.iso2,
    required this.iso3,
    required this.unicodeFlag,
  });

  final String name;
  final String iso2;
  final String iso3;
  final String unicodeFlag;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    iso2: json["iso2"],
    iso3: json["iso3"],
    unicodeFlag: json["unicodeFlag"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "iso2": iso2,
    "iso3": iso3,
    "unicodeFlag": unicodeFlag,
  };
}

