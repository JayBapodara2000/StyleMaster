import 'package:flutter/material.dart';
import 'package:stylemaster/models/ConfigureWorkSpaceModel.dart';
import 'package:stylemaster/services/ConfigureWorkSpaceServices.dart';

class ConfigureWorkSpaceProvider with ChangeNotifier {
  ConfigureWorkSpaceModel post = ConfigureWorkSpaceModel();

  getConfigureWorkSpaceData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await ConfigureWorkSpaceServices.configureWorkSpaceService(url, body))!;
  }
}
