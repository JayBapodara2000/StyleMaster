import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:stylemaster/models/EmailANDMobileValidationModel.dart';

class EmailAndMobileValidationServices {
  static Future<EmailAndMobileValidationModel?> emailAndMobileValidationService(
      String url, Object body) async {
    EmailAndMobileValidationModel? result;

    var headers = {'Content-Type': 'application/json'};

    print('servicePayload :- ${json.encode(body)}');

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: headers);

      print('serviceResponse :- $response');

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = EmailAndMobileValidationModel.fromJson(item);
      } else {
        print('Error :- ${result!.status}');
        Fluttertoast.showToast(msg: "${result.status}");
      }
    } catch (error) {
      print('cacheError :- $error');
      Fluttertoast.showToast(msg: "$error");
    }
    return result;
  }
}
