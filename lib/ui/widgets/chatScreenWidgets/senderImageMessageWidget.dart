import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class SenderImageMessageWidget extends StatelessWidget {
  final UserModel currentUser;
  final MessageModel messageModel;

  SenderImageMessageWidget(
      {Key key, @required this.currentUser, @required this.messageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: getPropHeight(20), horizontal: getPropWidth(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DisplayImageMessageWidget(url: messageModel.url, isSender: true),
          SizedBox(width: getPropWidth(5)),
          SizedBox(
              height: getPropHeight(45),
              width: getPropWidth(42),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.profileImage))),
        ],
      ),
    );
  }
}
