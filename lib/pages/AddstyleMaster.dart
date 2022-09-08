import 'dart:io';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stylemaster/pages/Configure.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylemaster/providers/AddstyleMasterProvider.dart';
import 'package:stylemaster/utils/AppColor.dart';
import 'package:stylemaster/utils/Config.dart';
import 'package:stylemaster/utils/ConstantsURL.dart';
import 'package:stylemaster/utils/ConstantsVariable.dart';
import 'package:stylemaster/utils/StyleMasterPreferences.dart';

class AddstyleMaster extends StatefulWidget {
  @override
  _AddstyleMasterState createState() => _AddstyleMasterState();
}

class _AddstyleMasterState extends State<AddstyleMaster> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String createdfrom = '';

  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();

  GlobalKey<FormState> formValidationKey = GlobalKey<FormState>();
  String deviceId = '';
  String deviceMacAdd = '';
  String EntityName = '';
  int EntityId = 0;
  bool isStyleMaster = false;
  bool isStyleMistress = false;
  int avatar = 3;
  bool _isObscure = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController entityNameController = TextEditingController();

  @override
  void initState() {
    getDeviceIp();
    getDeviceIDAndMac();
    getPlatform();
    getEntityId();
    getEntityName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void takePhoto(ImageSource source) async {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile as PickedFile;
      });
    }

    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Color(0xffFFFFFF),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(38),
        )),
        centerTitle: true,
        title: Text(
          'Add new StyleMaster',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway-Bold',
            color: Color(0xff020325),
          ),
        ),
        leading: Container(
          padding: EdgeInsets.only(left: 24, top: 14, bottom: 14),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              'assets/images/android/Edit_Profile/back.svg',
              height: 36,
              width: 36,
              fit: BoxFit.scaleDown,
              color: Color(0xff01519B),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formValidationKey,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * (.153),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(38.0),
                      bottomRight: Radius.circular(38.0)),
                  color: Color(0xff01519B),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 14, bottom: 17),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xff01519B),
                        backgroundImage: _imageFile != null
                            ? FileImage(File(_imageFile!.path))
                            : AssetImage(
                                    'assets/images/android/Configure/profile_icon.png')
                                as ImageProvider,
                      ),
                    ),
                    Positioned(
                      height: 24,
                      width: 24,
                      right: 274,
                      top: 25,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          takePhoto(ImageSource.camera);
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.camera,
                                              ),
                                              Text(
                                                " Camera",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          takePhoto(ImageSource.gallery);
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.image,
                                              ),
                                              Text(
                                                " Gallery",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                            },
                          );
                        },
                        child: SvgPicture.asset(
                            'assets/images/android/Edit_Profile/upload_img.svg'),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (.052),
              ),
              Container(
                height: MediaQuery.of(context).size.height * (.14),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isStyleMaster = !isStyleMaster;
                        isStyleMistress = false;
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(37.5)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(37.5)),
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
                      textFromFieldLableWidget('Name'),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                              hintText: 'Name',
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
                            controller: usernameController,
                            validator: (controller) {
                              if (controller == null || controller.isEmpty) {
                                return 'Username field is required';
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
                            obscureText: _isObscure,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                                borderSide: BorderSide(
                                  color: Color(0xffC6C7E3),
                                ),
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
                              if (controller == null || controller.isEmpty) {
                                return 'Password field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (.02),
                      ),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
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
                              hintText: 'E-mail',
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
                        height: MediaQuery.of(context).size.height * (.02),
                      ),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
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
                        height: MediaQuery.of(context).size.height * (.02),
                      ),
                      textFromFieldLableWidget('Entity Name'),
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
                          child: TextField(
                            autofocus: false,
                            readOnly: true,
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
                              hintText: "$EntityName",
                              hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              filled: true,
                              fillColor: Color(0xffffffff),
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 14.0, top: 14.0),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 50,
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
                    if (formValidationKey.currentState!.validate()) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      //API function call
                      addstyleMasterAPICall();
                    }
                  },
                  child: Container(
                    child: Text(
                      "Save".toUpperCase(),
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
      ),
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

  // get entityid from login api response
  getEntityId() async {
    await styleMasterPreferences.getentityid().then((value) {
      setState(() {
        EntityId = value;
        print('EntityId  :$EntityId');
      });
    });
  }

  // get entityname from login api response
  getEntityName() async {
    await styleMasterPreferences.getentityname().then((value) {
      setState(() {
        EntityName = value;
        print('EntityName  :$EntityName');
      });
    });
  }

  //api call for adding new style master
  addstyleMasterAPICall() async {
    final addstyleMasterProvider =
        Provider.of<AddstyleMasterProvider>(context, listen: false);
    if (isStyleMaster == true) {
      avatar = 3;
    } else if (isStyleMistress == true) {
      avatar = 4;
    } else {
      avatar = avatar;
    }

    var body = {
      "entityid": EntityId,
      "avatar": avatar,
      "emailid": emailIdController.text,
      "password": passwordController.text,
      "username": usernameController.text,
      "mobile": mobileController.text,
      "pincode": pinCodeController.text,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp,
      "profileimgpath": "",
      "worksttime": "10:30:00+05:30",
      "workendtime": "19:30:00+05:30",
      "weekoff": 1
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await addstyleMasterProvider.getPostaddstyleMasterData(
        Config.strBaseURL + Config.envVariable + addstyleMasterURL, body);
    print("apiResponse :- $result");

    if (result != null || result != "") {
      Loader.hide();
      Fluttertoast.showToast(msg: "Stylemaster added successfully");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConfigureScreen(),
          ));
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
