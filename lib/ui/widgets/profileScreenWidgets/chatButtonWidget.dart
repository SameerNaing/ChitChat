import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class ChatButtonWidget extends StatelessWidget {
  final DisplayUserModel user;
  ChatButtonWidget({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigateToChatScreenWidget.navigate(context,
          reciverId: user.uid, reciverUserName: user.name),
      child: Container(
        height: getPropHeight(40),
        width: getPropWidth(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: aColor1, width: 1),
        ),
        child: Icon(Icons.email, color: aColor1),
      ),
    );
  }
}
