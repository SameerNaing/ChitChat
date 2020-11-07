import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class NewTagWidget extends StatelessWidget {
  NewTagWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: aColor1,
        ),
        height: getPropHeight(40),
        width: getPropWidth(60),
        child: Center(
          child: Text('New',
              style: TextStyle(
                color: pColor2,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              )),
        ),
      ),
    );
  }
}
