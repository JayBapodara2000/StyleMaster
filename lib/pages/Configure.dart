import 'package:dart_ipify/dart_ipify.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stylemaster/Widget/ServiceIconsWidget.dart';
import 'package:stylemaster/models/GetStyleMasterListModel.dart';
import 'package:stylemaster/models/GetservicelistModel.dart';
import 'package:stylemaster/pages/AddstyleMaster.dart';
import 'package:stylemaster/pages/MenuScreen.dart';
import 'package:stylemaster/pages/RequestScreen.dart';
import 'package:stylemaster/providers/ConfigureWorkSpaceProvider.dart';
import 'package:stylemaster/providers/GetStyleMasterListProvider.dart';
import 'package:stylemaster/providers/GetservicelistProvider.dart';
import 'package:stylemaster/utils/AppColor.dart';
import 'package:stylemaster/utils/Config.dart';
import 'package:stylemaster/utils/ConstantsURL.dart';
import 'package:stylemaster/utils/ConstantsVariable.dart';
import 'package:stylemaster/utils/StyleMasterPreferences.dart';

class AllServiceIcons {
  String? asset;
  int? iconId;
  AllServiceIcons({this.asset, this.iconId});
}

class ConfigureScreen extends StatefulWidget {
  @override
  _ConfigureScreenState createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  bool isPrince = false;
  bool isPrincess = false;
  bool isselectedSM = false;
  int? selectedIndex;
  int avatar = 5;
  bool isLoading = true;
  String? iconsAsset;

  String deviceId = '';
  String userName = '';
  String deviceMacAdd = '';
  int EntityId = 0;
  String createdfrom = '';
  int? styleMasterId;

  String countryName = '';

  List<String> _barberList = [
    'The Stylish Barber',
    'The Stylish Barber2',
    'The Stylish Barber3'
  ];
  var days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  List<AllServiceIcons> allServiceIcons = [
    AllServiceIcons(asset: "Icon_22", iconId: 22),
    AllServiceIcons(asset: "Icon_23", iconId: 23),
    AllServiceIcons(asset: "Icon_25", iconId: 25),
  ];

  List allIcons = [];

  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();

  List<Body> styleMastersListData = [];

  List<Body1> PrinceServiceList = [];
  List<Body1> PrincessServiceList = [];
//  List<int> allServicesIcons = [];
  List<dynamic> servicedtl = [];
  List<dynamic> princessservicedtl = [];
  List<dynamic> servicedetail = [];
  var myControllers = [];
  var princessControllers = [];

  int _currentItem = 0;
  int _currentItem1 = 0;
  var _currentSelectedday;

