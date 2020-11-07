import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class NameAndLastMessageWidget extends StatelessWidget {
  final DisplayMessageModel displayMessage;
  NameAndLastMessageWidget({Key key, @required this.displayMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getPropHeight(14)),
        Text(displayMessage.name,
            style: TextStyle(
                color: aColor2,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: getPropWidth(18))),
        SizedBox(height: getPropHeight(3)),
        Text(_getLastMessage(displayMessage.lastMessage),
            style: TextStyle(
                color: aColor2,
                fontFamily: 'Roboto',
                fontWeight: displayMessage.isNew ? FontWeight.w700 : null,
                fontSize: getPropWidth(14))),
      ],
    );
  }

  String _getLastMessage(String message) {
    if (message.length > 26) {
      return message.substring(0, 16) + '....';
    } else {
      return message;
    }
  }
}
