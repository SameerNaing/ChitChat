import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

enum ImageUploadStatus { Uploading, Uploaded, Error }
enum ProfilePageState { Loading, Loaded, Error }

class ProfileStates extends Equatable {
  final UserModel currentUserProfile;
  final UserModel userProfile;
  final ImageUploadStatus imageUploadStatus;
  final ProfilePageState profilePageState;

  ProfileStates({
    @required this.currentUserProfile,
    @required this.imageUploadStatus,
    @required this.profilePageState,
    @required this.userProfile,
  });

  static ProfileStates initial() {
    return ProfileStates(
      currentUserProfile: null,
      imageUploadStatus: ImageUploadStatus.Uploaded,
      profilePageState: null,
      userProfile: null,
    );
  }

  ProfileStates update({
    UserModel currentUserProfile,
    ImageUploadStatus imageUploadStatus,
    ProfilePageState profilePageState,
    UserModel userProfile,
  }) {
    return ProfileStates(
      currentUserProfile: currentUserProfile ?? this.currentUserProfile,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      profilePageState: profilePageState ?? this.profilePageState,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object> get props => [
        currentUserProfile,
        userProfile,
        imageUploadStatus,
        profilePageState,
      ];
}
