import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class DisplayMessageListItem extends StatelessWidget {
  final DisplayMessageModel displayMessage;
  DisplayMessageListItem({Key key, @required this.displayMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPropHeight(90),
      margin: EdgeInsets.only(top: getPropHeight(25)),
      padding: EdgeInsets.only(left: getPropWidth(12)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: getPropHeight(90),
            width: getPropWidth(75),
            child:
                PeopleProfileImageWidget(imgUrl: displayMessage.profilPicUrl),
          ),
          SizedBox(width: getPropWidth(12)),
          Expanded(
              child: Container(
            height: getPropHeight(90),
            child: NameAndLastMessageWidget(displayMessage: displayMessage),
          )),
          Container(
            margin: EdgeInsets.only(
              bottom: getPropHeight(39),
              right: getPropWidth(12),
              top: getPropHeight(12),
            ),
            padding: EdgeInsets.all(5),
            width: getPropWidth(70),
            height: getPropHeight(90),
            child: displayMessage.isNew ? NewTagWidget() : Container(),
          ),
        ],
      ),
    );
  }
}
