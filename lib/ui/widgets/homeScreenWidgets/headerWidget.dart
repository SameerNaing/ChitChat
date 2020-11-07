import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';

class HeaderWidget extends StatelessWidget {
  final String header;
  HeaderWidget({Key key, @required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: getPropHeight(20),
        left: getPropWidth(20),
      ),
      alignment: Alignment.topLeft,
      child: Text(header,
          style: TextStyle(
            color: aColor2,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            fontSize: getPropWidth(18),
          )),
    );
  }
}
