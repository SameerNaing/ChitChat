import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

abstract class MessageEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class SendTextMessage extends MessageEvents {
  final String messageText;
  SendTextMessage({@required this.messageText});
  List<Object> get props => [messageText];
}

class MessageLoaded extends MessageEvents {
  final List<MessageModel> messages;

  MessageLoaded({@required this.messages});
  List<Object> get props => [messages];
}

class LoadMessage extends MessageEvents {
  final String reciverId;
  LoadMessage({@required this.reciverId});
  List<Object> get props => [reciverId];
}

class LoadMessageError extends MessageEvents {}

class CloseMessageStream extends MessageEvents {}

class SetIndex extends MessageEvents {
  final String reciverId;
  SetIndex({@required this.reciverId});
  List<Object> get props => [reciverId];
}

class SendImage extends MessageEvents {
  final File image;
  SendImage({@required this.image});
  List<Object> get props => [image];
}

class SendGif extends MessageEvents {
  final String url;
  SendGif({@required this.url});
  List<Object> get props => [url];
}

class MessageSeen extends MessageEvents {}
