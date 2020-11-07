import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class HomeScreen extends StatelessWidget {
  HomeScreenStates homeScreenStates;
  HomeScreen({Key key, @required this.homeScreenStates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: _buildPage(),
        ),
      ),
    );
  }

  _buildPage() {
    if (homeScreenStates.conversations == null) {
      return Container(
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return _getColumn();
    }
  }

  Widget _getColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderWidget(header: 'Conversations'),
        ConversationsListWidget(
            displayMessages: homeScreenStates.conversations),
      ],
    );
  }
}
