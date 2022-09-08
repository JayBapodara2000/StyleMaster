import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stylemaster/models/MyAppointmentModel.dart';

class MyAppointmentServices {
  static Future<MyAppointmentModel?> myAppointmentService(
      String url, Object body) async {
    MyAppointmentModel? result;

    var headers = {'Content-Type': 'application/json'};

    print('servicePayload :- ${json.encode(body)}');

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: headers);

      print('serviceResponse :- $response');

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = MyAppointmentModel.fromJson(item);
      } else {
        Loader.hide();
        print('Error :- ${result!.status}');
        Fluttertoast.showToast(msg: "${result.status}");
      }
    } catch (error) {
      Loader.hide();
      print('cacheError :- $error');
      Fluttertoast.showToast(msg: "$error");
    }
    return result;
  }
}
