import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class HeaderText extends StatelessWidget {
  final String text;
  const HeaderText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'Null',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        fontSize: getPropWidth(26),
        color: aColor2,
      ),
    );
  }
}
