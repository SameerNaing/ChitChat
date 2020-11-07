import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

abstract class ProfileEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCurrentUserProfile extends ProfileEvents {}

class LoadUserProfile extends ProfileEvents {
  final String uid;
  LoadUserProfile({@required this.uid});
  @override
  List<Object> get props => [uid];
}

class LoadedCurrentUserProfile extends ProfileEvents {
  final UserModel userProfileData;
  LoadedCurrentUserProfile({@required this.userProfileData});
  @override
  List<Object> get props => [userProfileData];
}

class UploadImage extends ProfileEvents {
  final File image;
  UploadImage({@required this.image});
  @override
  List<Object> get props => [image];
}

class DeleteImage extends ProfileEvents {
  final String imgUrl;
  final String imgPath;
  DeleteImage({@required this.imgUrl, @required this.imgPath});
  @override
  List<Object> get props => [imgUrl, imgPath];
}
