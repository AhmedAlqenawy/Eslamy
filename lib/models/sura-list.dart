import 'package:flutter/cupertino.dart';

class ListOfSurModel {
  ListOfSurModel({
    @required this.chapters,
  });

  List<dynamic> chapters;

  factory ListOfSurModel.fromJson(Map<String, dynamic> json) => ListOfSurModel(
    chapters: json["chapters"],
  );

}

class SuraModel {
  SuraModel({
    @required this.id,
    @required this.revelationPlace,
    @required this.revelationOrder,
    @required this.bismillahPre,
    @required this.nameSimple,
    @required this.nameComplex,
    @required this.nameArabic,
    @required this.versesCount,
    @required this.pages,
  });

  int id;
  String revelationPlace;
  int revelationOrder;
  bool bismillahPre;
  String nameSimple;
  String nameComplex;
  String nameArabic;
  int versesCount;
  List<int> pages;

  factory SuraModel.fromJson(Map<String, dynamic> json) => SuraModel(
    id: json["id"],
    revelationPlace: json["revelation_place"],
    revelationOrder: json["revelation_order"],
    bismillahPre: json["bismillah_pre"],
    nameSimple: json["name_simple"],
    nameComplex: json["name_complex"],
    nameArabic: json["name_arabic"],
    versesCount: json["verses_count"],
    pages: List<int>.from(json["pages"].map((x) => x)),
  );

}

