import 'package:flutter/cupertino.dart';

class GetStyleMasterListModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  GetStyleMasterListModel({this.statusCode, this.body, this.status});

  GetStyleMasterListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(new Body.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Body {
  int? stylemasterid;
  String? username;
  // bool isSelected = false;

  Body({this.stylemasterid, this.username});

  Body.fromJson(Map<String, dynamic> json) {
    stylemasterid = json['stylemasterid'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stylemasterid'] = this.stylemasterid;
    data['username'] = this.username;
    return data;
  }
}
