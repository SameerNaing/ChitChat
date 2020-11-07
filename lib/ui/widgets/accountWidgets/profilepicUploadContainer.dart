import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class ProfilePicUploadContainer extends StatelessWidget {
  const ProfilePicUploadContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: getPropHeight(100),
        width: getPropWidth(100),
        decoration: BoxDecoration(
          border: Border.all(color: aColor2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Icon(Icons.camera_enhance,
                size: getPropHeight(40), color: aColor2)));
  }
}
