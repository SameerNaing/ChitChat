import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileStates profileStates;
  final UserRelation relation;
  PanelController _panelController = PanelController();
  ProfileScreen({
    Key key,
    @required this.profileStates,
    @required this.relation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: relation == UserRelation.CurrentUser
            ? null
            : _getBackArrowButton(context),
        elevation: 1,
        backgroundColor: Colors.transparent,
        actions: [
          relation == UserRelation.CurrentUser
              ? _getMoreButton(context)
              : Container(),
        ],
      ),
      body: _buildPage(context),
    );
  }

  _buildPage(BuildContext context) {
    if (relation == UserRelation.CurrentUser) {
      return _buildCurrentUser();
    } else {
      return _buildUser(context);
    }
  }

  _buildUser(BuildContext context) {
    if (profileStates.profilePageState == ProfilePageState.Loading) {
      return _loading();
    } else if (profileStates.profilePageState == ProfilePageState.Loaded) {
      return _loaded(profileStates.userProfile);
    } else if (profileStates.profilePageState == ProfilePageState.Error) {
      return _error(context, false);
    }
  }

  _buildCurrentUser() {
    if (profileStates.currentUserProfile == null) {
      return _loading();
    } else {
      return _loaded(profileStates.currentUserProfile);
    }
  }

  Widget _loaded(UserModel user) {
    return SlidingUpPanel(
      maxHeight: getPropHeight(430),
      minHeight: getPropHeight(140),
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      controller: _panelController,
      color: Colors.black.withOpacity(0.2),
      body: Hero(
          child: Image.network(user.profileImage, fit: BoxFit.cover),
          tag: user.profileImage),
      panelBuilder: (ScrollController scrollController) {
        return PanelWidget(user: user, relation: relation);
      },
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _error(BuildContext context, bool currentUser) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Check Your Connection'),
          ],
        ),
      ),
    );
  }

  Widget _getMoreButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getPropWidth(15)),
      child: IconButton(
        icon: Icon(Icons.more_vert, color: pColor2),
        splashRadius: getPropWidth(20),
        onPressed: () => ProfileNavigations.toMoreScreen(context: context),
      ),
    );
  }

  Widget _getBackArrowButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: pColor2),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
