import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:chit_chat/ui/ui.dart';

class NoChatWidget extends StatelessWidget {
  const NoChatWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: getPropHeight(40)),
          SvgPicture.asset(
            'assets/SvgIcons/hello-speech.svg',
            color: pColor1,
            height: getPropHeight(200),
            width: getPropWidth(200),
          ),
          SizedBox(height: getPropHeight(10)),
          Text(
            'Say Hi to your firend...',
            style: TextStyle(
              color: pColor1,
              fontFamily: 'Roboto',
              fontSize: getPropWidth(20),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
