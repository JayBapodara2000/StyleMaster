import 'package:flutter/material.dart';
import 'package:stylemaster/models/GetSubscriptionPlanModel.dart';
import 'package:stylemaster/services/GetSubscriptionPlanServices.dart';

class GetSubscriptionPlanProvider with ChangeNotifier {
  GetSubscriptionPlanModel post = GetSubscriptionPlanModel();

  getPostSubscriptionPlan(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    //notifyListeners();
    return post =
        (await GetSubscriptionPlanServices.getSubscriptionPlan(url, body))!;
  }
}
