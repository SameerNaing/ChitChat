import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chit_chat/models/models.dart';

class AccountFireStore {
  FirebaseFirestore _account = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) {
    return _account
        .collection('chitChat')
        .doc('chitChatUsersDoc')
        .collection('users')
        .doc(user.uid)
        .set(user.toMap());
  }

  Future<void> deleteUser(String uid) {
    return _account
        .collection('chitChat')
        .doc('chitChatUsersDoc')
        .collection('users')
        .doc(uid)
        .delete();
  }

  Future<UserModel> getUser(String uid) async {
    final data = await _account
        .collection('chitChat')
        .doc('chitChatUsersDoc')
        .collection('users')
        .doc(uid)
        .get();
    return UserModel.fromMap(data.data());
  }

  Future<void> updateFriendNum(String uid, int numFriends) async {
    UserModel user = await getUser(uid);

    user.numFriends = numFriends;
    await _account
        .collection('chitChat')
        .doc('chitChatUsersDoc')
        .collection('users')
        .doc(user.uid)
        .set(user.toMap());
  }

  Stream<UserModel> getUserProfile(String currentUserId) {
    return _account
        .collection('chitChat')
        .doc('chitChatUsersDoc')
        .collection('users')
        .doc(currentUserId)
        .snapshots()
        .map((userData) => UserModel.fromMap(userData.data()));
  }
}
