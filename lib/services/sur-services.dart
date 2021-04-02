import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player/models/sura-list.dart';

class SurApi{
  Future<List<SuraModel>> fetchSurList() async {
    try {
      var url = 'https://api.quran.com/api/v4/chapters?language=ar';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        ListOfSurModel sList = ListOfSurModel.fromJson(extractedData);
        List surList=[];
        surList=sList.chapters.map((e) => SuraModel.fromJson(e)).toList();
        return surList;
      }
      else {
        //print(response.statusCode);
      }
      return [];
    }
    catch (e) {
      print(e);
      return null;
    }
  }
}