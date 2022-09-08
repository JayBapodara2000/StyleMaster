import 'package:shared_preferences/shared_preferences.dart';

class StyleMasterPreferences {
  final String deviceId = "deviceId";
  final String deviceMac = "deviceMac";
  final String isLogged = "isLogged";
  final String token = "token";
  final String avatar = "avatar";
  final String stylemasterid = "stylemasterid";
  final String entityname = "entityname";
  final String entityid = "entityid";
  final String username = "username";
  final String mobile = "mobile";
  final String email = "email";
  final String isadmin = "isadmin";
  final String add1 = "add1";
  final String add2 = "add2";
  final String city = "city";
  final String countryName = "countryName";
  final String requestUserName = "requestUserName";

  Future<String> getDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(deviceId) ?? "";
  }

  Future<dynamic> setDeviceId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(deviceId, value);
  }

  Future<dynamic> setDeviceMac(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(deviceMac, value);
  }

  Future<String> getDeviceMac() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(deviceMac) ?? "";
  }

  Future<dynamic> setIsUserLogged(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(isLogged, value);
  }

  Future<bool> getIsUserLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(isLogged) ?? false;
  }

  Future<dynamic> setentityid(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(entityid, value);
  }

  Future<int> getentityid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(entityid) ?? 0;
  }

  Future<dynamic> setAvatar(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(avatar, value);
  }

  Future<int> getAvatar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(avatar) ?? 0;
  }

  Future<dynamic> setstylemasterid(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(stylemasterid, value);
  }

  Future<int> getstylemasterid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(stylemasterid) ?? 0;
  }

  Future<String> getentityname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(entityname) ?? "";
  }

  Future<dynamic> setentityname(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(entityname, value);
  }

  Future<dynamic> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(token, value);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(token) ?? "";
  }

  Future<dynamic> setCountryName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(countryName, value);
  }

  Future<String> getCountryName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(countryName) ?? "";
  }

  //clear all local storage store data

  Future<bool> clearAllSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }

  // Request Screen Preferences
  //for requestUserName of stylemaster
  Future<String> getRequestUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(requestUserName) ?? "";
  }

  Future<dynamic> setRequestUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(requestUserName, value);
  }

  //Menu Screen-Edit Profile Preferences
  //for username of stylemaster
  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(username) ?? "";
  }

  Future<dynamic> setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(username, value);
  }

  //for mobile number of SM
  Future<String> getMobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(mobile) ?? "";
  }

  Future<dynamic> setMobile(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(mobile, value);
  }

  //for Email of SM
  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(email) ?? "";
  }

  Future<dynamic> setEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(email, value);
  }

  //for add1 of SM
  Future<String> getAdd1() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(add1) ?? "";
  }

  Future<dynamic> setAdd1(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == null) {
      value = "";
    }

    return prefs.setString(add1, value);
  }

  //for add2 of SM
  Future<String> getAdd2() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(add2) ?? "";
  }

  Future<dynamic> setAdd2(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value == null) {
      value = "";
    }

    return prefs.setString(add2, value);
  }

  //for City of SM
  Future<String?> getCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(city) ?? "";
  }

  Future<dynamic> setCity(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value == null) {
      value = "";
    }

    return prefs.setString(city, value);
  }

  //for IsAdmin field of SM
  Future<bool?> getIsAdmin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(isadmin);
  }

  Future<bool> setIsAdmin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(isadmin, value);
  }
}
