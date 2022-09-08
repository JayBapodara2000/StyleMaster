import 'package:flutter/material.dart';
import 'package:stylemaster/models/AddstyleMasterModel.dart';
import 'package:stylemaster/services/AddstyleMasterServices.dart';

class AddstyleMasterProvider with ChangeNotifier {
  AddstyleMasterModel post = AddstyleMasterModel();

  getPostaddstyleMasterData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await AddstyleMasterServices.addstyleMasterService(url, body))!;
  }
}
