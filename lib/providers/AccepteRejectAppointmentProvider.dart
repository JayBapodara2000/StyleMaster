import 'package:flutter/material.dart';
import 'package:stylemaster/models/AccepteRejectAppointmentModel.dart';
import 'package:stylemaster/services/AccepteRejectAppointmentServices.dart';

class AccepteRejectAppointmentProvider with ChangeNotifier {
  AccepteRejectAppointmentModel post = AccepteRejectAppointmentModel();

  getPostAccepteRejectAppointmentData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await AccepteRejectAppointmentServices
        .accepteAndRejectAppointmentService(url, body))!;
  }
}
