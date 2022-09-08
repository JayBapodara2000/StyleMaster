class GetCityAutoModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  GetCityAutoModel({this.statusCode, this.body, this.status});

  GetCityAutoModel.fromJson(Map<String, dynamic> json) {
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
  int? cityID;
  String? city;

  Body({this.cityID, this.city});

  Body.fromJson(Map<String, dynamic> json) {
    cityID = json['CityID'];
    city = json['City'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CityID'] = this.cityID;
    data['City'] = this.city;
    return data;
  }
}
