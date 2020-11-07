import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';

class PeopleProfileImageWidget extends StatelessWidget {
  final String imgUrl;
  PeopleProfileImageWidget({Key key, @required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imgUrl,
      child: SizedBox(
        height: getPropHeight(60),
        width: getPropWidth(55),
        child: CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
        ),
      ),
    );
  }
}
