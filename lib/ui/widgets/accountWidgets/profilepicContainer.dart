import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';

class ProfilePicContainer extends StatelessWidget {
  final String photoUrl;
  const ProfilePicContainer({Key key, @required this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          photoUrl,
          height: getPropHeight(250),
          width: getPropHeight(150),
          fit: BoxFit.fill,
        ));
  }
}
