
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylemaster/utils/AppColor.dart';
import '../utils/ConstantsVariable.dart';

class UpdateTheAppScreen extends StatefulWidget{
  @override
  _UpdateTheAppScreenState createState() => _UpdateTheAppScreenState();

}

class _UpdateTheAppScreenState extends State<UpdateTheAppScreen>{
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
                    'Yeah! It\'s\nTime to Upgrade!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 33,
                      fontFamily: 'Raleway-Regular',
                      color: AppColor.blueColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.032,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/android/Extra_Screens/time_upgrade.svg',
                    height: height * 0.233,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: height * 0.12,
                ),
                Center(
                  child: Text(
                    'We added lots of new features and fix some bugs to\nmake your experience as smooth as possible',
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
                  //margin: EdgeInsets.only(bottom: height * 0.18),
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
                          'UPDATE APP',
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