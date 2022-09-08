import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:stylemaster/models/ConfigureWorkSpaceModel.dart';

class ConfigureWorkSpaceServices {
  static Future<ConfigureWorkSpaceModel?> configureWorkSpaceService(
      String url, Object body) async {
    ConfigureWorkSpaceModel? result;

    var headers = {'Content-Type': 'application/json'};

    print('servicePayload :- ${json.encode(body)}');

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: headers);

      print('serviceResponse :- $response');

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = ConfigureWorkSpaceModel.fromJson(item);
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
