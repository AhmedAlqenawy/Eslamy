import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player/models/reciter.dart';

class ReciterApi{
  Future<List<Reciter>> fetchRecitersList(String condition) async {
    try {
      var url = 'https://mp3quran.net/api/_arabic.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        ListOfReciters recitersList = ListOfReciters.fromJson(extractedData);
        List<Reciter> all=recitersList.reciters.map((e) => Reciter.fromJson(e)).toList();
        return all.where((element) => element.count=="114" && (condition=='all'? true:element.rewaya==condition)).toList();
      }
      else {
        print(response.statusCode);
      }
      return [];
    }
    catch (e) {
      print(e);
      return null;
    }
  }
}