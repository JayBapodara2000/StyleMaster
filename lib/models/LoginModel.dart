class LoginModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  LoginModel({this.statusCode, this.body, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? avatar;
  int? loginstatus;
  String? token;
  int? stylemasterid;
  String? username;
  String? entityname;
  int? entityid;
  String? profileimgpath;

  Body(
      {this.avatar,
      this.loginstatus,
      this.token,
      this.stylemasterid,
      this.username,
      this.entityname,
      this.entityid,
      this.profileimgpath});

  Body.fromJson(Map<String, dynamic> json) {
    avatar = json['Avatar'];
    loginstatus = json['loginstatus'];
    token = json['Token'];
    stylemasterid = json['stylemasterid'];
    username = json['username'];
    entityname = json['entityname'];
    entityid = json['entityid'];
    profileimgpath = json['profileimgpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Avatar'] = this.avatar;
    data['loginstatus'] = this.loginstatus;
    data['Token'] = this.token;
    data['stylemasterid'] = this.stylemasterid;
    data['username'] = this.username;
    data['entityname'] = this.entityname;
    data['entityid'] = this.entityid;
    data['profileimgpath'] = this.profileimgpath;
    return data;
  }
}
