import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/models/models.dart';

class SendRequestButtonWidget extends StatelessWidget {
  final DisplayUserModel toUser;
  SendRequestButtonWidget({Key key, @required this.toUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PeopleBloc>(context).add(SendRequest(toUser: toUser));
      },
      child: Container(
        height: getPropHeight(30),
        width: getPropWidth(35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: aColor1, width: 1),
        ),
        child: Center(
          child: Icon(Icons.person_add, color: aColor1),
        ),
      ),
    );
  }
}
