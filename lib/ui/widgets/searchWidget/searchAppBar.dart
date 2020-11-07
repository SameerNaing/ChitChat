import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPropHeight(500),
      decoration: BoxDecoration(
        color: pColor2,
      ),
      child: SearchAppBarContentWidget(),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}
