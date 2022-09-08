import 'package:flutter/material.dart';
import 'package:stylemaster/models/GetCityAutoModel.dart';
import 'package:stylemaster/services/GetCityAutoServices.dart';

class GetCityAutoProvider with ChangeNotifier {
  GetCityAutoModel post = GetCityAutoModel();

  getPostGetCityAutoData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await GetCityAutoServices.getCityAutoServices(url, body))!;
  }
}
