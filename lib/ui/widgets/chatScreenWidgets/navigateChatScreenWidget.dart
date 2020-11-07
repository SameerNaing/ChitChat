import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';

class NavigateToChatScreenWidget {
  static navigate(BuildContext context,
      {@required String reciverId, @required String reciverUserName}) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider<MessageBloc>(
        create: (_) => MessageBloc()..add(LoadMessage(reciverId: reciverId)),
        child: BlocBuilder<MessageBloc, MessageStates>(
          builder: (context, messageState) {
            return ChatScreen(
              reciverUserName: reciverUserName,
              messageState: messageState,
            );
          },
        ),
      ),
    ));
  }
}
