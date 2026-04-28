// To parse this JSON data, do
//
//     final surahDetailResponseModel = surahDetailResponseModelFromJson(jsonString);

import 'dart:convert';

SurahDetailResponseModel surahDetailResponseModelFromJson(String str) =>
    SurahDetailResponseModel.fromJson(json.decode(str));

String surahDetailResponseModelToJson(SurahDetailResponseModel data) =>
    json.encode(data.toJson());

class SurahDetailResponseModel {
  int? code;
  String? status;
  SurahDetailModel? data;

  SurahDetailResponseModel({this.code, this.status, this.data});

  factory SurahDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      SurahDetailResponseModel(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null
            ? null
            : SurahDetailModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data?.toJson(),
  };
}

class SurahDetailModel {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  int? numberOfAyahs;
  List<AyahModel>? ayahs;
  EditionModel? edition;

  SurahDetailModel({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.numberOfAyahs,
    this.ayahs,
    this.edition,
  });

  factory SurahDetailModel.fromJson(Map<String, dynamic> json) =>
      SurahDetailModel(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        revelationType: json["revelationType"],
        numberOfAyahs: json["numberOfAyahs"],
        ayahs: json["ayahs"] == null
            ? []
            : List<AyahModel>.from(
                json["ayahs"]!.map((x) => AyahModel.fromJson(x)),
              ),
        edition: json["edition"] == null
            ? null
            : EditionModel.fromJson(json["edition"]),
      );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "englishName": englishName,
    "englishNameTranslation": englishNameTranslation,
    "revelationType": revelationType,
    "numberOfAyahs": numberOfAyahs,
    "ayahs": ayahs == null
        ? []
        : List<dynamic>.from(ayahs!.map((x) => x.toJson())),
    "edition": edition?.toJson(),
  };
}

class AyahModel {
  int? number;
  String? audio;
  List<String>? audioSecondary;
  String? text;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  bool? sajda;

  AyahModel({
    this.number,
    this.audio,
    this.audioSecondary,
    this.text,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) => AyahModel(
    number: json["number"],
    audio: json["audio"],
    audioSecondary: json["audioSecondary"] == null
        ? []
        : List<String>.from(json["audioSecondary"]!.map((x) => x)),
    text: json["text"],
    numberInSurah: json["numberInSurah"],
    juz: json["juz"],
    manzil: json["manzil"],
    page: json["page"],
    ruku: json["ruku"],
    hizbQuarter: json["hizbQuarter"],
    sajda: json["sajda"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "audio": audio,
    "audioSecondary": audioSecondary == null
        ? []
        : List<dynamic>.from(audioSecondary!.map((x) => x)),
    "text": text,
    "numberInSurah": numberInSurah,
    "juz": juz,
    "manzil": manzil,
    "page": page,
    "ruku": ruku,
    "hizbQuarter": hizbQuarter,
    "sajda": sajda,
  };
}

class EditionModel {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;
  dynamic direction;

  EditionModel({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
    this.direction,
  });

  factory EditionModel.fromJson(Map<String, dynamic> json) => EditionModel(
    identifier: json["identifier"],
    language: json["language"],
    name: json["name"],
    englishName: json["englishName"],
    format: json["format"],
    type: json["type"],
    direction: json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "language": language,
    "name": name,
    "englishName": englishName,
    "format": format,
    "type": type,
    "direction": direction,
  };
}
