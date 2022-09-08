class GetservicelistModel {
  int? statusCode;
  List<Body1>? body;
  String? status;

  GetservicelistModel({this.statusCode, this.body, this.status});

  GetservicelistModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['body'] != null) {
      body = <Body1>[];
      json['body'].forEach((v) {
        body!.add(new Body1.fromJson(v));
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

class Body1 {
  int? servicetypeID;
  String? serviceName;
  String? approxmm;
  String? workstime;
  String? workendtime;
  String? weekoff;
  int? iconid;

  Body1(
      {this.servicetypeID,
      this.serviceName,
      this.approxmm,
      this.workstime,
      this.workendtime,
      this.weekoff,
      this.iconid});

  Body1.fromJson(Map<String, dynamic> json) {
    servicetypeID = json['ServicetypeID'];
    serviceName = json['ServiceName'];
    approxmm = json['approxmm'];
    workstime = json['workstime'];
    workendtime = json['workendtime'];
    weekoff = json['weekoff'];
    iconid = json['iconid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServicetypeID'] = this.servicetypeID;
    data['ServiceName'] = this.serviceName;
    data['approxmm'] = this.approxmm;
    data['workstime'] = this.workstime;
    data['workendtime'] = this.workendtime;
    data['weekoff'] = this.weekoff;
    data['iconid'] = this.iconid;
    return data;
  }
}

class Body2 {
  int? servicetypeID;
  String? serviceName;
  String? approxmm;
  String? workstime;
  String? workendtime;
  String? weekoff;
  int? iconid;

  Body2(
      {this.servicetypeID,
      this.serviceName,
      this.approxmm,
      this.workstime,
      this.workendtime,
      this.weekoff,
      this.iconid});

  Body2.fromJson(Map<String, dynamic> json) {
    servicetypeID = json['ServicetypeID'];
    serviceName = json['ServiceName'];
    approxmm = json['approxmm'];
    workstime = json['workstime'];
    workendtime = json['workendtime'];
    weekoff = json['weekoff'];
    iconid = json['iconid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServicetypeID'] = this.servicetypeID;
    data['ServiceName'] = this.serviceName;
    data['approxmm'] = this.approxmm;
    data['workstime'] = this.workstime;
    data['workendtime'] = this.workendtime;
    data['weekoff'] = this.weekoff;
    data['iconid'] = this.iconid;
    return data;
  }
}
