import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';

class AccountButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  AccountButtonWidget({Key key, @required this.text, @required this.onPressed})
      : assert(text != null, onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: aColor2,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Text(
        text,
        style: TextStyle(color: pColor2),
      ),
    );
  }
}
