import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:stylemaster/models/GetSMProfileDataModel.dart';

class GetSMProfileDataServices {
  static Future<GetSMProfileDataModel?> getSMProfileDataService(
      String url, Object body) async {
    GetSMProfileDataModel? result;

    var headers = {'Content-Type': 'application/json'};

    print('servicePayload :- ${json.encode(body)}');

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: headers);

      print('serviceResponse :- $response');

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = GetSMProfileDataModel.fromJson(item);
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
