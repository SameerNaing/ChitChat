import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:chit_chat/ui/ui.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/SvgIcons/chat.svg',
                height: getPropHeight(100),
                width: getPropWidth(100),
              ),
              SizedBox(height: getPropHeight(30)),
              Text('CHIT CHAT',
                  style: TextStyle(
                      fontFamily: "Josefin Sans",
                      color: pColor1,
                      fontSize: getPropWidth(25))),
            ],
          ),
        ),
      ),
    );
  }
}
