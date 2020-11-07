import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:chit_chat/ui/ui.dart';

class LoadingTextMessageWidget extends StatelessWidget {
  const LoadingTextMessageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getPropWidth(10)),
      height: getPropHeight(80),
      width: SizeConfig.screenWidth,
      child: Align(
        alignment: Alignment.centerRight,
        child: Shimmer.fromColors(
          highlightColor: Colors.white12,
          baseColor: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[400],
                ),
                height: getPropHeight(60),
                width: getPropWidth(100),
              ),
              SizedBox(width: getPropWidth(5)),
              SizedBox(
                height: getPropHeight(45),
                width: getPropWidth(42),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
