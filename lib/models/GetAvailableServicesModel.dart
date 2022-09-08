class GetAvailableServicesModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  GetAvailableServicesModel({this.statusCode, this.body, this.status});

  GetAvailableServicesModel.fromJson(Map<String, dynamic> json) {
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
  int? servicedtlid;
  String? servicename;
  int? approxtime;
  int? iconid;
  bool isSelected = false;

  Body({this.servicedtlid, this.servicename, this.approxtime});

  Body.fromJson(Map<String, dynamic> json) {
    servicedtlid = json['servicedtlid'];
    servicename = json['servicename'];
    approxtime = json['approxtime'];
    iconid = json['iconid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['servicedtlid'] = this.servicedtlid;
    data['servicename'] = this.servicename;
    data['approxtime'] = this.approxtime;
    data['iconid'] = this.iconid;
    return data;
  }
}
