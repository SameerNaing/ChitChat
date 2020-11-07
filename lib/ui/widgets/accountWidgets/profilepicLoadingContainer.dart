import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:chit_chat/ui/ui.dart';

class ProfilePicLoadingContainer extends StatelessWidget {
  const ProfilePicLoadingContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
          height: getPropHeight(100),
          width: getPropWidth(100),
          decoration: BoxDecoration(
            border: Border.all(color: aColor2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
              child: Icon(Icons.camera_enhance,
                  size: getPropHeight(40), color: aColor2))),
      baseColor: aColor2.withOpacity(0.6),
      highlightColor: Colors.white12,
    );
  }
}
