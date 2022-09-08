import 'package:flutter/material.dart';
import 'package:stylemaster/models/GetservicelistModel.dart';
import 'package:stylemaster/services/GetservicelistServices.dart';

class GetservicelistProvider with ChangeNotifier {
  GetservicelistModel post = GetservicelistModel();

  getPostservicelistData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await GetservicelistServices.getservicelistService(url, body))!;
  }
}
