import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stylemaster/pages/Configure.dart';
import 'package:stylemaster/pages/LoginScreen.dart';
import 'package:stylemaster/pages/SubscriptionPlanScreen.dart';
import 'package:stylemaster/providers/EmailANDMobileValidationProvider.dart';
import 'package:stylemaster/providers/RegistrationProvider.dart';
import 'package:stylemaster/utils/AppColor.dart';
import 'package:stylemaster/utils/Config.dart';
import 'package:stylemaster/utils/ConstantsVariable.dart';
import 'package:stylemaster/utils/ConstantsURL.dart';
import 'package:stylemaster/utils/StyleMasterPreferences.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:stylemaster/utils/Validator.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool agree = false;
  bool _isObscure = true;
  bool _conisObscure = true;
  bool isStyleMaster = false;
  bool isStyleMistress = false;
  int avatar = 1;

  String createdfrom = '';

  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();

  TextEditingController emailIdController = TextEditingController();
  TextEditingController yourNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController entityNameController = TextEditingController();

  GlobalKey<FormState> formValidationKey = GlobalKey<FormState>();
  String deviceId = '';
  String deviceMacAdd = '';

  @override
  void initState() {
    getDeviceIp();
    getDeviceIDAndMac();
    getPlatform();
    super.initState();
  }

  @override
  void dispose() {
    Loader.hide();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xfff5f7fb),
          body: SingleChildScrollView(
              child: Form(
            key: formValidationKey,
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * (.09),
                    width: MediaQuery.of(context).size.width * (.89),
                    margin: EdgeInsets.only(left: 21, top: 30, right: 20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Don\'t have an account?',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Raleway-Bold',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff020325),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please Signup',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Raleway-ExtraBold',
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Color(0xff020325),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (.039),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33.0),
                      color: Color(0xffffc3e2),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          elevation: 0,
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width / 2.25,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33.0),
                          ),
                          color: Color(0xffffc3e2),
                          child: Text("login".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          elevation: 0,
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width / 2.45,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33.0),
                          ),
                          color: Color(0xfffc62b2),
                          child: Text("signup".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (.05),
                  ),
                  //
                  Container(
                    height: MediaQuery.of(context).size.height * (.14),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isStyleMaster = !isStyleMaster;
                                isStyleMistress = false;
                                print('isStyleMaster : $isStyleMaster');
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  child: Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xffC6C7E3),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(37.5)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff26273D29),
                                            blurRadius: 6,
                                            // offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 3),
                                          child: SvgPicture.asset(
                                            'assets/images/android/Login/Male_Stylist.svg',
                                            height: 58,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        radius: 37.5,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Style Master',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Raleway-Regular',
                                          color: Color(0xffa4a4a4),
                                        )),
                                  ]),
                                ),
                                Positioned(
                                    right: 0,
                                    child: Container(
                                      child: SvgPicture.asset(
                                        isStyleMaster
                                            ? 'assets/images/android/Login/checked.svg'
                                            : 'assets/images/android/Login/unchecked.svg',
                                        width: 22,
                                        height: 22,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 31,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isStyleMistress = !isStyleMistress;
                                isStyleMaster = false;
                                print('isStyleMistress : $isStyleMistress');
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  child: Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xffC6C7E3),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(37.5)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff26273D29),
                                            blurRadius: 6,
                                            // offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 3),
                                          child: SvgPicture.asset(
                                            'assets/images/android/Login/female_Stylist.svg',
                                            height: 58,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        radius: 37.5,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Style Master',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Raleway-Regular',
                                          color: Color(0xffa4a4a4),
                                        )),
                                  ]),
                                ),
                                Positioned(
                                    right: 5,
                                    child: Container(
                                      child: SvgPicture.asset(
                                        isStyleMistress
                                            ? 'assets/images/android/Login/checked.svg'
                                            : 'assets/images/android/Login/unchecked.svg',
                                        width: 22,
                                        height: 22,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (.02),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        textFromFieldLableWidget('Email'),
                        Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff26273D29),
                                  blurRadius: 6,
                                  // offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xfffc62b2),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'youremail@gmail.com',
                                hintStyle: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 16,
                                  color: Color(0xffC6C7E3),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 14.0, top: 14.0),
                              ),
                              controller: emailIdController,
                              onFieldSubmitted: (val) {
                                emailValidationApiCall();
                              },
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Email field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        textFromFieldLableWidget('Mobile'),
                        Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff26273D29),
                                  blurRadius: 6,
                                  // offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.dialpad,
                                  color: Color(0xfffc62b2),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Mobile',
                                hintStyle: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 16,
                                  color: Color(0xffC6C7E3),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 14.0, top: 14.0),
                              ),
                              controller: mobileController,
                              onFieldSubmitted: (val) {
                                mobileValidationApiCall();
                              },
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Mobile No. field is required';
                                } else {
                                  if (controller.length != 10)
                                    return 'Mobile Number must be of 10 digit';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Your Name'),
                        Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff26273D29),
                                  blurRadius: 6,
                                  // offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xfffc62b2),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Your Name',
                                hintStyle: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 16,
                                  color: Color(0xffC6C7E3),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 14.0, top: 14.0),
                              ),
                              controller: yourNameController,
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Your Name field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Password'),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff26273D29),
                                    blurRadius: 6,
                                    // offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: _isObscure,
                                autofocus: false,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.blueColor,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Color(0xfffc62b2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffC6C7E3),
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffC6C7E3)),
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffC6C7E3),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Raleway-Regular',
                                    fontSize: 16,
                                    color: Color(0xffC6C7E3),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggle,
                                    child: Icon(
                                      _isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xffCCCCCC),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffffffff),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 14.0, top: 14.0),
                                ),
                                controller: passwordController,
                                validator: (controller) {
                                  if (controller == null ||
                                      controller.isEmpty) {
                                    return 'Password field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Confirm Password'),
                        Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff26273D29),
                                  blurRadius: 6,
                                  // offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: _conisObscure,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Color(0xfffc62b2),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 16,
                                  color: Color(0xffC6C7E3),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: _contoggle,
                                  child: Icon(
                                    _conisObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xffCCCCCC),
                                  ),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 14.0, top: 14.0),
                              ),
                              controller: confirmPasswordController,
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Confirm Password field is required';
                                }
                                if (controller != passwordController.text)
                                  return 'Confirm Password is not same as your Password.';
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Entity name'),
                        Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff26273D29),
                                  blurRadius: 6,
                                  // offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.home_work,
                                  color: Color(0xfffc62b2),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Entity name',
                                hintStyle: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 16,
                                  color: Color(0xffC6C7E3),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 14.0, top: 14.0),
                              ),
                              controller: entityNameController,
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Entity Name field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Pincode'),
                        Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff26273D29),
                                  blurRadius: 6,
                                  // offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.add_location_sharp,
                                  color: Color(0xfffc62b2),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Pincode',
                                hintStyle: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 16,
                                  color: Color(0xffC6C7E3),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 14.0, top: 14.0),
                              ),
                              controller: pinCodeController,
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Pincode field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.005),
                        ),
                        Row(
                          children: [
                            Material(
                              child: Container(
                                padding: EdgeInsets.only(left: 28),
                                child: Checkbox(
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = value ?? false;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: BorderSide(
                                    color: Color(0xffC6C7E3),
                                  ),
                                  activeColor: Color(0xff01519B),
                                  checkColor: Colors.white,
                                  tristate: false,
                                ),
                              ),
                            ),
                            Text('I accept ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Raleway-Regular',
                                    color: Color(0xffC6C7E3))),
                            Text('terms & conditions',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Raleway-Bold',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff01519B))),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.01),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
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
                              if (formValidationKey.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (agree) {
                                  //call API
                                  //emailValidationApiCall();
                                  userRegisterApiCall();
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please agree to terms and conditions");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please fill the required fields");
                              }
                            },
                            child: Container(
                              child: Text(
                                "REGISTER ME".toUpperCase(),
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
                  )
                ],
              ),
            ),
          ))),
    );
  }

  textFromFieldLableWidget(String title) {
    return Container(
      padding: EdgeInsets.only(left: 40, bottom: 4),
      child: Text(
        '$title',
        style: TextStyle(
            fontFamily: 'Raleway-Regular',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black38),
      ),
    );
  }

