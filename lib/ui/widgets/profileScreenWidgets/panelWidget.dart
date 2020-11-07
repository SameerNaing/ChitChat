import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class PanelWidget extends StatelessWidget {
  final UserModel user;
  final UserRelation relation;
  PanelWidget({
    Key key,
    @required this.user,
    @required this.relation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserStatesWidget(user: user),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: getPropHeight(20),
              left: getPropWidth(19),
              right: getPropWidth(19),
            ),
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              color: Colors.white,
            ),
            child: UserAboutWidget(user: user, relation: relation),
          ),
        ),
      ],
    );
  }
}
