class GetSubscriptionPlanModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  GetSubscriptionPlanModel({this.statusCode, this.body, this.status});

  GetSubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
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
  String? subsName;
  double? amount;
  int? days;
  int? subscriptionid;

  Body({this.subsName, this.amount, this.days, this.subscriptionid});

  Body.fromJson(Map<String, dynamic> json) {
    subsName = json['SubsName'];
    amount = json['amount'];
    days = json['days'];
    subscriptionid = json['subscriptionid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubsName'] = this.subsName;
    data['amount'] = this.amount;
    data['days'] = this.days;
    data['subscriptionid'] = this.subscriptionid;
    return data;
  }
}
