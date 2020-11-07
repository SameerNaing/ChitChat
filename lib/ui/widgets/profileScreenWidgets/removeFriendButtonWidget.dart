import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class RemoveFriendButtonWidget extends StatelessWidget {
  final DisplayUserModel user;
  RemoveFriendButtonWidget({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.clear, color: Colors.redAccent),
      onPressed: () {
        BlocProvider.of<PeopleBloc>(context).add(RemoveFromFriends(user: user));
      },
    );
  }
}
