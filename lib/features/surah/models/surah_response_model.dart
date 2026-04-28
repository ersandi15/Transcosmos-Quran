// To parse this JSON data, do
//
//     final surahResponseModel = surahResponseModelFromJson(jsonString);

import 'dart:convert';

SurahResponseModel surahResponseModelFromJson(String str) =>
    SurahResponseModel.fromJson(json.decode(str));

String surahResponseModelToJson(SurahResponseModel data) =>
    json.encode(data.toJson());

class SurahResponseModel {
  int? code;
  String? status;
  List<SurahModel>? data;

  SurahResponseModel({this.code, this.status, this.data});

  factory SurahResponseModel.fromJson(Map<String, dynamic> json) =>
      SurahResponseModel(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<SurahModel>.from(
                json["data"]!.map((x) => SurahModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SurahModel {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? revelationType;

  SurahModel({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
    number: json["number"],
    name: json["name"],
    englishName: json["englishName"],
    englishNameTranslation: json["englishNameTranslation"],
    numberOfAyahs: json["numberOfAyahs"],
    revelationType: json["revelationType"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "englishName": englishName,
    "englishNameTranslation": englishNameTranslation,
    "numberOfAyahs": numberOfAyahs,
    "revelationType": revelationType,
  };
}
