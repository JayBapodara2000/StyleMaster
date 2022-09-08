import 'package:flutter/material.dart';
import 'package:stylemaster/services/LoginServices.dart';
import 'package:stylemaster/models/LoginModel.dart';

class LoginProvider with ChangeNotifier {
  LoginModel post = LoginModel();

  getPostLoginData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await LoginServices.userLoginService(url, body))!;
  }
}
