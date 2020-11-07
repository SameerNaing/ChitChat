import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/constants/stringConstants.dart';

class MessageFireStore {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _message;
  DocumentReference _displayMessage;

  MessageFireStore() {
    _message = _firestore
        .collection('chitChat')
        .doc('chitChatUserMessages')
        .collection('Messages');

    _displayMessage = _firestore
        .collection('chitChat')
        .doc('chitChatUserMessages')
        .collection('DisplayMessages')
        .doc('displayMessageDoc');
  }

  Future<void> sendTextMessage(MessageModel message) async {
    await _message
        .doc(message.senderId)
        .collection(message.reciverId)
        .add(message.textMessageToMap());

    await _message
        .doc(message.reciverId)
        .collection(message.senderId)
        .add(message.textMessageToMap());
  }

  Future<void> sendImage(MessageModel message) async {
    await _message
        .doc(message.senderId)
        .collection(message.reciverId)
        .add(message.imageMessageToMap());

    await _message
        .doc(message.reciverId)
        .collection(message.senderId)
        .add(message.imageMessageToMap());
  }

  Future<void> sendGif(MessageModel message) async {
    await _message
        .doc(message.senderId)
        .collection(message.reciverId)
        .add(message.gifMessageToMap());

    await _message
        .doc(message.reciverId)
        .collection(message.senderId)
        .add(message.gifMessageToMap());
  }

  Future<void> setMessageIndexInfoValue(
      {int value, String currentUserId, String reciverId}) async {
    await _message
        .doc(currentUserId)
        .collection(reciverId)
        .doc('messageIndexInfo')
        .set({'index': value});

    await _message
        .doc(reciverId)
        .collection(currentUserId)
        .doc('messageIndexInfo')
        .set({'index': value});
  }

  Future<void> checkMessageIndexInfoExists(
      {String currentUserId, String reciverId}) async {
    DocumentSnapshot senderDoc = await _message
        .doc(currentUserId)
        .collection(reciverId)
        .doc('messageIndexInfo')
        .get();
    bool senderDocExist = senderDoc.exists;

    if (!senderDocExist) {
      setMessageIndexInfoValue(
          value: 0, currentUserId: currentUserId, reciverId: reciverId);
    }
  }

  Future<int> getMessageIndex({String currentUserId, String reciverId}) async {
    DocumentSnapshot data = await _message
        .doc(currentUserId)
        .collection(reciverId)
        .doc('messageIndexInfo')
        .get();

    return data.data()['index'];
  }

  _checkType(MessageModel message) {
    if (message.type == null) {
      return message.message;
    } else if (message.type == TYPE_GIF) {
      return 'Gif';
    } else if (message.type == TYPE_IMAGE) {
      return 'Image';
    }
  }

  Future<void> displayMessage(
      {MessageModel message,
      UserModel currentUserModel,
      UserModel reciverUserModel}) async {
    DisplayMessageModel senderDisplayModel = DisplayMessageModel(
      uid: reciverUserModel.uid,
      name: reciverUserModel.name,
      profilPicUrl: reciverUserModel.profileImage,
      lastMessage: _checkType(message),
      isNew: false,
    );
    DisplayMessageModel reciverDisplayModel = DisplayMessageModel(
      uid: currentUserModel.uid,
      name: currentUserModel.name,
      profilPicUrl: currentUserModel.profileImage,
      lastMessage: _checkType(message),
      isNew: true,
    );

    await _displayMessage
        .collection(currentUserModel.uid)
        .doc(reciverUserModel.uid)
        .set(senderDisplayModel.toMap());
    await _displayMessage
        .collection(reciverUserModel.uid)
        .doc(currentUserModel.uid)
        .set(reciverDisplayModel.toMap());
  }

  Future<DisplayMessageModel> _getDisplayMessageModel(
      String currentUserId, String reciverUserId) async {
    DocumentSnapshot document = await _displayMessage
        .collection(currentUserId)
        .doc(reciverUserId)
        .get();
    if (document.data() != null) {
      return DisplayMessageModel.fromMap(document.data());
    }
  }

  Future<void> setNewToFalse(String currentUserId, String reciverUserId) async {
    DisplayMessageModel displayMessage =
        await _getDisplayMessageModel(currentUserId, reciverUserId);
    if (displayMessage != null) {
      displayMessage.isNew = false;
      await _displayMessage
          .collection(currentUserId)
          .doc(reciverUserId)
          .set(displayMessage.toMap());
    }
  }

  Future<void> removeMessages(
      String currentUserId, String reciverUserId) async {
    await _displayMessage.collection(currentUserId).doc(reciverUserId).delete();
    await _displayMessage.collection(reciverUserId).doc(currentUserId).delete();
    _message
        .doc(currentUserId)
        .collection(reciverUserId)
        .snapshots()
        .forEach((element) {
      for (QueryDocumentSnapshot snapshot in element.docs) {
        snapshot.reference.delete();
      }
    });
    _message
        .doc(reciverUserId)
        .collection(currentUserId)
        .snapshots()
        .forEach((element) {
      for (QueryDocumentSnapshot snapshot in element.docs) {
        snapshot.reference.delete();
      }
    });
  }

  Stream<List<MessageModel>> loadMessages(
      String currentUserId, String reciverId) {
    return _message
        .doc(currentUserId)
        .collection(reciverId)
        .orderBy('index', descending: true)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((docs) => MessageModel.fromMap(docs.data()))
            .toList());
  }

  Stream<List<DisplayMessageModel>> loadDisplayMessages(String currentUserId) {
    return _displayMessage.collection(currentUserId).snapshots().map(
        (snapShot) => snapShot.docs
            .map((docs) => DisplayMessageModel.fromMap(docs.data()))
            .toList());
  }
}
