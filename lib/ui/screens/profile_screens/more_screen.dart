import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class MoreScreen extends StatelessWidget {
  final ProfileStates profileStates;
  final PeopleStates peopleStates;
  MoreScreen(
      {Key key, @required this.profileStates, @required this.peopleStates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pColor2,
        body: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          padding: EdgeInsets.only(top: getPropHeight(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getProfilePic(),
              SizedBox(height: getPropHeight(12)),
              _getUserName(),
              SizedBox(height: 30),
              _card(_column(context)),
              SizedBox(height: 30),
              _card(_getText(context, 'Log Out', Colors.red, _logOut, true)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getUserName() {
    return Text(
      profileStates.currentUserProfile.name,
      style: TextStyle(
          color: aColor2, fontFamily: 'Roboto', fontSize: getPropWidth(18)),
    );
  }

  Widget _getProfilePic() {
    return SizedBox(
        height: getPropHeight(70),
        width: getPropWidth(60),
        child: CircleAvatar(
            backgroundImage:
                NetworkImage(profileStates.currentUserProfile.profileImage)));
  }

  Widget _column(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getText(context, 'Friends', aColor2, _friends, false),
        SizedBox(height: getPropHeight(5)),
        _getDivider(),
        SizedBox(height: getPropHeight(12)),
        _getText(context, 'Requested', aColor2, _requested, false),
        SizedBox(height: getPropHeight(5)),
      ],
    );
  }

  Widget _card(Widget child) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
            padding: EdgeInsets.only(
              left: getPropWidth(12),
              right: getPropWidth(12),
              top: getPropHeight(12),
              bottom: getPropHeight(12),
            ),
            child: child),
      ),
    );
  }

  Widget _getDivider() {
    return Container(
      width: SizeConfig.screenWidth - 15,
      child: Divider(),
    );
  }

  Widget _getText(BuildContext context, String text, Color color,
      Function onTap, bool center) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        width: SizeConfig.screenWidth,
        child: center ? Center(child: _text(text, color)) : _text(text, color),
      ),
    );
  }

  Widget _text(String text, Color color) {
    return Text(
      text ?? 'Null',
      style: TextStyle(
          color: color ?? Colors.red,
          fontFamily: 'Roboto',
          fontSize: getPropWidth(15)),
    );
  }

  _friends(BuildContext context) {
    ProfileNavigations.toFriendsScreen(context: context);
  }

  _requested(BuildContext context) {
    ProfileNavigations.toRequestedScreen(context: context);
  }

  _logOut(BuildContext context) {
    BlocProvider.of<AccountBloc>(context).add(SignOut());
    Navigator.of(context).pop();
  }
}
