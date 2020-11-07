import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class PeopleHeaderWidget extends StatelessWidget {
  final String header;
  PeopleHeaderWidget({Key key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: getPropHeight(25),
        left: getPropWidth(20),
      ),
      alignment: Alignment.topLeft,
      child: Text(header ?? 'Null',
          style: TextStyle(
            color: aColor2,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            fontSize: getPropWidth(18),
          )),
    );
  }
}
