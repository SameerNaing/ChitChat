import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class ReciverImageMessageWidget extends StatelessWidget {
  final UserModel reciver;
  final MessageModel messageModel;
  ReciverImageMessageWidget({
    Key key,
    @required this.reciver,
    @required this.messageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: getPropHeight(20), horizontal: getPropWidth(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: getPropHeight(45),
              width: getPropWidth(42),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(reciver.profileImage))),
          SizedBox(width: getPropWidth(5)),
          DisplayImageMessageWidget(url: messageModel.url, isSender: false),
        ],
      ),
    );
  }
}
