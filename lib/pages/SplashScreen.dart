import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stylemaster/pages/Onboarding1.dart';
import 'package:stylemaster/pages/RequestScreen.dart';
import 'package:stylemaster/utils/StyleMasterPreferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();
  bool isLogged = false;

  @override
  void initState() {
    getUserData();
    Timer(Duration(seconds: 2), () {
      if (isLogged) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => RequestScreen()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => OnboardingScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      AssetImage('assets/images/android/Splash/Splash.png'))),
        ),
      ),
    );
  }

  getUserData() async {
    isLogged = await styleMasterPreferences.getIsUserLogged();
  }
}
