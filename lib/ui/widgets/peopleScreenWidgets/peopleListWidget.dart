import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/ui/ui.dart';

enum ButtonType { SendRequest, GetRequest, None, Requested, RemoveFriend }

class PeopleListWidget extends StatelessWidget {
  final DisplayUserModel people;
  final ButtonType buttonType;
  PeopleListWidget({Key key, @required this.people, @required this.buttonType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        margin: EdgeInsets.only(top: getPropHeight(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getImageAndName(context, people),
            _getButton(),
          ],
        ),
      ),
    );
  }

  _getImageAndName(BuildContext context, DisplayUserModel user) {
    return Row(
      children: [
        PeopleProfileImageWidget(imgUrl: people.profilePic),
        SizedBox(width: getPropWidth(20)),
        Text(people.name,
            style: TextStyle(
                color: aColor2,
                fontFamily: 'Roboto',
                fontSize: getPropWidth(15))),
      ],
    );
  }

  _onTap(BuildContext context) {
    BlocProvider.of<PeopleBloc>(context)
        .add(CheckUserRelation(requestedUser: people));
    BlocProvider.of<ProfileBloc>(context).add(LoadUserProfile(uid: people.uid));
    return ProfileNavigations.toProfileScreen(context: context);
  }

  _getButton() {
    if (buttonType == ButtonType.SendRequest) {
      return SendRequestButtonWidget(toUser: people);
    } else if (buttonType == ButtonType.None) {
      return Container();
    } else if (buttonType == ButtonType.GetRequest) {
      return ConformCancleButton(fromUser: people);
    } else if (buttonType == ButtonType.Requested) {
      return RequestButtonWidget(toUser: people);
    } else if (buttonType == ButtonType.RemoveFriend) {
      return RemoveFriendButtonWidget(user: people);
    }
  }
}
