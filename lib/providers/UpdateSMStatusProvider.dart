import 'package:flutter/material.dart';
import 'package:stylemaster/models/UpdateSMStatusModel.dart';
import 'package:stylemaster/services/UpdateSMStatusServices.dart';

class UpdateSMStatusProvider with ChangeNotifier {
  UpdateSMStatusModel post = UpdateSMStatusModel();

  getPostUpdateSMStatus(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post =
        (await UpdateSMStatusServices.updateSMStatusService(url, body))!;
  }
}
