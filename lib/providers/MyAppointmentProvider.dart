import 'package:flutter/material.dart';
import 'package:stylemaster/models/MyAppointmentModel.dart';
import 'package:stylemaster/services/MyAppointmentServices.dart';

class MyAppointmentProvider with ChangeNotifier {
  MyAppointmentModel post = MyAppointmentModel();

  getPostMyAppointmentData(String url, Object body) async {
    notifyListeners();
    return post =
        (await MyAppointmentServices.myAppointmentService(url, body))!;
  }
}
