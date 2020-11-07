import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/repository/repository.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  StreamSubscription _streamSub;
  UserModel _currentUser;
  AccountFireStore _accountFireStore = AccountFireStore();
  FireStorage _fireStorage = FireStorage();
  Uuid _uuid = Uuid();

  ProfileBloc({@required UserModel currentUser})
      : super(ProfileStates.initial()) {
    _currentUser = currentUser;
  }

  @override
  Stream<ProfileStates> mapEventToState(ProfileEvents event) async* {
    if (event is LoadCurrentUserProfile) {
      yield* _mapLoadCurrentUserProfileToState();
    } else if (event is LoadedCurrentUserProfile) {
      yield* _mapLoadedCurrentUserProfileToState(event.userProfileData);
    } else if (event is UploadImage) {
      yield* _mapUploadImageToState(event.image);
    } else if (event is DeleteImage) {
      yield* _mapDeleteImageToState(event.imgUrl, event.imgPath);
    } else if (event is LoadUserProfile) {
      yield* _mapLoadUserProfileToState(event.uid);
    }
  }

  Stream<ProfileStates> _mapLoadUserProfileToState(String uid) async* {
    state.update(profilePageState: ProfilePageState.Loading);
    try {
      UserModel user = await _accountFireStore.getUser(uid);
      yield state.update(
          userProfile: user, profilePageState: ProfilePageState.Loaded);
    } catch (e) {
      yield state.update(profilePageState: ProfilePageState.Error);
    }
  }

  Stream<ProfileStates> _mapDeleteImageToState(
      String imgUrl, String imgPath) async* {
    try {
      await _fireStorage.openExistingPath(imgPath);
      await _fireStorage.deleteImage();
      UserModel newUserModel = _deleteImageFromModel(imgUrl, imgPath);
      await _accountFireStore.addUser(newUserModel);
    } catch (e) {
      print(e);
    }
  }

  Stream<ProfileStates> _mapUploadImageToState(File image) async* {
    yield state.update(imageUploadStatus: ImageUploadStatus.Uploading);
    try {
      String storePath = _fireStorage.createImageUploadReference(
          state.currentUserProfile.uid, _uuid.v4());
      String imgUrl = await _fireStorage.uploadImage(image);
      UserModel newUserModel = _addImageToModel(imgUrl, storePath);
      await _accountFireStore.addUser(newUserModel);
      yield state.update(imageUploadStatus: ImageUploadStatus.Uploaded);
    } catch (e) {
      yield* _mapImageUploadError();
    }
  }

  Stream<ProfileStates> _mapLoadCurrentUserProfileToState() async* {
    yield state.update(currentUserProfile: _currentUser);
    _streamSub?.cancel();
    _streamSub = _accountFireStore.getUserProfile(_currentUser.uid).listen(
        (userProfileData) =>
            add(LoadedCurrentUserProfile(userProfileData: userProfileData)));
  }

  Stream<ProfileStates> _mapLoadedCurrentUserProfileToState(
      UserModel userProfileData) async* {
    yield state.update(currentUserProfile: userProfileData);
  }

  Stream<ProfileStates> _mapImageUploadError() async* {
    yield state.update(imageUploadStatus: ImageUploadStatus.Error);
    await Future.delayed(Duration(seconds: 3));
    yield state.update(imageUploadStatus: ImageUploadStatus.Uploaded);
  }

  UserModel _addImageToModel(String imgUrl, String path) {
    List<String> imagesUrl = state.currentUserProfile.uploadPhotosUrl;
    List<String> imagesPath = state.currentUserProfile.uploadPhotosPath;
    UserModel model = state.currentUserProfile;
    imagesUrl.add(imgUrl);
    imagesPath.add(path);
    model.uploadPhotosUrl = imagesUrl;
    model.uploadPhotosPath = imagesPath;
    return model;
  }

  UserModel _deleteImageFromModel(String imgUrl, String path) {
    List<String> imagesUrl = List.from(
        state.currentUserProfile.uploadPhotosUrl.where((e) => e != imgUrl));
    List<String> imagesPath = List.from(
        state.currentUserProfile.uploadPhotosPath.where((e) => e != path));
    UserModel model = state.currentUserProfile;
    model.uploadPhotosUrl = imagesUrl;
    model.uploadPhotosPath = imagesPath;
    return model;
  }

  @override
  Future<void> close() {
    _streamSub.cancel();
    return super.close();
  }
}
