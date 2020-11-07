import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/utils/utilities.dart';

class UserStatesWidget extends StatelessWidget {
  final UserModel user;
  UserStatesWidget({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPropHeight(50),
      width: getPropWidth(300),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _getFriendsNum(),
            _getStatusInfo(),
          ],
        ),
      ),
    );
  }

  Widget _getFriendsNum() {
    return Column(
      children: [
        Text(
          Utilities.readableFormat(user.numFriends),
          style: TextStyle(
            color: pColor2,
            fontSize: getPropWidth(16),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getPropHeight(3)),
        Text(
          'Friends',
          style: TextStyle(
            fontSize: getPropWidth(14),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: pColor2,
          ),
        )
      ],
    );
  }

  Widget _getStatusInfo() {
    return Column(
      children: [
        Text(
          user.relationStatus,
          style: TextStyle(
            color: pColor2,
            fontSize: getPropWidth(16),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getPropHeight(3)),
        Text(
          'Status',
          style: TextStyle(
            fontSize: getPropWidth(14),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: pColor2,
          ),
        )
      ],
    );
  }
}
