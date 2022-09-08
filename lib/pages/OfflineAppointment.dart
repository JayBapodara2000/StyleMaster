import 'dart:io';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stylemaster/Widget/ServiceIconsWidget.dart';
import 'package:stylemaster/models/GetAvailableServicesModel.dart';
import 'package:stylemaster/pages/RequestScreen.dart';
import 'package:stylemaster/providers/GetAvailableServicesProvider.dart';
import 'package:stylemaster/providers/OfflineAppointmentProvider.dart';
import 'package:stylemaster/utils/AppColor.dart';
import 'package:stylemaster/utils/Config.dart';
import 'package:stylemaster/utils/ConstantsURL.dart';
import 'package:stylemaster/utils/ConstantsVariable.dart';
import 'package:stylemaster/utils/StyleMasterPreferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomerBookingSlotScreen extends StatefulWidget {
  @override
  _CustomerBookingSlotScreenState createState() =>
      _CustomerBookingSlotScreenState();
}

class _CustomerBookingSlotScreenState extends State<CustomerBookingSlotScreen>
    with TickerProviderStateMixin {
  late Map<DateTime, List> _events;
  late List _selectedEvents;
  late AnimationController _animationController;
  TimeOfDay initialTime = TimeOfDay.now();
  var date;
  String? _selectedTime;
  String deviceId = '';
  String deviceMacAdd = '';
  String createdfrom = '';
  String deviceIp = '';
  int styleMasterId = 0;
  int totalTimeMM = 0;
  List<Body> availableServicesList = [];
  List<dynamic> servicedtl = [];
  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();

  TextEditingController selectedSlotController = TextEditingController();
  //CalendarController _calendarController;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> _showTimePicker() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (result != null) {
      String formattedTime =
          localizations.formatTimeOfDay(result, alwaysUse24HourFormat: true);
      if (formattedTime != null) {
        setState(() {
          _selectedTime = result.format(context);
          selectedSlotController.text = _selectedTime!;
        });
      }
    }
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  void initState() {
    getstyleMasterId();
    getDeviceIp();
    getDeviceIDAndMac();
    getPlatform();

    if (date == null) {
      setState(() {
        date = focusedDay.toString().split(' ');
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.blueColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              topBarWidget(),
              servicesWidget(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget topBarWidget() {
    return Container(
      padding: EdgeInsets.only(right: 14, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: SvgPicture.asset(
                  'assets/images/android/Customer_Assets/Booking_slot/close.svg',
                  height: 22,
                  width: 22,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Text(
              'Offline Appointment',
              style: TextStyle(
                  color: AppColor.whiteColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          _buildTableCalendar(),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffC6C7E3), width: 1),
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 18),
      child: TableCalendar(
        daysOfWeekVisible: true,
        availableGestures: AvailableGestures.all,
        weekendDays: [],
        calendarFormat: CalendarFormat.week,
        headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: TextStyle(
                color: AppColor.blackColor,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 18),
            formatButtonVisible: false,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10))),
        calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: AppColor.blueColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            todayDecoration: BoxDecoration(
              color: AppColor.blueColor.withOpacity(0.45),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            weekendDecoration: BoxDecoration(
              color: AppColor.blueColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            rowDecoration: BoxDecoration(
                border: Border.all(width: 0, color: AppColor.whiteColor)),
            todayTextStyle: TextStyle(
                color: AppColor.headingTitleColor,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16),
            selectedTextStyle: TextStyle(
                color: AppColor.whiteColor,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16),
            defaultTextStyle: TextStyle(
                color: AppColor.textBoxBorderColor,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16),
            defaultDecoration: BoxDecoration(
              color: AppColor.whiteColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            tableBorder: TableBorder.all(
              color: AppColor.whiteColor,
              width: 0,
            )),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: selectedDay,
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
          date = focusedDay.toString().split(' ');
          print(date[0]);
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
      ),
    );
  }

  Widget servicesWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: AppColor.lightGreyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(44),
            topRight: Radius.circular(44),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  //margin: EdgeInsets.only(top: 14, bottom: 17),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xffF5F7FB),
                    backgroundImage: _imageFile != null
                        ? FileImage(File(_imageFile!.path))
                        : AssetImage(
                                'assets/images/android/OfflineBooking/profile_placeholder.png')
                            as ImageProvider,
                  ),
                ),
                Positioned(
                  height: 24,
                  width: 24,
                  right: 5,
                  top: 20,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              height: MediaQuery.of(context).size.height * 0.1,
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
                                            style:
                                                TextStyle(color: Colors.black),
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
                                            style:
                                                TextStyle(color: Colors.black),
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
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 14),
            child: Row(
              children: [
                Text(
                  'Services',
                  style: TextStyle(
                      color: AppColor.headingTitleColor,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
                Text(
                  '  (you can select multiple)',
                  style: TextStyle(
                      color: AppColor.textBoxBorderColor,
                      fontFamily: 'Raleway',
                      fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            height: 108,
            margin: EdgeInsets.only(left: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: availableServicesList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, i) {
                ServiceAllIconsWidget.getServiceIcons(
                    availableServicesList[i].iconid);
                return Container(
                  margin: EdgeInsets.only(left: 6, right: 6, top: 0),
                  //choosing a service
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        availableServicesList[i].isSelected =
                            !availableServicesList[i].isSelected;
                        Servicedetail newObject = new Servicedetail(
                          serviceid: availableServicesList[i].servicedtlid,
                          totaltime: availableServicesList[i].approxtime,
                        );
                        print(
                            'selected service : ${availableServicesList[i].servicename} - ${availableServicesList[i].isSelected}');
                        //adding object to servicedtl
                        if (availableServicesList[i].isSelected == true) {
                          totalTimeMM = totalTimeMM +
                              availableServicesList[i].approxtime!;
                          setState(() {
                            servicedtl.add(newObject);
                          });
                          print('servicedtl  if: $servicedtl');
                        } else if (availableServicesList[i].isSelected ==
                            false) {
                          setState(() {
                            servicedtl.removeAt(i);
                          });

                          print('servicedtl  remove : $servicedtl');
                          totalTimeMM = totalTimeMM -
                              availableServicesList[i].approxtime!;
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            //if service is chosen then show blue border else normal border
                            availableServicesList[i].isSelected
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff01519B59),
                                          blurRadius: 6,
                                          // offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2,
                                              color: Color(0xff01519B))),
                                      padding: EdgeInsets.all(8),
                                      child: Image.asset(
                                        '${ServiceAllIconsWidget.iconsAsset}',
                                        height: 32,
                                        width: 32,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: AppColor.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                AppColor.textBoxBorderColor)),
                                    padding: EdgeInsets.all(8),
                                    child: Image.asset(
                                      '${ServiceAllIconsWidget.iconsAsset}',
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("${availableServicesList[i].servicename}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.headingTitleColor,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Positioned(
                            right: 0,
                            child: Container(
                              child: SvgPicture.asset(
                                availableServicesList[i].isSelected
                                    ? 'assets/images/android/Login/checked.svg'
                                    : 'assets/images/android/Login/unchecked.svg',
                                width: 22,
                                height: 22,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Text(
              'Book Slot',
              style: TextStyle(
                  color: AppColor.headingTitleColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
          ),
          //Bokking Slote slider

          Container(
              padding: EdgeInsets.only(
                left: 10,
                top: 12,
              ),
              child: Image.asset(
                  'assets/images/android/Customer_Assets/Booking_slot/slot_slider.PNG')),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  Selected Slot',
                      style: TextStyle(
                          color: AppColor.headingTitleColor,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showTimePicker();
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
                        margin: EdgeInsets.only(left: 0, right: 8),
                        height: 50.0,
                        width: width * 0.39,
                        child: TextFormField(
                          controller: selectedSlotController,
                          enabled: false,
                          style: TextStyle(
                              color: AppColor.blueColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select time',
                            hintStyle: TextStyle(
                                color: AppColor.textBoxBorderColor,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 14),
                            fillColor: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '   Approx. time',
                      style: TextStyle(
                          color: AppColor.headingTitleColor,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: AppColor.whiteColor,
                        border: Border.all(
                            color: Color(0xffC6C7E3), style: BorderStyle.solid),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff26273D29),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: 0, right: 8),
                      height: 50.0,
                      width: width * 0.39,
                      child: TextFormField(
                        readOnly: true,
                        //controller: selectedSlotController,
                        enabled: false,
                        style: TextStyle(
                            color: AppColor.blueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: (totalTimeMM != 0)
                              ? '${totalTimeMM}min'
                              : 'Select Service',
                          hintStyle: (totalTimeMM != 0)
                              ? TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xff01519B),
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  color: AppColor.textBoxBorderColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 20, right: 14),
                          fillColor: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //BOOK THIS SLOT button
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
                offlineAppointmentApiCall();
              },
              child: Container(
                child: Text(
                  "BOOK THIS SLOT".toUpperCase(),
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

          //coStyleMasterWidget(),
        ],
      ),
    );
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

  //get stylemasterid from login response
  getstyleMasterId() async {
    styleMasterId = await styleMasterPreferences.getstylemasterid();
    print('stylemasterid : $styleMasterId');
    getAvailableServicesApiCall();
  }

  //API call function for getting services
  getAvailableServicesApiCall() async {
    final getAvailableServicesProvider =
        Provider.of<GetAvailableServicesProvider>(context, listen: false);

    var body = {
      "stylemasterid": styleMasterId,
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result =
        await getAvailableServicesProvider.getPostAvailableServicesData(
            Config.strBaseURL + Config.envVariable + getAvailableServicesURL,
            body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      for (var i = 0; i < result.body.length; i++) {
        setState(() {
          //styleMastersListData =result.body[i];
          availableServicesList.add(result.body[i]);
        });
      }
      print('data : $availableServicesList');
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //API call function declare
  offlineAppointmentApiCall() async {
    final offlineAppointmentProvider =
        Provider.of<OfflineAppointmentProvider>(context, listen: false);
    print('servicedetail :- ${servicedtl}');
    var body = {
      "stylemasterid": styleMasterId,
      "servicedtl": servicedtl,
      "totaltimemm": totalTimeMM,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp,
      "servicedate": date[0] + ' ' + selectedSlotController.text
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await offlineAppointmentProvider.getPostOfflineAppointmentdata(
        Config.strBaseURL + Config.envVariable + offlineAppointmentURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Appointment is booked");
      Navigator.pop(context);
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}

class Servicedetail {
  int? serviceid;
  int? totaltime;

  Servicedetail({this.serviceid, this.totaltime});

  Servicedetail.fromJson(Map<String, dynamic> json) {
    serviceid = json['serviceid'];
    totaltime = json['totaltime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceid'] = this.serviceid;
    data['totaltime'] = this.totaltime;
    return data;
  }
}
