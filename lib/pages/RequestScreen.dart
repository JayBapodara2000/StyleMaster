import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stylemaster/models/MyAppointmentModel.dart';
import 'package:stylemaster/pages/MenuScreen.dart';
import 'package:stylemaster/pages/OfflineAppointment.dart';
import 'package:stylemaster/providers/AccepteRejectAppointmentProvider.dart';
import 'package:stylemaster/providers/MyAppointmentProvider.dart';
import 'package:stylemaster/utils/AppColor.dart';
import 'package:stylemaster/utils/Config.dart';
import 'package:stylemaster/utils/ConstantsURL.dart';
import 'package:stylemaster/utils/StyleMasterPreferences.dart';
import 'package:intl/intl.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  var selectedDate = 'Select Date';
  var date;
  bool _switchValue = false;
  int _currentIndex = 0;

  List<Body> myAppointmentData = [];
  int? styleMasterId;

  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();

  @override
  void initState() {
    getStyleMasterID();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          'Requests',
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
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => MenuScreen(
                          configure: false,
                        )),
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
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: date == null ? DateTime.now() : date,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2030))
                    .then((val) {
                  setState(() {
                    date = val;
                    final DateFormat formatter = DateFormat('dd-MM-yyyy EEEE');
                    final String formatted = formatter.format(date);
                    selectedDate = formatted;
                    print('date : $selectedDate');
                  });
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColor.blueColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range_outlined,
                          color: AppColor.whiteColor, size: 22),
                      SizedBox(
                        width: 12,
                      ),
                      Text('$selectedDate',
                          style: TextStyle(
                              fontFamily: 'Raleway-Bold',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.whiteColor),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: myAppointmentData.length,
                    itemBuilder: (context, i) {
                      List<String>? service =
                          myAppointmentData[i].services?.split(",");
                      String? requestUserName =
                          myAppointmentData[i].styleBuddyName;

                      String service1 = service![0];
                      String service2;
                      if (service.length > 1) {
                        service2 = service[1];
                      } else {
                        service2 = "";
                      }
                      List<String>? time =
                          myAppointmentData[i].bookingDate?.split(" ");
                      String time1 = time![1];
                      String time2 = time[2];
                      return Container(
                        child: GestureDetector(
                          onTap: () =>
                              openServiceListModel(myAppointmentData[i]),
                          child: Stack(children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 24,
                                right: 31,
                                top: 20,
                              ),
                              height: 144,
                              width: MediaQuery.of(context).size.width * (0.85),
                              decoration: BoxDecoration(
                                border:
                                    /*  _switchValue
                                    ? Border.all(
                                        width: 1,
                                        color: AppColor.textBoxBorderColor)
                                    : */
                                    Border.all(
                                        width: 0, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    /*   _switchValue
                                    ? AppColor.whiteColor
                                    : */
                                    Color(0xff01519B),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 14, right: 0),
                                    child: Text(
                                      '$requestUserName',
                                      style: TextStyle(
                                        fontFamily: 'Raleway-Bold',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            /* _switchValue
                                            ? AppColor.blackColor
                                            : */
                                            Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 6.93),
                                        child: SvgPicture.asset(
                                          'assets/images/android/Requests/Requested_Service.svg',
                                          width: 12.07,
                                          height: 17.42,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '$service1',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Raleway-Regular',
                                            fontSize: 14,
                                            color: Color(0xffc6c7e3),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  service2 != ""
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 6.93),
                                              child: SvgPicture.asset(
                                                'assets/images/android/Requests/Requested_Service.svg',
                                                width: 12.07,
                                                height: 17.42,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.42,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${service2}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Raleway-Regular',
                                                      fontSize: 14,
                                                      color: Color(0xffc6c7e3),
                                                    ),
                                                  ),
                                                  if (service.length > 2)
                                                    InkWell(
                                                      onTap: () =>
                                                          openServiceListModel(
                                                              myAppointmentData[
                                                                  i]),
                                                      child: Text(
                                                        '..(more)',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Raleway-Regular',
                                                          fontSize: 14,
                                                          color: Colors
                                                              .amberAccent,
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 3.47),
                                        child: SvgPicture.asset(
                                          'assets/images/android/Requests/time.svg',
                                          width: 12.07,
                                          height: 17.42,
                                        ),
                                      ),
                                      Text(
                                        '$time1 $time2',
                                        style: TextStyle(
                                          fontFamily: 'Raleway-Regular',
                                          fontSize: 14,
                                          color: Color(0xffc6c7e3),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var activeServiceID =
                                              myAppointmentData[i].actServeID;
                                          print('id $activeServiceID');
                                          declineServicesModel(
                                              activeServiceID!, true);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                width: 1,
                                                color:
                                                    AppColor.textBoxBorderColor,
                                              )),
                                          child: Text(
                                            "Decline",
                                            style: TextStyle(
                                                color: Colors.amberAccent,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 8,
                                    ),
                                    height: 20,
                                    width: 62,
                                    child: Switch(
                                      value: _currentIndex == i
                                          ? _switchValue
                                          : false,
                                      inactiveTrackColor: Color(0xff00305D),
                                      activeTrackColor: Color(0xffFC62B2),
                                      activeColor: Color(0xffFC62B2),
                                      inactiveThumbColor: Color(0xff00305D),
                                      onChanged: (bool value) {
                                        setState(() {
                                          _currentIndex = i;
                                          _switchValue = value;
                                          print('_switchValue : $_switchValue');
                                        });
                                        var activeServiceID =
                                            myAppointmentData[i].actServeID;
                                        print('id $activeServiceID');
                                        declineServicesModel(
                                            activeServiceID!, false);
                                      },
                                      activeThumbImage: new AssetImage(
                                          'assets/images/android/Requests/completed.png'),
                                      inactiveThumbImage: new AssetImage(
                                          'assets/images/android/Requests/incomplete.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              height: 175,
                              width: 149,
                              right: 34,
                              bottom: -10,
                              child: Container(
                                child: Image.asset(
                                  'assets/images/android/Requests/req_male4.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38.5),
          boxShadow: [
            BoxShadow(
              color: Color(0xff00000029),
              blurRadius: 6,
            ),
          ],
        ),
        padding: EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30.54,
          ),
          backgroundColor: Colors.lightGreen,
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerBookingSlotScreen()))
                .then((value) {
              myAppointmentApiCall();
            });
          },
        ),
      ),
    );
  }

  void openServiceListModel(Body myAppointmentData) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 20),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  elevation: 10,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12.0)),
                  content: MyServiceListContent(myAppointmentData)),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        }).then((value) {
      myAppointmentApiCall();
    });
  }