//for password hide/show
  _toggle() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  //for confirm password hide/show
  _contoggle() {
    setState(() {
      _conisObscure = !_conisObscure;
    });
  }

  getDeviceIp() async {
    deviceIp = await Ipify.ipv4();
  }

  getDeviceIDAndMac() async {
    await styleMasterPreferences.getDeviceId().then((value) {
      setState(() {
        deviceId = value;
        print('deviceId  :$deviceId');
      });
    });

    await styleMasterPreferences.getDeviceMac().then((value) {
      setState(() {
        deviceMacAdd = value;
        print('deviceMacAdd  :$deviceMacAdd');
      });
    });
  }

  getPlatform() {
    if (isAndroid == true) {
      setState(() {
        createdfrom = "android";
      });
    } else if (isIos == true) {
      setState(() {
        createdfrom = "ios";
      });
    }
  }

  //API call for email validation
  emailValidationApiCall() async {
    final emailAndMobileValidationProvider =
        Provider.of<EmailAndMobileValidationProvider>(context, listen: false);

    var body = {"emailid": emailIdController.text};

    print('reqPayload :- $body');

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await emailAndMobileValidationProvider
        .getPostEmailAndMobileValidationData(
            Config.strBaseURL + Config.envVariable + emailValidationURL, body);
    print("apiResponse :- $result");

    if (result.body.isavilable == true) {
      //mobileValidationApiCall();
      Loader.hide();
      //return ;
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "Your emailid is already registered.");
    }
  }

  //API call for mobile validation
  mobileValidationApiCall() async {
    final emailAndMobileValidationProvider =
        Provider.of<EmailAndMobileValidationProvider>(context, listen: false);

    var body = {"mob_num": mobileController.text};

    print('reqPayload :- $body');

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await emailAndMobileValidationProvider
        .getPostEmailAndMobileValidationData(
            Config.strBaseURL + Config.envVariable + mobileValidationURL, body);
    print("apiResponse :- $result");

    if (result.body.isavilable == true) {
      //userRegisterApiCall();
      Loader.hide();
      return;
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "Your mobile number is already registered.");
    }
  }

  //API call function declare
  userRegisterApiCall() async {
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    if (isStyleMaster == true) {
      avatar = 1;
    } else if (isStyleMistress == true) {
      avatar = 2;
    } else {
      avatar = avatar;
    }

    var body = {
      "avatar": avatar,
      "emailid": emailIdController.text,
      "password": passwordController.text,
      "username": yourNameController.text,
      "mobile": mobileController.text,
      "pincode": pinCodeController.text,
      "entityname": entityNameController.text,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await registerProvider.getPostRegisterData(
        Config.strBaseURL + Config.envVariable + styleMasterRegistrationURL,
        body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Registration successfully");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SubscriptionPlanScreen(),
          ));
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
