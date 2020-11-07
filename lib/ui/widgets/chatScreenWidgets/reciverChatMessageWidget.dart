import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class ReciverChatMessageWidget extends StatelessWidget {
  final UserModel reciver;
  final MessageModel messageModel;
  ReciverChatMessageWidget({
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: darkWhite,
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
                  color: aColor2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
