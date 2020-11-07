import 'package:chit_chat/constants/stringConstants.dart';

class MessageModel {
  String message;
  String senderId;
  String reciverId;
  String url;
  String type;
  String storedImagePath;
  int index;

  MessageModel({
    this.message,
    this.senderId,
    this.reciverId,
    this.index,
    this.type,
  });
  MessageModel.imageMessage({
    this.index,
    this.senderId,
    this.reciverId,
    this.url,
    this.type,
    this.storedImagePath,
  });

  MessageModel.gifMessage({
    this.index,
    this.senderId,
    this.reciverId,
    this.url,
    this.type,
  });

  Map<String, dynamic> textMessageToMap() {
    return {
      'message': this.message,
      'senderId': this.senderId,
      'reciverId': this.reciverId,
      'index': this.index,
      'type': TYPE_TEXT,
    };
  }

  Map<String, dynamic> imageMessageToMap() {
    return {
      'senderId': this.senderId,
      'reciverId': this.reciverId,
      'index': this.index,
      'type': TYPE_IMAGE,
      'url': this.url,
      'storedImagePath': this.storedImagePath,
    };
  }

  Map<String, dynamic> gifMessageToMap() {
    return {
      'senderId': this.senderId,
      'reciverId': this.reciverId,
      'index': this.index,
      'url': this.url,
      'type': this.type,
    };
  }

  MessageModel.fromMap(Map<String, dynamic> map) {
    this.message = map['message'];
    this.reciverId = map['reciverId'];
    this.senderId = map['senderId'];
    this.index = map['index'];
    this.type = map['type'];
    this.url = map['url'];
    this.storedImagePath = map['storedImagePath'];
  }
}
