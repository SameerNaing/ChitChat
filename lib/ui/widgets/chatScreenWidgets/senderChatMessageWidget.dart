import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class SenderChatMessageWidget extends StatelessWidget {
  final UserModel currentUser;
  final MessageModel messageModel;
  SenderChatMessageWidget(
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: pColor1,
            ),
            constraints:
                BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.65),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getPropHeight(23), vertical: getPropWidth(15)),
              child: Text(
                messageModel.message,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: pColor2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
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
