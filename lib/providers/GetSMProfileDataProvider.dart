import 'package:flutter/material.dart';
import 'package:stylemaster/models/GetSMProfileDataModel.dart';
import 'package:stylemaster/services/GetSMProfileDataServices.dart';

class GetSMProfileDataProvider with ChangeNotifier {
  GetSMProfileDataModel post = GetSMProfileDataModel();

  getPostSMprofiledata(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await GetSMProfileDataServices.getSMProfileDataService(url, body))!;
  }
}

