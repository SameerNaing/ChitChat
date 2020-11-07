import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/models/models.dart';

class SearchScreen extends StatelessWidget {
  final SearchStates searchStates;
  SearchScreen({Key key, @required this.searchStates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: SearchAppBar(),
          body: ListView.builder(
            itemCount: searchStates.searchedUsers.length,
            itemBuilder: (context, index) {
              DisplayUserModel people = searchStates.searchedUsers[index];
              return Container(
                padding: EdgeInsets.only(
                    left: getPropWidth(12), right: getPropWidth(12)),
                child: PeopleListWidget(
                    people: people, buttonType: ButtonType.None),
              );
            },
          )),
    );
  }
}