//decline button Services Model code
  void declineServicesModel(int activeServiceID, bool isDecline) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: isDecline
                    ? Text('Are you sure you want to decline this service ?')
                    : Text('Are you sure you want to finish this service ?'),
                actionsPadding: EdgeInsets.only(right: 10),
                actions: [
                  FlatButton(
                    color: Colors.red,
                    child: Text(
                      "Yes",
                      style: TextStyle(color: AppColor.whiteColor),
                    ),
                    onPressed: () {
                      print('model id : $activeServiceID');
                      accepteRejectAppointmentApiCall(activeServiceID);
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    color: Colors.green,
                    child: Text(
                      "No",
                      style: TextStyle(color: AppColor.whiteColor),
                    ),
                    onPressed: () {
                      setState(() {
                        _switchValue = false;
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  getStyleMasterID() async {
    return await styleMasterPreferences.getstylemasterid().then((value) {
      setState(() {
        styleMasterId = value;
        myAppointmentApiCall();
      });
    });
  }

/*   //get stylemasterid from login response
  getstyleMasterId() async {
    styleMasterId = await styleMasterPreferences.getstylemasterid();
    print('stylemasterid : $styleMasterId');
    myAppointmentApiCall();
  } */

  myAppointmentApiCall() async {
    myAppointmentData.clear();
    final myAppointmentProvider =
        Provider.of<MyAppointmentProvider>(context, listen: false);
    var body = {"stylemasterid": styleMasterId};
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await myAppointmentProvider.getPostMyAppointmentData(
        Config.strBaseURL + Config.envVariable + myAppointmentURL, body);
    print("apiResponse : $result");

    if (result.statusCode == 200) {
      setState(() {
        _switchValue = false;
      });
      Loader.hide();
      for (var i = 0; i < result.body.length; i++) {
        setState(() {
          myAppointmentData.add(result.body[i]);
        });
        print("myAppointmentData :$myAppointmentData");
      }
      Loader.hide();
    } else {
      Loader.hide();
    }
  }

  accepteRejectAppointmentApiCall(int activeServiceID) async {
    final accepteRejectAppointmentProvider =
        Provider.of<AccepteRejectAppointmentProvider>(context, listen: false);

    var body = {"actserveid": activeServiceID, "acceptancestatus": 1};

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await accepteRejectAppointmentProvider
        .getPostAccepteRejectAppointmentData(
            Config.strBaseURL + Config.envVariable + accepteRejectAppointment,
            body);
    print("apiResponse : $result");

    if (result.statusCode == 200) {
      Loader.hide();
      myAppointmentApiCall();
      Fluttertoast.showToast(msg: "Request service decline successfully");
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}

//AllServiceListDialogClass
class MyServiceListContent extends StatefulWidget {
  final Body myAppointmentData;

  MyServiceListContent(this.myAppointmentData);

  @override
  MyServiceListContentState createState() => MyServiceListContentState();
}

class MyServiceListContentState extends State<MyServiceListContent> {
  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();

  bool _switchValue = false;

  _getContent(myAppointmentData) {
    List<String> clist = myAppointmentData.services.split(",");
    print('data : $clist');

    List<String>? time = myAppointmentData.bookingDate?.split(" ");
    String time1 = time![1];
    String time2 = time[2];
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 0, right: 0, top: 0),
          // height: MediaQuery.of(context).size.height * 0.28,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: _switchValue
                ? Border.all(width: 1, color: AppColor.textBoxBorderColor)
                : Border.all(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
            color: _switchValue ? AppColor.whiteColor : Color(0xff01519B),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 14, right: 0),
                child: Text(
                  '${myAppointmentData.styleBuddyName}',
                  style: TextStyle(
                    fontFamily: 'Raleway-Bold',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        _switchValue ? AppColor.blackColor : Color(0xffffffff),
                  ),
                ),
              ),
              /*    SizedBox(
                height: 8,
              ), */
              ListView.builder(
                  itemCount: clist.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 12),
                  itemBuilder: (context, i) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 6.93, bottom: 6),
                          child: SvgPicture.asset(
                            'assets/images/android/Requests/Requested_Service.svg',
                            width: 12.07,
                            height: 17.42,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${clist[i]}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Raleway-Regular',
                              fontSize: 14,
                              color: Color(0xffc6c7e3),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: 7,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 3.47),
                    child: SvgPicture.asset(
                      'assets/images/android/Requests/time.svg',
                      width: 12.07,
                      height: 17.42,
                    ),
                  ),
                  Text(
                    '$time1 $time2',
                    style: TextStyle(
                      fontFamily: 'Raleway-Regular',
                      fontSize: 14,
                      color: Color(0xffc6c7e3),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      var activeServiceID = myAppointmentData.actServeID;
                      print('id $activeServiceID');

                      declineServicesModelAllServices(activeServiceID!);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: AppColor.textBoxBorderColor,
                          )),
                      child: Text(
                        "Decline",
                        style: TextStyle(
                            color: Colors.amberAccent,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 8,
                ),
                height: 20,
                width: 62,
                child: Switch(
                  value: _switchValue,
                  inactiveTrackColor: Color(0xff00305D),
                  activeTrackColor: Color(0xffFC62B2),
                  activeColor: Color(0xffFC62B2),
                  inactiveThumbColor: Color(0xff00305D),
                  onChanged: (bool value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                  activeThumbImage: new AssetImage(
                      'assets/images/android/Requests/completed.png'),
                  inactiveThumbImage: new AssetImage(
                      'assets/images/android/Requests/incomplete.png'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Positioned(
          height: 190,
          width: 185,
          right: 0,
          bottom: -10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.asset(
              'assets/images/android/Requests/req_male4.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  //decline button Services Model code for open all services
  void declineServicesModelAllServices(int activeServiceID) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text('Are you sure you want to decline this service ?'),
                actionsPadding: EdgeInsets.only(right: 10),
                actions: [
                  FlatButton(
                    color: Colors.red,
                    child: Text(
                      "Yes",
                      style: TextStyle(color: AppColor.whiteColor),
                    ),
                    onPressed: () {
                      print('model id : $activeServiceID');
                      accepteRejectAppointmentApiCall(activeServiceID);

                      //-
                      Navigator.pop(context);
                      setState(() {
                        _switchValue = false;
                      });
                    },
                  ),
                  FlatButton(
                    color: Colors.green,
                    child: Text(
                      "No",
                      style: TextStyle(color: AppColor.whiteColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    print('myAppointmentData : ${widget.myAppointmentData}');

    return _getContent(widget.myAppointmentData);
  }

  accepteRejectAppointmentApiCall(int activeServiceID) async {
    final accepteRejectAppointmentProvider =
        Provider.of<AccepteRejectAppointmentProvider>(context, listen: false);

    var body = {"actserveid": activeServiceID, "acceptancestatus": 1};

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await accepteRejectAppointmentProvider
        .getPostAccepteRejectAppointmentData(
            Config.strBaseURL + Config.envVariable + accepteRejectAppointment,
            body);
    print("apiResponse : $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Navigator.pop(context);

      Fluttertoast.showToast(msg: "Request service decline successfully");
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
