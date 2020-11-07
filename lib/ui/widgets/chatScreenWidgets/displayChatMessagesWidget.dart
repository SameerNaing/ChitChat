import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/constants/stringConstants.dart';

class DisplayChatMessagesWidget extends StatelessWidget {
  final MessageStates messageState;

  DisplayChatMessagesWidget({
    Key key,
    @required this.messageState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        reverse: true,
        itemCount: messageState.messages.length,
        itemBuilder: (context, index) {
          MessageModel messageModel = messageState.messages[index];
          String currentUserId = messageState.currentUser.uid;
          String senderId = messageModel.senderId;
          bool isSender = currentUserId == senderId;
          return Align(
            alignment: isSender ? Alignment.bottomRight : Alignment.bottomLeft,
            child: _checkTextImgeMessage(messageModel, isSender),
          );
        },
      ),
    );
  }

  _checkTextImgeMessage(MessageModel messageModel, bool isSender) {
    if (messageModel.type == TYPE_TEXT) {
      return _senderReciverTextMessage(messageModel, isSender);
    } else if (messageModel.type == TYPE_IMAGE ||
        messageModel.type == TYPE_GIF) {
      return _senderReciverImageMessage(messageModel, isSender);
    }
  }

  _senderReciverTextMessage(MessageModel messageModel, bool isSender) {
    return isSender
        ? SenderChatMessageWidget(
            currentUser: messageState.currentUser,
            messageModel: messageModel,
          )
        : ReciverChatMessageWidget(
            reciver: messageState.reciver,
            messageModel: messageModel,
          );
  }

  _senderReciverImageMessage(MessageModel messageModel, bool isSender) {
    return isSender
        ? SenderImageMessageWidget(
            currentUser: messageState.currentUser,
            messageModel: messageModel,
          )
        : ReciverImageMessageWidget(
            reciver: messageState.reciver,
            messageModel: messageModel,
          );
  }
}
