import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';

class AccountErrorMessageBox extends StatelessWidget {
  final String errormessage;
  const AccountErrorMessageBox({Key key, @required this.errormessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getPropHeight(50)),
      height: getPropHeight(90),
      width: getPropWidth(280),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: errorColor.withOpacity(0.9),
      ),
      child: Padding(
          padding: EdgeInsets.only(
              left: getPropWidth(12),
              right: getPropWidth(12),
              top: getPropHeight(12)),
          child: Text(errormessage,
              style: TextStyle(color: pColor2, fontWeight: FontWeight.w500))),
    );
  }
}
