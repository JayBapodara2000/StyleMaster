class MyAppointmentModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  MyAppointmentModel({this.statusCode, this.body, this.status});

  MyAppointmentModel.fromJson(Map<String, dynamic> json) {
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
  String? styleBuddyName;
  int? totalTime;
  String? services;
  int? actServeID;
  String? bookingDate;
  int? avatar;
  int? acceptanceStatus;

  Body(
      {this.styleBuddyName,
      this.totalTime,
      this.services,
      this.actServeID,
      this.bookingDate,
      this.avatar,
      this.acceptanceStatus});

  Body.fromJson(Map<String, dynamic> json) {
    styleBuddyName = json['StyleBuddyName'];
    totalTime = json['TotalTime'];
    services = json['Services'];
    actServeID = json['ActServeID'];
    bookingDate = json['BookingDate'];
    avatar = json['Avatar'];
    acceptanceStatus = json['AcceptanceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StyleBuddyName'] = this.styleBuddyName;
    data['TotalTime'] = this.totalTime;
    data['Services'] = this.services;
    data['ActServeID'] = this.actServeID;
    data['BookingDate'] = this.bookingDate;
    data['Avatar'] = this.avatar;
    data['AcceptanceStatus'] = this.acceptanceStatus;
    return data;
  }
}
