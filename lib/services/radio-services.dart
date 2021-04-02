import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player/models/radio-list.dart';

class RadioApi{
  Future<List<RadioModel>> fetchRadioList() async {
    try {
      var url = 'http://api.mp3quran.net/radios/radio_english.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        ListOfRadios rList = ListOfRadios.fromJson(extractedData);
        List radioList=rList.radios.map((e) => RadioModel.fromJson(e)).toList();
        return radioList;
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