  TimeOfDay initialTime = TimeOfDay.now();
  String? _startTime;
  String? _endTime;
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController weekOffController = TextEditingController();
  Future<void> _showStartTimePicker() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _startTime = result.format(context);
        startTimeController.text = _startTime!;
      });
    }
  }

  Future<void> _showEndTimePicker() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _endTime = result.format(context);
        endTimeController.text = _endTime!;
      });
    }
  }

  @override
  void initState() {
    print('styleMasterId : $styleMasterId');
    print('allServiceIcons : $allServiceIcons');
    print('allServiceIcons : ${allServiceIcons[0].iconId}');

    getEntityId();
    getUserName();
    getDeviceIp();
    getDeviceIDAndMac();
    getPlatform();
    getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xffF5F7FB),
      backgroundColor: AppColor.blueColor,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Color(0xffFFFFFF),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(38),
        )),
        centerTitle: true,
        title: Text(
          'Configure work',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Raleway-Bold',
            color: Color(0xff020325),
          ),
        ),
        leading: Container(
          padding: EdgeInsets.only(left: 24, top: 14, bottom: 14),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => MenuScreen(configure: true)),
              );
            },
            child: SvgPicture.asset(
              'assets/images/android/Configure/menu.svg',
              height: 36,
              width: 36,
              fit: BoxFit.scaleDown,
              color: Color(0xff01519B),
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12, top: 14, bottom: 14),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/images/android/Configure/Notifications.svg',
                height: 36,
                width: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xffF5F7FB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0)),
                color: Color(0xff01519B),
              ),
              child: Row(children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 8),
                  child: Image.asset(
                    'assets/images/android/Configure/profile_icon.png',
                    height: 95,
                    width: 78,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 26, bottom: 7),
                      child: Text(
                        'Welcome, $userName',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color(
                              0xff257FD2,
                            ),
                          )),
                      margin: EdgeInsets.only(
                        top: 6,
                      ),
                      child: Text(
                        'The Stylish Barber',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    /*    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(
                                0xff257FD2,
                              ),
                            )),
                        width: width / 2,
                        height: 38,
                        child: DropdownButtonFormField(
                          icon: Container(
                            child: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColor.whiteColor,
                            ),
                          ),
                          isExpanded: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintText: 'The Stylish Barber',
                              hintStyle: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              border: InputBorder.none),
                          items: _barberList.map((var value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            print(val);
                          },
                        ),
                      ),
                    ) */
                  ],
                )
              ]),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          'Let \'s configure your service for',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff020325),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * (.14),
                        margin: EdgeInsets.only(left: 41, right: 44),
                        child: Row(children: [
                          GestureDetector(
                            onTap: () {
                              if (styleMasterId == null) {
                                Fluttertoast.showToast(
                                    msg: "Please First Select Stylemaster");
                              } else {
                                setState(() {
                                  isPrince = !isPrince;
                                  isPrincess = false;
                                });
                                if (PrinceServiceList.isEmpty ||
                                    PrinceServiceList == null ||
                                    PrinceServiceList == "") {
                                  getservicelistAPICall();
                                }
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  child: Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(37.5),
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
                                          padding: EdgeInsets.only(left: 8),
                                          child: SvgPicture.asset(
                                            'assets/images/android/Configure/Prince.svg',
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
                                    Text('Prince',
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
                                        isPrince
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
                              if (styleMasterId == null) {
                                Fluttertoast.showToast(
                                    msg: "Please First Select Stylemaster");
                              } else {
                                setState(() {
                                  isPrincess = !isPrincess;
                                  isPrince = false;
                                });
                                if (PrincessServiceList.isEmpty ||
                                    PrincessServiceList == null ||
                                    PrincessServiceList == "") {
                                  getservicelistAPICall();
                                }
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  child: Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(37.5),
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
                                          padding: EdgeInsets.only(right: 8),
                                          child: SvgPicture.asset(
                                            'assets/images/android/Configure/Princess.svg',
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
                                    Text('Princess',
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
                                        isPrincess
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
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          'Select Availability',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff020325),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showStartTimePicker();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: AppColor.whiteColor,
                                border: Border.all(
                                    color: Color(0xffC6C7E3),
                                    style: BorderStyle.solid),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff26273D29),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  left: 15, top: 18, bottom: 20),
                              height: 50.0,
                              width: width * 0.43,
                              child: TextFormField(
                                controller: startTimeController,
                                enabled: false,
                                style: TextStyle(
                                    color: AppColor.blueColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Start Time',
                                  hintStyle: TextStyle(
                                      color: AppColor.textBoxBorderColor,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 14),
                                  fillColor: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showEndTimePicker();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: AppColor.whiteColor,
                                border: Border.all(
                                    color: Color(0xffC6C7E3),
                                    style: BorderStyle.solid),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff26273D29),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  top: 18, bottom: 20, right: 25),
                              height: 50.0,
                              width: width * 0.43,
                              child: TextFormField(
                                controller: endTimeController,
                                enabled: false,
                                style: TextStyle(
                                    color: AppColor.blueColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'End Time',
                                  hintStyle: TextStyle(
                                      color: AppColor.textBoxBorderColor,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 14),
                                  fillColor: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33),
                          color: AppColor.whiteColor,
                          border: Border.all(
                              color: Color(0xffC6C7E3),
                              style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff26273D29),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 15, right: 22),
                        height: 50.0,
                        width: width,
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 14),
                                fillColor: AppColor.whiteColor,
                              ),
                              isEmpty: _currentSelectedday == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text(
                                    'Week Off',
                                    style: TextStyle(
                                        color: AppColor.textBoxBorderColor,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  value: _currentSelectedday,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _currentSelectedday = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: days.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color: AppColor.blueColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      //style master
                      SizedBox(
                        height: 20,
                      ),

                      //Select Style Master Portion
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Color(0xffFFF7FB),
                          border: Border.all(color: Color(0xffFC62B2)),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 25, right: 25, top: 10),
                                  child: Text(
                                    'Select Style Master',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff020325),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddstyleMaster()),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 8, top: 8),
                                    child: SvgPicture.asset(
                                      'assets/images/android/Configure/Add_btn.svg',
                                      height: 44,
                                      width: 44,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 108,
                              margin: EdgeInsets.only(left: 20),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: styleMastersListData.length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    Future.delayed(Duration.zero, () {
                                      setState(() {
                                        _currentItem = i;
                                      });
                                    });
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 6, right: 6, top: 4),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = i;

                                            // styleMastersListData[i].isSelected =
                                            // !styleMastersListData[i].isSelected;

                                            styleMasterId =
                                                styleMastersListData[i]
                                                    .stylemasterid!;

                                            print(
                                                'selected styleMasterId : $styleMasterId');
                                          });

                                          /*setState(() {
                                          //isselectedSM = !isselectedSM;
                                          selectedIndex = i;
                                          print('selected index : $selectedIndex');
                                        });*/
                                        },
                                        child: Stack(
                                          children: [
                                            Column(
                                              children: [
                                                (selectedIndex == i)
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColor
                                                                .whiteColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                width: 2,
                                                                color: Color(
                                                                    0xffFC62B2))),
                                                        child: Image.asset(
                                                          'assets/images/android/Configure/StyleMaster2.png',
                                                          height: 80,
                                                          width: 80,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        'assets/images/android/Configure/StyleMaster2.png',
                                                        height: 80,
                                                        width: 80,
                                                        fit: BoxFit.cover,
                                                      ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                    "${styleMastersListData[i].username}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'Raleway-Regular',
                                                      color: Color(0xffa4a4a4),
                                                    )),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                child: SvgPicture.asset(
                                                  selectedIndex == i
                                                      ? 'assets/images/android/Login/checked.svg'
                                                      : 'assets/images/android/Login/unchecked.svg',
                                                  width: 22,
                                                  height: 22,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            styleMastersListData.length == 0
                                ? Container(
                                    height: 20,
                                    child: Center(
                                      child: Text(
                                        'Please Add StyleMasters',
                                        style: TextStyle(
                                            color: AppColor.headingTitleColor,
                                            fontFamily: 'Raleway',
                                            fontSize: 16),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 4),
                                    child: Center(
                                      child: DotsIndicator(
                                        dotsCount: styleMastersListData.length,
                                        position: (selectedIndex == null)
                                            ? double.parse("$_currentItem")
                                            : double.parse("$selectedIndex"),
                                        decorator: DotsDecorator(
                                          activeColor: AppColor.blueColor,
                                          spacing: EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 8),
                                          color: Color(0xffD8D8D8),
                                          size: const Size.square(9.0),
                                          activeSize: const Size(21.0, 9.0),
                                          activeShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color: Color(0xffF0F8FF),
                                  border: Border.all(color: Color(0xff01519B)),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 25, right: 2, top: 30),
                                          child: Text(
                                            'Services',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff020325),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 2, right: 25, top: 30),
                                          child: Text(
                                            'Approx. time (min)',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff020325),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: isPrince
                                          ? PrinceServiceList.length
                                          : PrincessServiceList.length,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        isPrince
                                            ? ServiceAllIconsWidget
                                                .getServiceIcons(
                                                    PrinceServiceList[i].iconid)
                                            : ServiceAllIconsWidget
                                                .getServiceIcons(
                                                    PrincessServiceList[i]
                                                        .iconid);
                                        /*           switch (PrinceServiceList[i].iconid) {
                                          case 1:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Afro.png";
                                            break;
                                          case 2:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Appointment.png";
                                            break;
                                          case 3:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Aromatherapy.png";
                                            break;
                                          case 4:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Bamboo.png";
                                            break;
                                          case 5:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Barber-pole.png";
                                            break;
                                          case 6:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Barbers-chair.png";
                                            break;
                                          case 7:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Barber-shop.png";
                                            break;
                                          case 8:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Bathroom-scale.png";
                                            break;
                                          case 9:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Bath-towel.png";
                                            break;
                                          case 10:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Beauty.png";
                                            break;
                                          case 11:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Blowdry.png";
                                            break;
                                          case 12:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Body-massage.png";
                                            break;
                                          case 13:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Bread-trim.png";
                                            break;
                                          case 14:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Bridal-hair.png";
                                            break;
                                          case 15:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Candle.png";
                                            break;
                                          case 16:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Cologne-spray.png";
                                            break;
                                          case 17:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Coloring.png";
                                            break;
                                          case 18:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Comb.png";
                                            break;
                                          case 19:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Custom-nail-paint.png";
                                            break;
                                          case 20:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Dresser.png";
                                            break;
                                          case 21:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Extensions.png";
                                            break;
                                          case 22:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Feet.png";
                                            break;
                                          case 23:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Female.png";
                                            break;
                                          case 24:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Flip-flops.png";
                                            break;
                                          case 25:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Foot-massage.png";
                                            break;
                                          case 26:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Hair-brush.png";
                                            break;
                                          case 27:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Hair-care.png";
                                            break;
                                          case 28:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Hairclipper.png";
                                            break;
                                          case 29:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Hairdresser-school.png";
                                            break;
                                          case 30:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Hair-dryer.png";
                                            break;
                                          case 31:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Hair-straightening.png";
                                            break;
                                          case 32:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Hair-treatment-mask.png";
                                            break;
                                          case 33:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Healthy.png";
                                            break;
                                          case 34:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Herbal-detox.png";
                                            break;
                                          case 35:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Herbal-pills.png";
                                            break;
                                          case 36:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Jacuzzi.png";
                                            break;
                                          case 37:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Lotion.png";
                                            break;
                                          case 38:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Lotus.png";
                                            break;
                                          case 39:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Make-up.png";
                                            break;

                                          case 40:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Male.png";
                                            break;
                                          case 41:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Massage-oil.png";
                                            break;
                                          case 42:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Men-Hair-cut.png";
                                            break;
                                          case 43:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Mirror.png.png";
                                            break;
                                          case 44:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Mustache.png";
                                            break;
                                          case 45:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Mustache-and-beard.png";
                                            break;
                                          case 46:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Nail-manicure.png";
                                            break;
                                          case 47:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Open-hours.png";
                                            break;
                                          case 48:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Peeling.png";
                                            break;
                                          case 49:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Perming.png";
                                            break;
                                          case 50:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Products.png";
                                            break;
                                          case 51:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Razor-blade.png";
                                            break;
                                          case 52:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Sauna.png";
                                            break;
                                          case 53:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Scissors.png";
                                            break;
                                          case 54:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Shave-foam.png";
                                            break;
                                          case 55:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Shaving-brush.png";
                                            break;
                                          case 56:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Shaving-razor.png";
                                            break;
                                          case 57:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Shower-bath.png";
                                            break;
                                          case 58:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Slim-girl.png";
                                            break;
                                          case 59:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Solarium.png";
                                            break;
                                          case 60:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Spa.png";
                                            break;
                                          case 61:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Spa-and-facials.png";
                                            break;
                                          case 62:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Spa-products.png";
                                            break;
                                          case 63:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Spa-school.png";
                                            break;
                                          case 64:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Spray.png";
                                            break;
                                          case 65:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Stone.png";
                                            break;
                                          case 66:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Straight-razor.png";
                                            break;
                                          case 67:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Styling-iron.png";
                                            break;
                                          case 68:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Swimming.png";
                                            break;
                                          case 69:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Team.png";
                                            break;
                                          case 70:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Teamwork.png";
                                            break;
                                          case 71:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Towel.png";
                                            break;
                                          case 72:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Treatment.png";
                                            break;

                                          case 73:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Vintage-hair-dryer.png";
                                            break;
                                          case 74:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Water-drop.png";
                                            break;
                                          case 75:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Waxing-treatment.png";
                                            break;
                                          case 76:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Wide-tooth-comb.png";
                                            break;
                                          case 77:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Women-hair-cut.png";
                                            break;
                                          case 78:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Working-hours.png";
                                            break;
                                          case 79:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Yoga.png";
                                            break;
                                          default:
                                            iconsAsset =
                                                "assets/images/android/Service_Icons/Appointment.png";
                                        } */
                                        return Container(
                                          padding: EdgeInsets.only(top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          left: 25,
                                                          right: 10,
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        height: 55,
                                                        width: 55,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffC6C7E3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Image.asset(
                                                          '${ServiceAllIconsWidget.iconsAsset}',
                                                          height: 32,
                                                          width: 32,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: width * 0.31,
                                                        child: Text(
                                                          isPrince
                                                              ? "${PrinceServiceList[i].serviceName}"
                                                              : "${PrincessServiceList[i].serviceName}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xff020325),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              33),
                                                      color:
                                                          AppColor.whiteColor,
                                                      border: Border.all(
                                                          color:
                                                              Color(0xffC6C7E3),
                                                          style: BorderStyle
                                                              .solid),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color(
                                                              0xff26273D29),
                                                          blurRadius: 6,
                                                        ),
                                                      ],
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        left: 2, right: 18),
                                                    height: 50.0,
                                                    width: width * 0.36,
                                                    child: TextFormField(
                                                      controller: isPrince
                                                          ? myControllers[i]
                                                          : princessControllers[
                                                              i],
                                                      //controller: myControllers[i],
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .blackColor,
                                                          fontFamily: 'Raleway',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'approx. time (min)',
                                                        hintStyle: TextStyle(
                                                            color: AppColor
                                                                .textBoxBorderColor,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 14,
                                                                right: 14),
                                                        fillColor:
                                                            AppColor.whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
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
                                  colors: [
                                    Color(0xff01519B),
                                    Color(0xffFC62B2)
                                  ],
                                ),
                              ),
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  configureWorkSpaceAPICall();
                                },
                                child: Container(
                                  child: Text(
                                    "CONFIGURE".toUpperCase(),
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //create controllers for approx time
  createControllers() {
    myControllers = [];
    princessControllers = [];
    if (avatar == 5) {
      for (var i = 0; i < PrinceServiceList.length; i++) {
        myControllers
            .add(TextEditingController(text: PrinceServiceList[i].approxmm));
      }
    }
    if (avatar == 6) {
      for (var i = 0; i < PrincessServiceList.length; i++) {
        princessControllers
            .add(TextEditingController(text: PrincessServiceList[i].approxmm));
      }
    }
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

        print('Entity Id :- $EntityId');
      });
      getstylemasterlistAPICall();
    });
  }

  getCountry() async {
    countryName = await styleMasterPreferences.getCountryName();
    print('countryName Data : $countryName');
  }

  getUserName() async {
    userName = await styleMasterPreferences.getUsername();
    print('userName Data : $userName');
  }

  //Api to get a list of services available
  getservicelistAPICall() async {
    final getservicelistProvider =
        Provider.of<GetservicelistProvider>(context, listen: false);

    if (isPrince) {
      setState(() {
        avatar = 5;
      });
    } else if (isPrincess) {
      setState(() {
        avatar = 6;
      });
    } else {
      setState(() {
        avatar = avatar;
      });
    }

    var body = {
      "countryname": countryName,
      "avatar": avatar,
      "stylemasterid": styleMasterId
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await getservicelistProvider.getPostservicelistData(
        Config.strBaseURL + Config.envVariable + getservicelistURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      for (var i = 0; i < result.body.length; i++) {
        if (avatar == 5) {
          //  PrincessServiceList.clear();
          setState(() {
            PrinceServiceList.add(result.body[i]);
            //  allServicesIcons.add(result.body[i].iconid);
            //    print('data : $allServicesIcons');
            PrincessServiceList.clear();
            princessControllers.clear();
            startTimeController.text = result.body[i].workstime;
            endTimeController.text = result.body[i].workendtime;
            //     _currentSelectedday = result.body[i].weekoff;

            //?
          });
        } else {
          //PrinceServiceList.clear();
          setState(() {
            PrinceServiceList.clear();
            myControllers.clear();
            PrincessServiceList.add(result.body[i]);
            //     allServicesIcons.add(result.body[i].iconid);
            startTimeController.text = result.body[i].workstime;
            endTimeController.text = result.body[i].workendtime;
            //    _currentSelectedday = result.body[i].weekoff;
          });
        }
      }

      createControllers();
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //Api to get a list of stylemaster
  getstylemasterlistAPICall() async {
    final getstylemasterlistProvider =
        Provider.of<GetStyleMasterListProvider>(context, listen: false);

    var body = {
      "entityid": EntityId,
      //"entityid": 83,
    };

    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await getstylemasterlistProvider.getPoststylemasterlist(
        Config.strBaseURL + Config.envVariable + getstyleMasterListURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      for (var i = 0; i < result.body.length; i++) {
        setState(() {
          //styleMastersListData =result.body[i];
          styleMastersListData.add(result.body[i]);
        });
      }
      print('data : $styleMastersListData');
      setState(() {
        isLoading = false;
      });
      Loader.hide();
    } else {
      setState(() {
        isLoading = false;
      });
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //Api to get a list of services available
  configureWorkSpaceAPICall() async {
    final configureWorkSpaceProvider =
        Provider.of<ConfigureWorkSpaceProvider>(context, listen: false);

    if (isPrince) {
      avatar = 5;
    } else if (isPrincess) {
      avatar = 6;
    } else {
      avatar = avatar;
    }
    //code to enter data in servicedetail list for prince
    if (avatar == 5) {
      for (var i = 0; i < PrinceServiceList.length; i++) {
        print("val1 : ${myControllers[i].text}");
        if (myControllers[i].text != "") {
          Servicedetail newObject = new Servicedetail(
              servicetypeid: PrinceServiceList[i].servicetypeID,
              approxmm: myControllers[i].text);
          setState(() {
            servicedtl.add(newObject);
          });

          print('servicedtl : $servicedtl');
          //print("val1 : ${myControllers[i].text}");
        }
      }
      print("Servicedetail:= $servicedtl");
    }
    //code to enter data in servicedetail list for princess
    else if (avatar == 6) {
      for (var i = 0; i < PrincessServiceList.length; i++) {
        print("val1 : ${princessControllers[i].text}");
        if (princessControllers[i].text != "") {
          PrincessServicedetail newObject = new PrincessServicedetail(
              servicetypeid: PrincessServiceList[i].servicetypeID,
              approxmm: princessControllers[i].text);
          setState(() {
            princessservicedtl.add(newObject);
          });
          print('servicedtl : $servicedtl');
          print("PrincessServicedetail:= $princessservicedtl");
        }
      }
      print("PrincessServicedetail:= $princessservicedtl");
    }

    //usecase 1 when only prince services are configured
    if (servicedtl.isNotEmpty && princessservicedtl.isEmpty) {
      setState(() {
        servicedetail = servicedtl;
      });
    }
    //usecase 2 when only princess services are configured
    else if (servicedtl.isEmpty && princessservicedtl.isNotEmpty) {
      setState(() {
        servicedetail = princessservicedtl;
      });
    }
    //usecase 3 when both prince and princess services are configured
    else if (servicedtl.isNotEmpty && princessservicedtl.isNotEmpty) {
      configureWorkSpace5APICall();
      configureWorkSpace6APICall();
    }

    var body = {
      "avatar": avatar,
      "stylemasterid": styleMasterId,
      //"servicedtl": (avatar==5) ? servicedtl : princessservicedtl,
      "servicedtl": servicedetail,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp
    };

    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await configureWorkSpaceProvider.getConfigureWorkSpaceData(
        Config.strBaseURL + Config.envVariable + configureWorkSpaceURL, body);
    print("apiResponse :- $result");
    print("body :- ${result.body}");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Work is configured");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RequestScreen(),
          ));
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //Api to send configured services for prince
  configureWorkSpace5APICall() async {
    final configureWorkSpaceProvider =
        Provider.of<ConfigureWorkSpaceProvider>(context, listen: false);

    var body = {
      "avatar": 5,
      "stylemasterid": styleMasterId,
      "servicedtl": servicedtl,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp
    };

    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await configureWorkSpaceProvider.getConfigureWorkSpaceData(
        Config.strBaseURL + Config.envVariable + configureWorkSpaceURL, body);
    print("apiResponse :- $result");
    print("body :- ${result.body}");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Work is for prince configured");
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //Api to send configured services for princess
  configureWorkSpace6APICall() async {
    final configureWorkSpaceProvider =
        Provider.of<ConfigureWorkSpaceProvider>(context, listen: false);

    var body = {
      "avatar": 6,
      "stylemasterid": styleMasterId,
      "servicedtl": princessservicedtl,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp
    };

    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await configureWorkSpaceProvider.getConfigureWorkSpaceData(
        Config.strBaseURL + Config.envVariable + configureWorkSpaceURL, body);
    print("apiResponse :- $result");
    print("body :- ${result.body}");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Work is for princess configured");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RequestScreen(),
          ));
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}

class Servicedetail {
  int? servicetypeid;
  String? approxmm;

  Servicedetail({this.servicetypeid, this.approxmm});

  Servicedetail.fromJson(Map<String, dynamic> json) {
    servicetypeid = json['servicetypeid'];
    approxmm = json['approxmm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['servicetypeid'] = this.servicetypeid;
    data['approxmm'] = this.approxmm;
    return data;
  }
}

class PrincessServicedetail {
  int? servicetypeid;
  String? approxmm;

  PrincessServicedetail({this.servicetypeid, this.approxmm});

  PrincessServicedetail.fromJson(Map<String, dynamic> json) {
    servicetypeid = json['servicetypeid'];
    approxmm = json['approxmm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['servicetypeid'] = this.servicetypeid;
    data['approxmm'] = this.approxmm;
    return data;
  }
}
