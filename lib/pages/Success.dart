import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylemaster/pages/RequestScreen.dart';

class TutorialOverlay extends ModalRoute<void> {

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.transparent.withOpacity(1);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 71, right: 71, top: 234),
            height: 160,
            width: 160,
            child: SvgPicture.asset(
                'assets/images/android/Acc_Success/Success_icon.svg'
            ),
          ),
          SizedBox(height: 18,),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 53),
                child: Text(
                  'Successfully',
                  style: TextStyle(
                    fontFamily: 'Raleway-Black',
                    fontSize: 29,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff000F1D),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 53),
                child: Text(
                  'your account done',
                  style: TextStyle(
                    fontFamily: 'Raleway-Black',
                    fontSize: 29,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff000F1D),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 34),
            child: Text(
              'Now Enjoy StyleBuddy app',
              style: TextStyle(
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
                color: Color(0xffa4a4a4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

}


