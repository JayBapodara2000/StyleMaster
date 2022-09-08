import 'package:flutter/material.dart';
import 'package:stylemaster/models/GetStyleMasterListModel.dart';
import 'package:stylemaster/services/GetStyleMasterListServices.dart';

class GetStyleMasterListProvider with ChangeNotifier {
  GetStyleMasterListModel post = GetStyleMasterListModel();

  getPoststylemasterlist(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await GetStyleMasterListServices.getstylemasterlist(url, body))!;
  }
}

