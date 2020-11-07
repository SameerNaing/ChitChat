import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class UploadProfilePicScreen extends StatefulWidget {
  AccountState accountState;
  UploadProfilePicScreen({
    Key key,
    @required this.accountState,
  }) : super(key: key);

  @override
  _UploadProfilePicScreenState createState() => _UploadProfilePicScreenState();
}

class _UploadProfilePicScreenState extends State<UploadProfilePicScreen> {
  ImagePicker _picker = ImagePicker();

  bool _isImageUploaded = false;
  bool _showErrorText = false;

  void _setImageUploaded(bool val) => setState(() => _isImageUploaded = val);
  void _setShowErrroText(bool val) => setState(() => _showErrorText = val);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ClipperBackground(
      accountState: widget.accountState,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getPropHeight(20),
                horizontal: getPropWidth(30),
              ),
              child: FadeTtoB(
                  child: HeaderText(text: 'Profile Picture'), delay: 1.2),
            ),
          ),
          SizedBox(height: getPropHeight(30)),
          _buildProfilePicContainer(context, widget.accountState.accountStatus,
              widget.accountState.profilePicUrl),
          _reuploadbuttonState(widget.accountState.accountStatus),
          _notSelectedImageError(),
          SizedBox(height: getPropHeight(20)),
          FadeTtoB(
            delay: 1.4,
            child: AccountButtonWidget(
                text: 'Next', onPressed: () => _onDone(widget.accountState)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicContainer(
      BuildContext context, AccountStatus status, String photoUrl) {
    return AnimatedContainer(
      duration: Duration(microseconds: 200),
      child: _profilePicState(context, status, photoUrl),
    );
  }

  _profilePicState(
      BuildContext context, AccountStatus status, String photoUrl) {
    if (status == AccountStatus.Loading) {
      _setImageUploaded(false);
      _setShowErrroText(false);
      return ProfilePicLoadingContainer();
    } else if (status == AccountStatus.Error) {
      _setImageUploaded(false);
      _setShowErrroText(false);
      return _imageuploadContainer(context, ProfilePicUploadContainer());
    } else if (status == AccountStatus.ProfilePhotoUploaded) {
      _setImageUploaded(true);
      _setShowErrroText(false);
      return ProfilePicContainer(photoUrl: photoUrl);
    } else {
      return _imageuploadContainer(context, ProfilePicUploadContainer());
    }
  }

  Widget _reuploadbuttonState(AccountStatus status) {
    return status == AccountStatus.ProfilePhotoUploaded
        ? _imageuploadContainer(context, ProfilePicReuploadButton())
        : Container();
  }

  Widget _notSelectedImageError() {
    return _showErrorText ? ProfilePicNotSelectedErrorText() : Container();
  }

  _dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Choose'),
            content: Row(
              children: [
                Spacer(flex: 1),
                Container(
                  height: getPropHeight(100),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          _pickImage(ImageSource.camera);
                        },
                        child: Icon(Icons.camera, size: getPropWidth(50)),
                      ),
                      SizedBox(height: getPropHeight(12)),
                      Text('Camera')
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Container(
                  height: getPropHeight(100),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          _pickImage(ImageSource.gallery);
                        },
                        child: Icon(Icons.photo_album, size: getPropWidth(50)),
                      ),
                      SizedBox(height: getPropHeight(12)),
                      Text('Photo Library')
                    ],
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
            actions: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  _onDone(AccountState accountState) {
    if (_isImageUploaded) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: BlocProvider.of<AccountBloc>(context),
                child: UserInfoScreen(),
              )));
    } else {
      _setShowErrroText(true);
    }
  }

  _imageuploadContainer(BuildContext context, Widget child) {
    return FadeTtoB(
      delay: 1.3,
      child: GestureDetector(
        onTap: () {
          _dialog(context);
        },
        child: child,
      ),
    );
  }

  _pickImage(ImageSource source) async {
    PickedFile pickedImage = await _picker.getImage(source: source);
    if (pickedImage != null) {
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 5),
        compressQuality: 100,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.deepOrange,
          toolbarTitle: 'Image Cropper',
          statusBarColor: Colors.deepOrange.shade900,
          backgroundColor: Colors.white,
        ),
      );
      if (croppedImage != null) {
        BlocProvider.of<AccountBloc>(context)
            .add(UploadProfileImage(imageFile: croppedImage));
      }
    }
  }
}
