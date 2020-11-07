import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class ProfilePicReuploadButton extends StatelessWidget {
  const ProfilePicReuploadButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getPropHeight(20)),
      decoration: BoxDecoration(
        border: Border.all(color: aColor1, width: 1.5),
        borderRadius: BorderRadius.circular(30),
      ),
      height: getPropHeight(40),
      width: getPropWidth(100),
      child: Row(
        children: [
          Spacer(flex: 1),
          Icon(
            Icons.refresh,
            color: aColor1,
            size: getPropWidth(20),
          ),
          Spacer(flex: 1),
          Text(
            'Reupload',
            style: TextStyle(
              color: aColor1,
              fontFamily: 'Roboto',
              fontSize: getPropWidth(12),
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
