import 'package:flutter/material.dart';
import 'package:stylemaster/models/RegistrationModel.dart';
import 'package:stylemaster/services/RegistrationServices.dart';

class RegisterProvider with ChangeNotifier {
  RegistrationModel post = RegistrationModel();

  getPostRegisterData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await RegistrationServices.userRegisterService(url, body))!;
  }
}
