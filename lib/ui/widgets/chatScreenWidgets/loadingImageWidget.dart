import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class LoadingImageWidget extends StatelessWidget {
  const LoadingImageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: getPropHeight(20),
        horizontal: getPropWidth(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: pColor1.withAlpha(99),
            ),
            height: getPropHeight(240),
            width: getPropWidth(240),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          SizedBox(width: getPropWidth(5)),
          SizedBox(
              height: getPropHeight(45),
              width: getPropWidth(42),
              child: CircleAvatar(
                backgroundColor: pColor1.withAlpha(99),
              )),
        ],
      ),
    );
  }
}
