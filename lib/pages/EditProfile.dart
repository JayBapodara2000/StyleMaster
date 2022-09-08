import 'dart:io';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:stylemaster/models/GetCityAutoModel.dart';
import 'package:stylemaster/models/GetSMProfileDataModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylemaster/pages/MapDirectionScreen.dart';
import 'package:stylemaster/providers/GetCityAutoProvider.dart';
import 'package:stylemaster/providers/GetSMProfileDataProvider.dart';
import 'package:stylemaster/providers/UpdateProfileProvider.dart';
import 'package:stylemaster/providers/UpdateSMStatusProvider.dart';
import 'package:stylemaster/utils/AppColor.dart';
import 'package:stylemaster/utils/Config.dart';
import 'package:stylemaster/utils/ConstantsURL.dart';
import 'package:stylemaster/utils/StyleMasterPreferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  List<dynamic> allCityList = [];
  List<dynamic> allCityListId = [];
  List<String> allCities = [];
  List<String> allCitiesId = [];
  List<Body> cityNameList = [];
  var cityId;

  GlobalKey<FormState> formValidationKey = GlobalKey<FormState>();
  int? styleMasterId;
  String EntityName = '';
  String userName = '';
  String mobile = '';
  String email = '';
  String? add1 = '';
  String? add2 = '';
  String? city = '';
  bool isAdmin = false;
  double? latitude;
  double? longitude;
  int avatar = 0;
  var statusValue;
  var latitudes;
  var longitudes;

  /*  static const url =
      'https://www.google.com/maps/dir/?api=AIzaSyCpIEm6dI4FMYxum17Sxe-V_TNduQQ80nA&origin=43.7967876,-79.5331616&destination=43.5184049,-79.8473993&waypoints=43.1941283,-79.59179|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate'; */

  List<BodyOfGetSMProfileData> getProfileDetails = [];

  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController entityNameController = TextEditingController();
  TextEditingController latLongController = TextEditingController();

  String selectStatusValue = "Available";

  List<String> statusList = ['Available', 'Busy', 'Appear offline'];

  @override
  void initState() {
    getStyleMasterId();
    getLatLong();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void takePhoto(ImageSource source) async {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          'Edit Profile',
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(38.0),
                      bottomRight: Radius.circular(38.0)),
                  color: Color(0xff01519B),
                ),
                child: Row(
                  children: [
                    Stack(
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
                          right: 0,
                          top: 25,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
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
                    SizedBox(
                      width: 28,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 43, bottom: 10),
                          child: Text(
                            getProfileDetails.length == 0 ||
                                    getProfileDetails == null
                                ? ""
                                : '${getProfileDetails[0].username}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                        //?
                        Row(
                          children: [
                            selectStatusValue == "Available"
                                ? Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green,
                                    size: 15,
                                  )
                                : selectStatusValue == "Busy"
                                    ? Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                        size: 14,
                                      )
                                    : Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 20,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: AppColor.blueColor,
                                  hint: Text(
                                    'Available',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Raleway',
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                  elevation: 4,
                                  icon: SizedBox.shrink(),
                                  isExpanded: true,
                                  value: statusValue,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Raleway',
                                    color: Color(0xffFFFFFF),
                                  ),
                                  items: statusList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      onTap: () {
                                        setState(() {
                                          selectStatusValue = value;
                                        });
                                        print(
                                            'selectStatusValue : $selectStatusValue');
                                      },
                                      value: value,
                                      child: Text(value.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Raleway',
                                              color: AppColor.whiteColor)),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      statusValue = val;
                                    });
                                    updateSMStatusApiCall();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (.052),
              ),
              getProfileDetails.length == 0 || getProfileDetails == null
                  ? Container()
                  : userTextFields(getProfileDetails[0]),
              SizedBox(
                height: 10,
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
                      updateProfileAPICall();
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

  //Field visible when user is an admin
  userTextFields(BodyOfGetSMProfileData getProfileDetails) {
    if (getProfileDetails.username != null) {
      usernameController.text = getProfileDetails.username.toString();
    }
    if (getProfileDetails.email != null) {
      emailIdController.text = getProfileDetails.email.toString();
    }
    if (getProfileDetails.mobile != null) {
      mobileController.text = getProfileDetails.mobile.toString();
    }
    if (getProfileDetails.city != null) {
      cityController.text = getProfileDetails.city.toString();
    }

    if (getProfileDetails.entityname != null) {
      entityNameController.text = getProfileDetails.entityname.toString();
    }

    if (getProfileDetails.add1 != null) {
      address1Controller.text = getProfileDetails.add1.toString();
    }

    if (getProfileDetails.add2 != null) {
      address2Controller.text = getProfileDetails.add2.toString();
    }

    if (getProfileDetails.cityid != null) {
      cityId = getProfileDetails.cityid.toString();
    }

    if (getProfileDetails.pincode != null) {
      pinCodeController.text = getProfileDetails.pincode.toString();
    }

    if (getProfileDetails.latitude != null &&
        getProfileDetails.longitude != null) {
      if (latitude == null && longitude == null) {
        latLongController.text = getProfileDetails.latitude.toString() +
            ',  ' +
            getProfileDetails.longitude.toString();

        latitude = double.parse(getProfileDetails.latitude.toString());
        longitude = double.parse(getProfileDetails.longitude.toString());
      }
    }

/*     setState(() {
      usernameController.text = getProfileDetails.username == null
          ? ""
          : getProfileDetails.username.toString();

      emailIdController.text = getProfileDetails.email == null
          ? ""
          : getProfileDetails.email.toString();
      mobileController.text = getProfileDetails.mobile == null
          ? ""
          : getProfileDetails.mobile.toString();
      address1Controller.text = getProfileDetails.add1 == null
          ? ""
          : getProfileDetails.add1.toString();

      address2Controller.text = getProfileDetails.add2 == null
          ? ""
          : getProfileDetails.add2.toString();
      cityController.text = getProfileDetails.city == null
          ? ""
          : getProfileDetails.city.toString();
      //pinCodeController.text =getProfileDetails..toString();
    }); */
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        textFromFieldLableWidget('Username'),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              autofocus: false,
              enabled: true,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: '$userName',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16.0,
                    color: Color(0xff01519B),
                    fontWeight: FontWeight.bold),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: usernameController,
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
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: '$email',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16,
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: emailIdController,
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
                ),
              ],
            ),
            child: TextFormField(
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: '$mobile',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16,
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: mobileController,
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
                ),
              ],
            ),
            child: TextFormField(
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
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
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: entityNameController,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
        textFromFieldLableWidget('Address Line 1'),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff26273D29),
                  blurRadius: 6,
                ),
              ],
            ),
            child: TextFormField(
              enabled: getProfileDetails.isadmin! ? true : false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: 'Address Line 1',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16,
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: address1Controller,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
        textFromFieldLableWidget('Address Line 2'),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff26273D29),
                  blurRadius: 6,
                ),
              ],
            ),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              enabled: getProfileDetails.isadmin! ? true : false,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: 'Address Line 2',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16,
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: address2Controller,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
        textFromFieldLableWidget('City'),
        Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(33)),
          margin: EdgeInsets.only(left: 25, right: 25),
          child: EasyAutocomplete(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_city,
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
                borderSide: BorderSide(color: Color(0xffC6C7E3)),
                borderRadius: BorderRadius.circular(33),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffC6C7E3),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(33),
              ),
              hintText: 'City',
              hintStyle: TextStyle(
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
                color: Color(0xffC6C7E3),
              ),
              filled: true,
              fillColor: Color(0xffffffff),
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
            ),
            controller: cityController,
            inputTextStyle: TextStyle(
                fontSize: 16.0,
                color: AppColor.blueColor,
                fontWeight: FontWeight.bold),
            suggestionTextStyle: TextStyle(
                fontSize: 16.0,
                color: AppColor.headingTitleColor,
                fontWeight: FontWeight.bold),
            suggestions: allCities,
            onChanged: (value) {
              setState(() {
                allCities.clear();
                allCityList.clear();
              });
              if (value.length > 1) {
                getCityAutoApiCall(value);
              }
              print('onChanged entityName: ${value.length}');
            },
          ),
        ),

