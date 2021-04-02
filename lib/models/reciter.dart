import 'package:flutter/cupertino.dart';

class ListOfReciters {
  ListOfReciters({
    @required this.reciters,
  });

  List<dynamic> reciters;

  factory ListOfReciters.fromJson(Map<String, dynamic> json) => ListOfReciters(
    reciters: json["reciters"]
  );
}

class Reciter {
  Reciter({
   @ required this.id,
   @ required this.name,
    @required this.server,
    @required this.rewaya,
    @required this.count,
    @required this.letter,
  });

  String id;
  String name;
  String server;
  String rewaya;
  String count;
  String letter;

  factory Reciter.fromJson(Map<String, dynamic> json) => Reciter(
    id: json["id"],
    name: json["name"],
    server: json["Server"],
    rewaya: json["rewaya"],
    count: json["count"],
    letter: json["letter"],
  );

}
