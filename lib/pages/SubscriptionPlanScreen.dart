import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stylemaster/models/GetSubscriptionPlanModel.dart';
import 'package:stylemaster/pages/LoginScreen.dart';
import 'package:stylemaster/providers/GetSubscriptionPlanProvider.dart';
import 'package:stylemaster/utils/AppColor.dart';
import 'package:stylemaster/utils/Config.dart';
import 'package:stylemaster/utils/ConstantsURL.dart';

import '../utils/ConstantsVariable.dart';

import 'package:visibility_detector/visibility_detector.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  List<Body> getSubscriptionPlanDataList = [];

  int _currentItem = 0;
  int? selectPlanValue;

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      getSubscriptionPlanApiCall(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.textBoxBorderColor,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              'assets/images/android/Choose_Plan/ChoosePlan_bg.svg.png'),
          fit: BoxFit.fill,
        )),
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.085,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Choose your Plan',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Raleway-Bold',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.headingTitleColor,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (.05),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 0),
              width: width,
              child: SvgPicture.asset(
                  'assets/images/android/Choose_Plan/Barber.svg'),
            ),
            SizedBox(
              height: 154,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getSubscriptionPlanDataList.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    return VisibilityDetector(
                      key: Key(i.toString()),
                      onVisibilityChanged: (VisibilityInfo info) {
                        if (info.visibleFraction == 1)
                          setState(() {
                            _currentItem = i;
                            print(_currentItem);
                          });
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectPlanValue = _currentItem;
                          });
                          print(selectPlanValue);
                        },
                        child: Container(
                            width: width - 36,
                            height: 154,
                            decoration: BoxDecoration(
                              color: i % 2 == 0
                                  ? AppColor.blueColor
                                  : AppColor.lightPinkColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.only(left: 16, right: 2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${getSubscriptionPlanDataList[i].subsName}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: AppColor.textBoxBorderColor,
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                      ),
                                    ),
                                    selectPlanValue == i
                                        ? Icon(
                                            Icons.circle_rounded,
                                            color: AppColor.whiteColor,
                                            size: 26,
                                          )
                                        : Icon(
                                            Icons.circle_outlined,
                                            color: AppColor.whiteColor,
                                            size: 26,
                                          )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '₹ ${getSubscriptionPlanDataList[i].amount}/${getSubscriptionPlanDataList[i].days} Days',
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  color: AppColor.textBoxBorderColor
                                      .withOpacity(0.5),
                                  child: Text(
                                    '1 Week free trail',
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColor.whiteColor,
                                      size: 16,
                                    ),
                                    Text(
                                      'Cancle any time',
                                      style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  }),
            ),
            getSubscriptionPlanDataList.length == 0
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 4),
                    child: Center(
                      child: DotsIndicator(
                        dotsCount: getSubscriptionPlanDataList.length,
                        position: double.parse("$_currentItem"),
                        decorator: DotsDecorator(
                          activeColor: AppColor.blueColor,
                          spacing:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                          color: Color(0xffD8D8D8),
                          size: const Size.square(9.0),
                          activeSize: const Size(21.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                  colors: [Color(0xff01519B), Color(0xffFC62B2)],
                ),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  child: Text(
                    "CONTINUE TO CHECKOUT".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.23,
                      fontSize: 16,
                      fontFamily: 'Raleway-ExtraBold',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //api calling
  getSubscriptionPlanApiCall(BuildContext context) async {
    final getSubscriptionPlanProvider =
        Provider.of<GetSubscriptionPlanProvider>(context, listen: false);

    var body = {};

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await getSubscriptionPlanProvider.getPostSubscriptionPlan(
        Config.strBaseURL + Config.envVariable + getSubscriptionPlanURL, body);
    print("apiResponse : $result");

    if (result.statusCode == 200) {
      Loader.hide();
      for (var i = 0; i < result.body.length; i++) {
        setState(() {
          getSubscriptionPlanDataList.add(result.body[i]);
        });
        print("getSubscriptionPlanDataList :$getSubscriptionPlanDataList");
      }
      Loader.hide();
    } else {
      Loader.hide();
    }
  }
}
