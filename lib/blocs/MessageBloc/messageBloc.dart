import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/repository/repository.dart';
import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/utils/utilities.dart';
import 'package:chit_chat/constants/stringConstants.dart';

class MessageBloc extends Bloc<MessageEvents, MessageStates> {
  StreamSubscription _messagesStreamSub;
  MessageFireStore _messageFireStore = MessageFireStore();
  FirebaseAuthService _fireAuth = FirebaseAuthService();
  AccountFireStore _userAccount = AccountFireStore();
  FireStorage _fireStorage = FireStorage();
  Uuid _uuid = Uuid();

  MessageBloc() : super(MessageStates.initial());

  @override
  Stream<MessageStates> mapEventToState(MessageEvents event) async* {
    if (event is LoadMessage) {
      yield* _mapLoadMessageToState(event);
    } else if (event is MessageLoaded) {
      yield* _mapMessageLoadedToState(event);
    } else if (event is SendTextMessage) {
      yield* _mapSendMessageToState(event);
    } else if (event is CloseMessageStream) {
      yield* _mapCloseMessageStreamToState();
    } else if (event is SetIndex) {
      yield* _mapSetIndexToState(event);
    } else if (event is SendImage) {
      yield* _mapSendImageToState(event.image);
    } else if (event is ImageMessageUploaded) {
      yield* _mapImageMessageUploadedToState(event.path);
    } else if (event is SendGif) {
      yield* _mapSendGifToState(event.url);
    } else if (event is MessageSeen) {
      yield* _mapMessageSeenToState();
    }
  }

  Stream<MessageStates> _mapLoadMessageToState(LoadMessage event) async* {
    yield state.update(status: MessageStateStatus.Loading);

    UserModel currentUser = await _userAccount.getUser(_fireAuth.userId);
    UserModel reciver = await _userAccount.getUser(event.reciverId);

    await _messageFireStore.checkMessageIndexInfoExists(
        currentUserId: currentUser.uid, reciverId: reciver.uid);

    yield state.update(reciver: reciver, currentUser: currentUser);

    _messagesStreamSub?.cancel();

    _messagesStreamSub = _messageFireStore
        .loadMessages(currentUser.uid, reciver.uid)
        .listen((messages) => add(MessageLoaded(messages: messages)));
  }

  Stream<MessageStates> _mapMessageLoadedToState(MessageLoaded event) async* {
    if (event.messages.length == 1) {
      yield state.update(messages: [], status: MessageStateStatus.Loaded);
    } else {
      yield state.update(
        messageStatus: MessageStatus.Sent,
        messages: event.messages.sublist(1),
        status: MessageStateStatus.Loaded,
        imageSendingStatus: ImageSendingStatus.Sent,
      );
    }
  }

  Stream<MessageStates> _mapSendMessageToState(SendTextMessage event) async* {
    yield state.update(messageStatus: MessageStatus.Sending);
    int index = await _messageFireStore.getMessageIndex(
        currentUserId: state.currentUser.uid, reciverId: state.reciver.uid);

    MessageModel message = MessageModel(
      senderId: state.currentUser.uid,
      reciverId: state.reciver.uid,
      message: event.messageText,
      index: index,
    );
    await _messageFireStore.displayMessage(
        message: message,
        currentUserModel: state.currentUser,
        reciverUserModel: state.reciver);
    await _messageFireStore.sendTextMessage(message);
    await _messageFireStore.setMessageIndexInfoValue(
        value: index + 1,
        currentUserId: state.currentUser.uid,
        reciverId: state.reciver.uid);
  }

  Stream<MessageStates> _mapCloseMessageStreamToState() async* {
    _messagesStreamSub?.cancel();
  }

  Stream<MessageStates> _mapSetIndexToState(SetIndex event) async* {
    String userId = _fireAuth.userId;
    await _messageFireStore.checkMessageIndexInfoExists(
        currentUserId: userId, reciverId: event.reciverId);
  }

  Stream<MessageStates> _mapSendImageToState(File image) async* {
    yield state.update(imageSendingStatus: ImageSendingStatus.Sending);
    try {
      File compressedImage = await Utilities.compressImage(image);
      String uniqueId = _uuid.v4();
      String imagePath = _fireStorage.createImageMessageReference(uniqueId);
      UploadTask task = _fireStorage.uploadImage(compressedImage);
      task.whenComplete(() => add(ImageMessageUploaded(path: imagePath)));
    } catch (e) {
      yield state.update(imageSendingStatus: ImageSendingStatus.Sent);
      print(e);
    }
  }

  Stream<MessageStates> _mapImageMessageUploadedToState(String path) async* {
    await _fireStorage.openExistingPath(path);
    int index = await _messageFireStore.getMessageIndex(
        currentUserId: state.currentUser.uid, reciverId: state.reciver.uid);
    String imgUrl = await _fireStorage.downloadUrl();
    MessageModel imageMessage = MessageModel.imageMessage(
      index: index,
      senderId: state.currentUser.uid,
      reciverId: state.reciver.uid,
      url: imgUrl,
      type: TYPE_IMAGE,
      storedImagePath: path,
    );
    await _messageFireStore.displayMessage(
        message: imageMessage,
        currentUserModel: state.currentUser,
        reciverUserModel: state.reciver);
    await _messageFireStore.sendImage(imageMessage);
    await _messageFireStore.setMessageIndexInfoValue(
        value: index + 1,
        currentUserId: state.currentUser.uid,
        reciverId: state.reciver.uid);
  }

  Stream<MessageStates> _mapSendGifToState(String url) async* {
    yield state.update(imageSendingStatus: ImageSendingStatus.Sending);
    int index = await _messageFireStore.getMessageIndex(
        currentUserId: state.currentUser.uid, reciverId: state.reciver.uid);
    MessageModel message = MessageModel.gifMessage(
      index: index,
      senderId: state.currentUser.uid,
      reciverId: state.reciver.uid,
      url: url,
      type: TYPE_GIF,
    );
    await _messageFireStore.displayMessage(
        message: message,
        currentUserModel: state.currentUser,
        reciverUserModel: state.reciver);
    await _messageFireStore.sendGif(message);
    await _messageFireStore.setMessageIndexInfoValue(
        value: index + 1,
        currentUserId: state.currentUser.uid,
        reciverId: state.reciver.uid);
  }

  Stream<MessageStates> _mapMessageSeenToState() async* {
    if (state.currentUser != null) {
      await _messageFireStore.setNewToFalse(
          state.currentUser.uid, state.reciver.uid);
    }
  }

  @override
  Future<void> close() {
    _messagesStreamSub.cancel();
    return super.close();
  }
}
