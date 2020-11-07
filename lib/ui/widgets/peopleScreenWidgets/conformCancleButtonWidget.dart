import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';

class ConformCancleButton extends StatelessWidget {
  final DisplayUserModel fromUser;
  ConformCancleButton({Key key, @required this.fromUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getContainer(context, 'conform', true),
        SizedBox(width: getPropWidth(11)),
        _getContainer(context, 'cancle', false),
      ],
    );
  }

  Widget _getContainer(
      BuildContext context, String text, bool isConformButton) {
    return GestureDetector(
      onTap: () {
        if (isConformButton) {
          BlocProvider.of<PeopleBloc>(context)
              .add(AcceptGetRequest(fromUser: fromUser));
        } else {
          BlocProvider.of<PeopleBloc>(context)
              .add(CancleGetRequest(fromUser: fromUser));
        }
      },
      child: Container(
        height: getPropHeight(40),
        width: getPropWidth(63),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isConformButton ? aColor1 : darkWhite,
        ),
        child: Center(
          child: Text(
            text ?? 'Null',
            style: TextStyle(
              color: isConformButton ? pColor2 : aColor2,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
