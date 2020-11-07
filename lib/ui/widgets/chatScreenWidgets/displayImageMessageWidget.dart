import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chit_chat/ui/ui.dart';

class DisplayImageMessageWidget extends StatelessWidget {
  final String url;
  final bool isSender;

  DisplayImageMessageWidget({
    @required this.url,
    @required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getPropHeight(200),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => Center(child: _placeHolder(context)),
        ),
      ),
    );
  }

  Widget _placeHolder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: pColor1.withAlpha(99),
      ),
      height: getPropHeight(240),
      width: getPropWidth(240),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
