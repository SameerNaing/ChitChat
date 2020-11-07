import 'package:chit_chat/models/models.dart';

enum MessageStateStatus {
  Loading,
  Error,
  Loaded,
}

enum MessageStatus { Sending, Sent }
enum ImageSendingStatus { Sending, Sent }

class MessageStates {
  final MessageStateStatus status;
  final List<MessageModel> messages;

  final String errorMessage;
  final UserModel currentUser;
  final UserModel reciver;
  final MessageStatus messageStatus;
  final ImageSendingStatus imageSendingStatus;

  MessageStates({
    this.status,
    this.messages,
    this.errorMessage,
    this.currentUser,
    this.reciver,
    this.messageStatus,
    this.imageSendingStatus,
  });

  MessageStates update({
    MessageStateStatus status,
    List<MessageModel> messages,
    String errorMessage,
    UserModel currentUser,
    UserModel reciver,
    MessageStatus messageStatus,
    ImageSendingStatus imageSendingStatus,
  }) {
    return MessageStates(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUser: currentUser ?? this.currentUser,
      reciver: reciver ?? this.reciver,
      messageStatus: messageStatus ?? this.messageStatus,
      imageSendingStatus: imageSendingStatus ?? this.imageSendingStatus,
    );
  }

  static MessageStates initial() {
    return MessageStates(
      status: MessageStateStatus.Loading,
      messages: null,
      errorMessage: null,
      currentUser: null,
      reciver: null,
      messageStatus: MessageStatus.Sent,
      imageSendingStatus: ImageSendingStatus.Sent,
    );
  }
}
