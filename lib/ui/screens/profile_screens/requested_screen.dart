import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class RequestedScreen extends StatelessWidget {
  final PeopleStates peopleStates;
  RequestedScreen({Key key, @required this.peopleStates}) : super(key: key);

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
          title: Text('Requested',
              style: TextStyle(fontFamily: 'Roboto', color: aColor2)),
        ),
        body: Container(
          padding:
              EdgeInsets.only(left: getPropWidth(15), right: getPropWidth(15)),
          child: _buildPage(),
        ),
      ),
    );
  }

  _buildPage() {
    if (peopleStates.sendRequests.length == 0) {
      return Center(
        child: Text('No ongoing Requests.',
            style: TextStyle(
                color: aColor2.withOpacity(0.6),
                fontFamily: 'Roboto',
                fontSize: getPropWidth(18))),
      );
    } else {
      return ListView.builder(
        itemCount: peopleStates.sendRequests.length,
        itemBuilder: (context, index) {
          DisplayUserModel requested = peopleStates.sendRequests[index];
          return PeopleListWidget(
              people: requested, buttonType: ButtonType.Requested);
        },
      );
    }
  }
}
