
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylemaster/utils/AppColor.dart';

import '../utils/ConstantsVariable.dart';

class NoInternetScreen extends StatefulWidget{
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();

}

class _NoInternetScreenState extends State<NoInternetScreen>{
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.whiteSmoakColor,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.18),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Ooops!',
                    style: TextStyle(
                      fontSize: 33,
                      fontFamily: 'Raleway-Regular',
                      color: AppColor.blueColor,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Please wait',
                    style: TextStyle(
                      fontSize: 33,
                      fontFamily: 'Raleway-Regular',
                      color: AppColor.blueColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.023,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/android/Extra_Screens/OOps_pls_wait.svg',
                    height: height * 0.253,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: height * 0.086,
                ),
                Center(
                  child: Text(
                    'Slow or no internet connection. Please check your internet\nsettings and start chores',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Raleway-Regular',
                      color: AppColor.headingTitleColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.058,
                ),
                Container(
                  height: 38,
                  //margin: EdgeInsets.only(bottom: height * 0.018),
                  child: Container(
                    width: 134,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.blueColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(33) //                 <--- border radius here
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                      },
                      child: Text(
                       'RETRY',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Raleway-Regular',
                          color: AppColor.blueColor,
                        ),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}