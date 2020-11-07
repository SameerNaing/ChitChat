import 'dart:convert';

import 'package:chit_chat/models/displayUserModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserModel extends Equatable {
  String profileImage;
  String name;
  String profileImagePath;
  String bio;
  String relationStatus;
  String loacation;
  String uid;
  int numFriends;

  List<String> uploadPhotosUrl;
  List<String> uploadPhotosPath;

  UserModel({
    @required this.name,
    @required this.profileImage,
    @required this.profileImagePath,
    @required this.bio,
    @required this.relationStatus,
    @required this.loacation,
    @required this.uid,
    @required this.numFriends,
    @required this.uploadPhotosUrl,
    @required this.uploadPhotosPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'profileImage': this.profileImage,
      'profileImagePath': this.profileImagePath,
      'bio': this.bio,
      'relationStatus': this.relationStatus,
      'location': this.loacation,
      'uid': this.uid,
      'numFriends': this.numFriends,
      'uploadPhotosUrl': this.uploadPhotosUrl,
      'uploadPhotosPath': this.uploadPhotosPath,
    };
  }

  static UserModel fromMap(Map<String, dynamic> doc) {
    return UserModel(
      name: doc['name'],
      profileImage: doc['profileImage'],
      profileImagePath: doc['profileImagePath'],
      bio: doc['bio'],
      relationStatus: doc['relationStatus'],
      loacation: doc['location'],
      uid: doc['uid'],
      numFriends: doc['numFriends'],
      uploadPhotosUrl: List<String>.from(doc['uploadPhotosUrl']),
      uploadPhotosPath: List<String>.from(doc['uploadPhotosPath']),
    );
  }

  @override
  List<Object> get props => [
        name,
        profileImage,
        profileImagePath,
        bio,
        relationStatus,
        loacation,
        uid,
        numFriends,
        uploadPhotosPath,
        uploadPhotosUrl,
      ];
}
