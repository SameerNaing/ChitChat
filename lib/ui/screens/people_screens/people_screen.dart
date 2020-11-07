import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';

class PeoplesScreen extends StatelessWidget {
  PeopleStates peopleStates;
  PeoplesScreen({Key key, @required this.peopleStates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: _buildScreen(context, peopleStates),
      ),
    );
  }

  _buildScreen(BuildContext context, PeopleStates peopleStates) {
    if (peopleStates.peoplePageStatus == PeoplePageStatus.Loading) {
      return Container(child: Center(child: CircularProgressIndicator()));
    } else if (peopleStates.peoplePageStatus == PeoplePageStatus.Error) {
      return Container(child: Center(child: Text(peopleStates.errorMessage)));
    } else if (peopleStates.peoplePageStatus == PeoplePageStatus.Loaded) {
      return _getPeopleScreen(context, peopleStates);
    }
  }

  _getPeopleScreen(BuildContext context, PeopleStates peopleStates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        peopleStates.getRequests.length == 0
            ? Container()
            : PeopleHeaderWidget(header: 'Friend Requests'),
        Container(
          margin:
              EdgeInsets.only(left: getPropWidth(30), right: getPropWidth(20)),
          height: peopleStates.getRequests.length * 80.0,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: peopleStates.getRequests.length,
            itemBuilder: (context, index) {
              return PeopleListWidget(
                  people: peopleStates.getRequests[index],
                  buttonType: ButtonType.GetRequest);
            },
          ),
        ),
        PeopleHeaderWidget(header: 'Others'),
        Container(
          margin:
              EdgeInsets.only(left: getPropWidth(30), right: getPropWidth(30)),
          height: peopleStates.userToShow.length * 80.0,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: peopleStates.userToShow.length,
            itemBuilder: (context, index) {
              return PeopleListWidget(
                  people: peopleStates.userToShow[index],
                  buttonType: ButtonType.SendRequest);
            },
          ),
        ),
      ],
    );
  }
}
