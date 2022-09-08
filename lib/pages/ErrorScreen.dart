
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylemaster/utils/AppColor.dart';

import '../utils/ConstantsVariable.dart';

class ErrorScreen extends StatefulWidget{
  @override
  _ErrorScreenState createState() => _ErrorScreenState();

}

class _ErrorScreenState extends State<ErrorScreen>{
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
                    'SORRY!\nfor inconvenience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 33,
                      fontFamily: 'Raleway-Regular',
                      color: AppColor.blueColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.027,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/android/Extra_Screens/sorry_underconstruction.svg',
                    height: height * 0.25,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: height * 0.089,
                ),
                Center(
                  child: Text(
                    'We are doing our best to make your experience\nas smooth as possible. Will be back soon.',
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
                  child: Container(
                    width: 134,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.blueColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(33) //
                      ),
                    ),
                    child: MaterialButton(
                        onPressed: () {
                        },
                        child: Text(
                          'GO HOME',
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