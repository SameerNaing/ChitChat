import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

class DisplayUserModel extends Equatable {
  final String name;
  final String profilePic;
  final String uid;

  DisplayUserModel(
      {@required this.name, @required this.profilePic, @required this.uid});

  static DisplayUserModel fromMap(Map<String, dynamic> doc) {
    return DisplayUserModel(
        name: doc['name'], profilePic: doc['profileImage'], uid: doc['uid']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'profileImage': this.profilePic,
      'uid': this.uid,
    };
  }

  static DisplayUserModel toModel(UserModel userModel) {
    return DisplayUserModel(
      name: userModel.name,
      profilePic: userModel.profileImage,
      uid: userModel.uid,
    );
  }

  @override
  List<Object> get props => [name, profilePic, uid];
}
