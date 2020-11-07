import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class FriendsScreen extends StatelessWidget {
  final PeopleStates peopleStates;
  FriendsScreen({Key key, @required this.peopleStates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pColor2,
        appBar: AppBar(
          backgroundColor: pColor2,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: aColor2),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Friends',
              style: TextStyle(fontFamily: 'Roboto', color: aColor2)),
        ),
        body: Container(
          padding:
              EdgeInsets.only(left: getPropWidth(12), right: getPropWidth(12)),
          child: _buildPage(),
        ),
      ),
    );
  }

  _buildPage() {
    if (peopleStates.friends.length == 0) {
      return Center(
        child: Text('You don\'t have any friends yet.',
            style: TextStyle(
                color: aColor2.withOpacity(0.6),
                fontFamily: 'Roboto',
                fontSize: getPropWidth(18))),
      );
    } else {
      return ListView.builder(
        itemCount: peopleStates.friends.length,
        itemBuilder: (context, index) {
          DisplayUserModel friend = peopleStates.friends[index];
          return PeopleListWidget(
              people: friend, buttonType: ButtonType.RemoveFriend);
        },
      );
    }
  }
}
