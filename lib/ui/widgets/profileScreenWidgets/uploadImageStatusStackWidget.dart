import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class UploadImageStatusStackWidget extends StatelessWidget {
  final ProfileStates profileStates;
  final Widget child;
  UploadImageStatusStackWidget(
      {Key key, @required this.profileStates, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        _buildPage(),
      ],
    );
  }

  _buildPage() {
    if (profileStates.imageUploadStatus == ImageUploadStatus.Uploaded) {
      return Container();
    } else {
      return Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            child: _getContent(),
          ),
        ),
      );
    }
  }

  _getContent() {
    if (profileStates.imageUploadStatus == ImageUploadStatus.Uploading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Uploading...',
              style: TextStyle(
                  color: pColor1,
                  fontFamily: 'Roboto',
                  fontSize: getPropWidth(30))),
          SizedBox(height: getPropHeight(30)),
          SizedBox(
            width: getPropWidth(100),
            child: LinearProgressIndicator(),
          ),
          SizedBox(height: getPropHeight(40)),
        ],
      );
    } else if (profileStates.imageUploadStatus == ImageUploadStatus.Error) {
      return Center(
        child: Text('Sorry, Can\'t Upload Image.',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: getPropWidth(25),
              color: errorColor,
            )),
      );
    }
  }
}
