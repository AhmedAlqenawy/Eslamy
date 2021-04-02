import 'package:flutter/cupertino.dart';
import 'package:player/models/reciter.dart';
import 'package:player/services/reciter-services.dart';

class RecitersProvider extends ChangeNotifier{
  List<Reciter> recitersList = [];
  get getRecitersList => recitersList;
  fetchRecitersList(String condition)async{
    recitersList = await ReciterApi().fetchRecitersList(condition);
    notifyListeners();
  }
}