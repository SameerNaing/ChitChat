import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class SendTextMessageButtonWidget extends StatelessWidget {
  final bool activate;

  final Function onPressed;
  SendTextMessageButtonWidget({Key key, this.activate, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 26,
      iconSize: getPropWidth(30),
      icon: Icon(Icons.send),
      color: activate ? pColor1 : pColor1.withOpacity(0.5),
      onPressed: onPressed,
    );
  }
}
