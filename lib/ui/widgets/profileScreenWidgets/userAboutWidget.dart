import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class UserAboutWidget extends StatelessWidget {
  final UserModel user;

  final UserRelation relation;
  UserAboutWidget({
    Key key,
    @required this.user,
    @required this.relation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getHeaderWidget(),
        SizedBox(height: getPropHeight(19)),
        _getUserBio(),
        SizedBox(height: getPropHeight(30)),
        _getPhotoHeader(),
        SizedBox(height: getPropHeight(15)),
        _getPhotosListView(),
      ],
    );
  }

  Widget _getHeaderWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getNameAndLocation(),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _getButton(),
        ),
      ],
    );
  }

  _getButton() {
    if (relation == null || relation == UserRelation.CurrentUser) {
      return Container();
    } else if (relation == UserRelation.Friend) {
      return ChatButtonWidget(user: DisplayUserModel.toModel(user));
    } else if (relation == UserRelation.None) {
      return SendRequestButtonWidget(toUser: DisplayUserModel.toModel(user));
    } else if (relation == UserRelation.RequestGet) {
      return ConformCancleButton(fromUser: DisplayUserModel.toModel(user));
    } else if (relation == UserRelation.RequestSend) {
      return RequestButtonWidget(toUser: DisplayUserModel.toModel(user));
    }
  }

  Widget _getNameAndLocation() {
    return Column(
      children: [
        Text(
          user.name,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: getPropWidth(16),
              color: aColor2,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: getPropHeight(5)),
        Text(
          user.loacation,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: getPropWidth(13),
              color: aColor2,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _getUserBio() {
    return Container(
      padding: EdgeInsets.only(left: getPropWidth(12), right: getPropWidth(12)),
      width: SizeConfig.screenWidth,
      child: Text(
        user.bio,
        style: TextStyle(
          color: aColor2,
          height: getPropHeight(1.6),
          fontFamily: 'Roboto',
          fontStyle: FontStyle.italic,
          fontSize: getPropWidth(15),
        ),
      ),
    );
  }

  Widget _getPhotoHeader() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Photos',
        style: TextStyle(
          color: aColor2,
          fontFamily: 'Roboto',
          fontSize: getPropWidth(15),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _getPhotosListView() {
    return Container(
      height: getPropHeight(160),
      padding: EdgeInsets.only(left: getPropWidth(5), right: getPropWidth(3)),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _getItemlength() + 1,
          itemBuilder: (context, index) {
            bool last = index == _getItemlength();
            String imgUrl = last ? null : user.uploadPhotosUrl[index];

            return Container(
              padding: EdgeInsets.only(right: getPropWidth(last ? 0 : 10)),
              width: getPropWidth(160),
              child: last
                  ? GestureDetector(
                      onTap: () => ProfileNavigations.toImagesScreen(
                        context: context,
                        user:
                            relation == UserRelation.CurrentUser ? null : user,
                        currentUser: relation == UserRelation.CurrentUser,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: pColor1.withOpacity(0.6),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: Icon(Icons.more_horiz,
                              size: getPropWidth(60), color: pColor1),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ImageViewWidget(imageUrl: imgUrl))),
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
          },
        ),
      ),
    );
  }

  _getItemlength() {
    if (user.uploadPhotosUrl.length > 6) {
      return 6;
    } else {
      return user.uploadPhotosUrl.length;
    }
  }
}
