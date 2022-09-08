import 'package:flutter/material.dart';
import 'package:stylemaster/models/EmailANDMobileValidationModel.dart';
import 'package:stylemaster/services/EmailANDMobileValidationServices.dart';
class EmailAndMobileValidationProvider with ChangeNotifier {
  EmailAndMobileValidationModel post = EmailAndMobileValidationModel();

  getPostEmailAndMobileValidationData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post =
    (await EmailAndMobileValidationServices.emailAndMobileValidationService(
        url, body))!;
  }
}


