import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui_config/uiConfig.dart';

class OnBoardingWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String svg;
  const OnBoardingWidget(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.svg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        children: [
          SizedBox(height: getPropHeight(30)),
          Text(
            title,
            style: TextStyle(
              color: pColor1,
              fontSize: getPropWidth(40),
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: getPropHeight(30)),
          Center(
            // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              subtitle,
              style: TextStyle(
                color: aColor2,
                fontSize: getPropWidth(15),
                fontFamily: 'Roboto',
              ),
            ),
          ),
          SizedBox(height: getPropHeight(30)),
          Padding(
            padding: EdgeInsets.all(0),
            // padding: EdgeInsets.only(right: 10, left: 10, bottom: 26),
            child: SvgPicture.asset(
              svg,
              height: getPropHeight(300),
              width: getPropWidth(300),
            ),
          ),
        ],
      ),
    );
  }
}