/*         Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff26273D29),
                  blurRadius: 6,
                ),
              ],
            ),
            child: TextFormField(
              //readOnly: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              enabled: getProfileDetails.isadmin! ? true : false,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: 'City',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16,
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: cityController,
              /*validator: (controller) {
                    if (controller == null || controller.isEmpty) {
                      return 'City field is required';
                    }
                    return null;
                  },*/
            ),
          ),
        ), */
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
                ),
              ],
            ),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              enabled: getProfileDetails.isadmin! ? true : false,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
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
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: pinCodeController,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
        textFromFieldLableWidget('Lat Long'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MapDirectionScreen())).then((value) {
                  Loader.hide();
                  if (value != null) {
                    setState(() {
                      latitude = value['latitude'];
                      longitude = value['longitude'];
                    });
                    latLongController.value = latLongController.value.copyWith(
                        text:
                            latitude.toString() + ',  ' + longitude.toString());
                    print("Get the lat long : ${latLongController.value}");
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 25),
                decoration: BoxDecoration(
                    color: AppColor.blueColor, shape: BoxShape.circle),
                height: 42,
                width: 42,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Icon(
                  Icons.directions,
                  color: AppColor.whiteColor,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff26273D29),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextFormField(
                  // key: Key(latitude.toString() + ',  ' + longitude.toString()),
                  // initialValue:
                  //     latitude.toString() + ',  ' + longitude.toString(),

                  enabled: false,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff01519B),
                      fontWeight: FontWeight.bold),
                  controller: latLongController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffC6C7E3),
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC6C7E3)),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffC6C7E3),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    hintText: 'Lat Long',
                    hintStyle: TextStyle(
                        fontFamily: 'Raleway-Regular',
                        fontSize: 16,
                        color: Color(0xffC6C7E3)),
                    filled: true,
                    fillColor: Color(0xffffffff),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 14.0, top: 14.0),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
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
  getStyleMasterId() async {
    await styleMasterPreferences.getstylemasterid().then((value) {
      setState(() {
        styleMasterId = value;
        print('StyleMaster  :$styleMasterId');
        getSMProfileDetailsAPICall();
      });
    });
  }

  getLatLong() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitudes = position.latitude;
    longitudes = position.longitude;
  }

  goToGoogleMaps(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getSMProfileDetailsAPICall() async {
    final getSMProfileDetailsProvider =
        Provider.of<GetSMProfileDataProvider>(context, listen: false);

    var body = {
      "stylemasterid": styleMasterId,
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await getSMProfileDetailsProvider.getPostSMprofiledata(
        Config.strBaseURL + Config.envVariable + smProfileDataURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      setState(() {
        getProfileDetails = result.body;
        print('getProfileDetails : $getProfileDetails');
      });

      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  getCityAutoApiCall(String cityPrefix) async {
    setState(() {
      allCities.clear();
      //  allCityListId.clear();
      allCityList.clear();
    });
    final getCityAutoProvider =
        Provider.of<GetCityAutoProvider>(context, listen: false);

    var body = {"prefix": cityPrefix};
    print('reqPayload :- $body');

    // Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await getCityAutoProvider.getPostGetCityAutoData(
        Config.strBaseURL + Config.envVariable + getCityAutoURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      print("data : ${result.body}");

      cityNameList = result.body;

      for (var i = 0; i < cityNameList.length; i++) {
        setState(() {
          allCityList.add(cityNameList[i].city);
          allCityListId.add(cityNameList[i].cityID);
        });
      }
      setState(() {
        allCities = List<String>.from(allCityList);
      });

      print('allCityList :$allCityListId');
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //api call to update profile of stylemaster
  updateProfileAPICall() async {
    if (allCityListId.isNotEmpty) {
      cityId = allCityListId[0];
    }
    final updateProfileProvider =
        Provider.of<UpdateProfileProvider>(context, listen: false);

    var body = {
      "stylemasterid": styleMasterId,
      "mobile": mobileController.text,
      "emailid": emailIdController.text,
      "entityname": entityNameController.text,
      "profileimagepath": "",
      "add1": address1Controller.text,
      "add2": address2Controller.text,
      "cityid": cityId,
      "pincode": pinCodeController.text,
      "lat": "$latitude",
      "long": "$longitude",
      "username": usernameController.text
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await updateProfileProvider.getPostUpdateProfileData(
        Config.strBaseURL + Config.envVariable + updateprofileURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Stylemaster Profile Updated successfully");
      Navigator.of(context).pop();
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  updateSMStatusApiCall() async {
    int currentstatus;
    if (selectStatusValue == "Available") {
      currentstatus = 1;
    } else if (selectStatusValue == "Busy") {
      currentstatus = 2;
    } else {
      currentstatus = 3;
    }
    final updateSMStatusProvider =
        Provider.of<UpdateSMStatusProvider>(context, listen: false);

    var body = {"stylemasterid": styleMasterId, "currentstatus": currentstatus};
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await updateSMStatusProvider.getPostUpdateSMStatus(
        Config.strBaseURL + Config.envVariable + updateStyleMasterStatusURL,
        body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "StyleMaster status update successfully");
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
