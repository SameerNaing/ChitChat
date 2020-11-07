import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/ui/ui.dart';

class PageAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<DisplayUserModel> allUsers;
  PageAppBarWidget({
    Key key,
    @required this.title,
    @required this.allUsers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getAppBarContent(context);
  }

  Widget _getAppBarContent(BuildContext context) {
    return Container(
      height: getPropHeight(500),
      decoration: BoxDecoration(
        color: pColor2,
      ),
      child: Row(
        children: [
          Spacer(flex: 1),
          Container(
            width: getPropWidth(100),
            child: Text(title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: getPropWidth(19),
                  color: aColor2,
                )),
          ),
          Spacer(flex: 7),
          IconButton(
            iconSize: getPropWidth(30),
            splashRadius: getPropWidth(30),
            color: aColor2,
            icon: Icon(Icons.search),
            onPressed: () {
              NavigateToSearchScreenWidget.navigate(context: context);
            },
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}
