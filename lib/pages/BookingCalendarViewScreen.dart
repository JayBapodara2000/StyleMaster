import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/AppColor.dart';
import '../utils/ConstantsVariable.dart';

class BookingCalendarViewScreen extends StatefulWidget {
  @override
  _BookingCalendarViewScreenState createState() =>
      _BookingCalendarViewScreenState();
}

class _BookingCalendarViewScreenState extends State<BookingCalendarViewScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.blueColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTableCalendar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Text(
                      'Today\'s Appointment',
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10, top: 40),
                    child: Text(
                      '2 events',
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontFamily: 'Raleway',
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              eventsWidget(),
              //widget to view Future events when date is selected
              futureEventsWidget(),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget _buildTableCalendar() {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xffC6C7E3), width: 1),
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
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
      focusedDay: DateTime.now(),
      /*focusedDay: selectedDay,
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
      },*/
    ),
  );
}

Widget eventsWidget() {
  return Container(
    child: Column(
      children: [
        Container(
          height: height * 0.123,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '08 am',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontSize: 20),
                ),
              ),
              SizedBox(
                width: 9,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.pink,
                  ),
                  DottedLine(
                    dashLength: 5,
                    dashGapLength: 5,
                    lineThickness: 2,
                    dashColor: Colors.white,
                    direction: Axis.vertical,
                    lineLength: ((height * 0.123) - 16),
                  ),
                ],
              ),
              SizedBox(
                width: 9,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.only(left: 10),
                      height: height * 0.123,
                      width: width * 0.678,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service I took',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 18,
                                  color: AppColor.textBoxBorderColor),
                            ),
                            Text(
                              'Hair cut & Coloring',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Bold',
                                  fontSize: 15,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Style Master',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 18,
                                  color: AppColor.textBoxBorderColor),
                            ),
                            Text(
                              'Steve Smith',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 15,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: height * 0.123,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '09 am',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontSize: 20),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              DottedLine(
                dashLength: 5,
                dashGapLength: 5,
                lineThickness: 2,
                dashColor: Colors.white,
                direction: Axis.vertical,
                //lineLength: 150,
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: height * 0.123,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '10 am',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontSize: 21),
                ),
              ),
              SizedBox(
                width: 17,
              ),
              DottedLine(
                dashLength: 5,
                dashGapLength: 5,
                lineThickness: 2,
                dashColor: Colors.white,
                direction: Axis.vertical,
                //lineLength: 150,
              ),
              SizedBox(
                width: 17,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: height * 0.123,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '11 am',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontSize: 21),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              DottedLine(
                dashLength: 5,
                dashGapLength: 5,
                lineThickness: 2,
                dashColor: Colors.white,
                direction: Axis.vertical,
                //lineLength: 150,
              ),
              SizedBox(
                width: 16,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.only(left: 10),
                      height: height * 0.123,
                      width: width * 0.674,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service I took',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 18,
                                  color: AppColor.textBoxBorderColor),
                            ),
                            Text(
                              'Hair cut & Coloring',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Bold',
                                  fontSize: 15,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Style Master',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 18,
                                  color: AppColor.textBoxBorderColor),
                            ),
                            Text(
                              'Steve Smith',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 15,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: height * 0.123,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '12 pm',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontSize: 21),
                ),
              ),
              SizedBox(
                width: 17,
              ),
              DottedLine(
                dashLength: 5,
                dashGapLength: 5,
                lineThickness: 2,
                dashColor: Colors.white,
                direction: Axis.vertical,
                //lineLength: 150,
              ),
              SizedBox(
                width: 14,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: height * 0.123,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '01 pm',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontSize: 20),
                ),
              ),
              SizedBox(
                width: 18,
              ),
              DottedLine(
                dashLength: 5,
                dashGapLength: 5,
                lineThickness: 2,
                dashColor: Colors.white,
                direction: Axis.vertical,
                //lineLength: 150,
              ),
              SizedBox(
                width: 18,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: height * 0.123,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '02 pm',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontSize: 20),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              DottedLine(
                dashLength: 5,
                dashGapLength: 5,
                lineThickness: 2,
                dashColor: Colors.white,
                direction: Axis.vertical,
                //lineLength: 150,
              ),
              SizedBox(
                width: 18,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.only(left: 10),
                      height: height * 0.123,
                      width: width * 0.674,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service I took',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 18,
                                  color: AppColor.textBoxBorderColor),
                            ),
                            Text(
                              'Hair cut & Coloring',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Bold',
                                  fontSize: 15,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Style Master',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 18,
                                  color: AppColor.textBoxBorderColor),
                            ),
                            Text(
                              'Steve Smith',
                              style: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 15,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    ),
  );
}

Widget futureEventsWidget() {
  return Container(
    child: Column(
      children: [
        Container(
          color: Colors.blue,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Dec 22',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  '3 events',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: 'Raleway',
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        eventsWidget()
      ],
    ),
  );
}
