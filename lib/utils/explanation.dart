import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExplanationData {
  final String title;
  final String description;
  final String localImageSrc;
  final Color backgroundColor;

  ExplanationData(
      {required this.title, required this.description, required this.localImageSrc, required this.backgroundColor});
}

class ExplanationPage extends StatelessWidget {
  final ExplanationData data;

  ExplanationPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: SvgPicture.asset(data.localImageSrc,
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width * 0.68,
                alignment: Alignment.center)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway-Regular',
                  color: Color(0xffA4A4A4),

                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: Text(
                    data.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Raleway-Regular',
                      color: Color(0xffA4A4A4),

                    ),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}