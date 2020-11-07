import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:meta/meta.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class ImagesScreen extends StatelessWidget {
  final bool currentUser;
  final UserModel user;
  final ImagePicker _picker = ImagePicker();

  ImagesScreen({Key key, @required this.user, @required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileStates>(
      builder: (context, profileState) {
        UserModel fromState = profileState.currentUserProfile;
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: pColor2,
                  leading: IconButton(
                    splashRadius: getPropWidth(15),
                    icon: Icon(Icons.arrow_back, color: aColor2),
                    onPressed: () => _backButton(context),
                  ),
                  title: Text(
                    'Photos',
                    style: TextStyle(color: aColor2),
                  ),
                  actions: [
                    currentUser ? _uploadImageButton(context) : Container(),
                  ]),
              body: UploadImageStatusStackWidget(
                profileStates: profileState,
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: currentUser
                      ? fromState.uploadPhotosUrl.length
                      : user.uploadPhotosUrl.length,
                  itemBuilder: (BuildContext context, int index) {
                    String imgUrl = currentUser
                        ? fromState.uploadPhotosUrl[index]
                        : user.uploadPhotosUrl[index];
                    String imgPath =
                        currentUser ? fromState.uploadPhotosPath[index] : null;
                    return currentUser
                        ? _onFocus(
                            context,
                            _imageContainer(context, imgUrl),
                            imgUrl,
                            imgPath,
                          )
                        : _imageContainer(context, imgUrl);
                  },
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(2, index.isEven ? 2 : 3),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              )),
        );
      },
    );
  }

  _backButton(BuildContext context) {
    return Navigator.of(context).pop();
  }

  Widget _uploadImageButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getPropWidth(15)),
      child: IconButton(
        icon: Icon(Icons.add_a_photo, color: aColor2),
        onPressed: () => _uploadImage(context),
      ),
    );
  }

  Widget _onFocus(
      BuildContext context, Widget child, String imgUrl, String imgPath) {
    return FocusedMenuHolder(
      menuWidth: SizeConfig.screenWidth * 0.5,
      blurSize: 5.0,
      menuItemExtent: 45,
      menuBoxDecoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      duration: Duration(milliseconds: 100),
      animateMenuItems: true,
      blurBackgroundColor: Colors.black54,
      menuOffset: 10.0,
      bottomOffsetHeight: 80.0,
      menuItems: [
        FocusedMenuItem(
            title: Text(
              "Delete",
              style: TextStyle(color: Colors.redAccent),
            ),
            trailingIcon: Icon(Icons.delete, color: errorColor),
            onPressed: () => BlocProvider.of<ProfileBloc>(context)
                .add(DeleteImage(imgUrl: imgUrl, imgPath: imgPath))),
      ],
      onPressed: () {},
      child: child,
    );
  }

  Widget _imageContainer(BuildContext context, String imgUrl) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ImageViewWidget(imageUrl: imgUrl))),
      child: Padding(
        padding: EdgeInsets.only(left: getPropWidth(5), right: getPropWidth(5)),
        child: Hero(
          tag: imgUrl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  _uploadImage(BuildContext context) async {
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      BlocProvider.of<ProfileBloc>(context).add(UploadImage(image: file));
    }
  }
}
