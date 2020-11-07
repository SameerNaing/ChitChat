import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class ProfilePicNotSelectedErrorText extends StatelessWidget {
  const ProfilePicNotSelectedErrorText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getPropHeight(20)),
      child: Text(
        'Select an Image',
        style: TextStyle(
          color: errorColor,
          fontFamily: 'Roboto',
          fontSize: getPropWidth(14),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
