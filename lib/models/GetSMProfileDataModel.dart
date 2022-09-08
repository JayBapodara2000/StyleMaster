class GetSMProfileDataModel {
  int? statusCode;
  List<BodyOfGetSMProfileData>? body;
  String? status;

  GetSMProfileDataModel({this.statusCode, this.body, this.status});

  GetSMProfileDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['body'] != null) {
      body = <BodyOfGetSMProfileData>[];
      json['body'].forEach((v) {
        body!.add(new BodyOfGetSMProfileData.fromJson(v));
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

class BodyOfGetSMProfileData {
  String? username;
  String? mobile;
  String? email;
  String? entityname;
  String? profilepath;
  bool? isadmin;
  int? stylemasterid;
  String? add1;
  String? add2;
  String? city;
  int? cityid;
  String? pincode;
  String? latitude;
  String? longitude;
  int? currentstatus;

  BodyOfGetSMProfileData(
      {this.username,
      this.mobile,
      this.email,
      this.entityname,
      this.profilepath,
      this.isadmin,
      this.stylemasterid,
      this.add1,
      this.add2,
      this.city,
      this.cityid,
      this.pincode,
      this.latitude,
      this.longitude,
      this.currentstatus});

  BodyOfGetSMProfileData.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    mobile = json['mobile'];
    email = json['email'];
    entityname = json['entityname'];
    profilepath = json['profilepath'];
    isadmin = json['isadmin'];
    stylemasterid = json['stylemasterid'];
    add1 = json['add1'];
    add2 = json['add2'];
    city = json['city'];
    cityid = json['cityid'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    currentstatus = json['currentstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Username'] = this.username;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['entityname'] = this.entityname;
    data['profilepath'] = this.profilepath;
    data['isadmin'] = this.isadmin;
    data['stylemasterid'] = this.stylemasterid;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['city'] = this.city;
    data['cityid'] = this.cityid;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['currentstatus'] = this.currentstatus;
    return data;
  }
}
