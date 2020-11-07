import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MessageStates state;
  final String reciverName;
  ChatScreenAppBar({Key key, @required this.state, @required this.reciverName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPropHeight(700),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: aColor2.withAlpha(89))),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: aColor2),
            splashRadius: 23,
            onPressed: () => Navigator.of(context).pop(),
          ),
          Spacer(flex: 3),
          _getName(),
          Spacer(flex: 4),
        ],
      ),
    );
  }

  Widget _getName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(reciverName,
            style: TextStyle(
                color: aColor2,
                fontFamily: 'Roboto',
                fontSize: getPropWidth(18))),
      ],
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 20);
}
