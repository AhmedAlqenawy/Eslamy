import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:player/models/sura-list.dart';
import 'package:player/services/sur-services.dart';

class SurController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    fetchSurList();
  }

  List<SuraModel> surList = List<SuraModel>().obs;
  var isLoading=false.obs;
  fetchSurList()async{
    isLoading(true);
    surList = await SurApi().fetchSurList();
    isLoading(false);
  }
}