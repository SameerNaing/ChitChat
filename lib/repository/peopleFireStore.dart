import 'dart:async';

import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chit_chat/repository/repository.dart';

class PeopleFireStore {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  DisplayUserModel _currentUser;
  AccountFireStore _accountFireStore = AccountFireStore();
  CollectionReference _friends;
  CollectionReference _requestSend;
  CollectionReference _requestGet;
  CollectionReference _allChitchatUsers;

  PeopleFireStore({@required UserModel currentUser}) {
    _currentUser = DisplayUserModel.toModel(currentUser);
    _friends = _firebaseFirestore
        .collection('chitChat')
        .doc('peopleDoc')
        .collection('People')
        .doc(_currentUser.uid)
        .collection('Friends');

    _requestSend = _firebaseFirestore
        .collection('chitChat')
        .doc('peopleDoc')
        .collection('People')
        .doc(_currentUser.uid)
        .collection('RequestSend');

    _requestGet = _firebaseFirestore
        .collection('chitChat')
        .doc('peopleDoc')
        .collection('People')
        .doc(_currentUser.uid)
        .collection('RequestGet');

    _allChitchatUsers = _firebaseFirestore
        .collection('chitChat')
        .doc('chitChatUsersDoc')
        .collection('users');
  }

  Stream<List<DisplayUserModel>> friendsStream() {
    return _friends.snapshots().map((snapShot) => snapShot.docs
        .map((doc) => DisplayUserModel.fromMap(doc.data()))
        .toList());
  }

  Stream<List<DisplayUserModel>> requestSendStream() {
    return _requestSend.snapshots().map((snapShot) => snapShot.docs
        .map((doc) => DisplayUserModel.fromMap(doc.data()))
        .toList());
  }

  Stream<List<DisplayUserModel>> requestGetStream() {
    return _requestGet.snapshots().map((snapShot) => snapShot.docs
        .map((doc) => DisplayUserModel.fromMap(doc.data()))
        .toList());
  }

  Stream<List<DisplayUserModel>> allUsersStream() {
    return _allChitchatUsers.snapshots().map((snapShot) => snapShot.docs
        .map((doc) => DisplayUserModel.fromMap(doc.data()))
        .toList());
  }

  DocumentReference _getDocReference(
      String userId, String collectionName, String docId) {
    return _firebaseFirestore
        .collection('chitChat')
        .doc('peopleDoc')
        .collection('People')
        .doc(userId)
        .collection(collectionName)
        .doc(docId);
  }

  Future<void> sendRequest(DisplayUserModel toUser) async {
    await _getDocReference(_currentUser.uid, 'RequestSend', toUser.uid)
        .set(toUser.toMap());
    await _getDocReference(toUser.uid, 'RequestGet', _currentUser.uid)
        .set(_currentUser.toMap());
  }

  Future<void> cancleSendRequest(DisplayUserModel toUser) async {
    await _getDocReference(_currentUser.uid, 'RequestSend', toUser.uid)
        .delete();
    await _getDocReference(toUser.uid, 'RequestGet', _currentUser.uid).delete();
  }

  Future<void> cancleGetRequest(DisplayUserModel fromUser) async {
    await _getDocReference(_currentUser.uid, 'RequestGet', fromUser.uid)
        .delete();
    await _getDocReference(fromUser.uid, 'RequestSend', _currentUser.uid)
        .delete();
  }

  Future<void> _addFriend(
      DisplayUserModel user, String toUserId, String addUserId) async {
    await _getDocReference(toUserId, 'Friends', addUserId).set(user.toMap());
  }

  Future<void> _deleteFriend(String userId, String removeUserId) async {
    await _getDocReference(userId, 'Friends', removeUserId).delete();
  }

  Future<int> _getFriendListLength(String uid) async {
    QuerySnapshot friends = await _firebaseFirestore
        .collection('chitChat')
        .doc('peopleDoc')
        .collection('People')
        .doc(uid)
        .collection('Friends')
        .get();
    return friends.docs.length;
  }

  Future<void> acceptGetRequest(DisplayUserModel fromUser) async {
    await cancleGetRequest(fromUser);
    await _addFriend(fromUser, _currentUser.uid, fromUser.uid);
    await _addFriend(_currentUser, fromUser.uid, _currentUser.uid);
    int fromUserFriends = await _getFriendListLength(fromUser.uid);
    int currentUserFriends = await _getFriendListLength(_currentUser.uid);
    await _accountFireStore.updateFriendNum(fromUser.uid, fromUserFriends);
    await _accountFireStore.updateFriendNum(
        _currentUser.uid, currentUserFriends);
  }

  Future<void> removeFromFriends(DisplayUserModel removeUser) async {
    await _deleteFriend(_currentUser.uid, removeUser.uid);
    await _deleteFriend(removeUser.uid, _currentUser.uid);
    int removeUserFriends = await _getFriendListLength(removeUser.uid);
    int currentUserFriends = await _getFriendListLength(_currentUser.uid);
    await _accountFireStore.updateFriendNum(removeUser.uid, removeUserFriends);
    await _accountFireStore.updateFriendNum(
        _currentUser.uid, currentUserFriends);
  }
}
