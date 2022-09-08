import 'package:flutter/material.dart';
import 'package:stylemaster/models/OfflineAppointmentModel.dart';
import 'package:stylemaster/services/OfflineAppointmentServices.dart';

class OfflineAppointmentProvider with ChangeNotifier {
  OfflineAppointmentModel post = OfflineAppointmentModel();

  getPostOfflineAppointmentdata(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await OfflineAppointmentServices.offlineAppointment(url, body))!;
  }
}

