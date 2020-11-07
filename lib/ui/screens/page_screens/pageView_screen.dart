import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';

class PageViewScreen extends StatefulWidget {
  final ProfileStates profileStates;
  final PeopleStates peopleStates;
  final HomeScreenStates homeScreenStates;
  PageViewScreen({
    Key key,
    @required this.peopleStates,
    @required this.profileStates,
    @required this.homeScreenStates,
  }) : super(key: key);

  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  String _pageName = 'Messages';

  void _setPageName(value) {
    setState(() {
      switch (value) {
        case 0:
          {
            _pageName = 'Messages';
            break;
          }
        case 1:
          {
            _pageName = 'People';
            break;
          }
      }
    });
  }

  void _setIndex(value) {
    setState(() => _currentIndex = value);
    _setPageName(value);

    _pageController.animateToPage(
      value,
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  @override
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: pColor2,
        appBar: _currentIndex != 2
            ? PageAppBarWidget(
                title: _pageName, allUsers: widget.peopleStates.allUsers)
            : null,
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(homeScreenStates: widget.homeScreenStates),
            PeoplesScreen(peopleStates: widget.peopleStates),
            ProfileScreen(
                profileStates: widget.profileStates,
                relation: UserRelation.CurrentUser),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: pColor2,
          height: getPropHeight(60),
          color: pColor1,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          items: <Widget>[
            Icon(
              Icons.dashboard,
              size: 30,
              color: _currentIndex == 0 ? pColor2 : pColor2.withAlpha(100),
            ),
            Icon(
              Icons.people,
              size: 30,
              color: _currentIndex == 1 ? pColor2 : pColor2.withAlpha(100),
            ),
            Icon(
              Icons.account_circle,
              size: 30,
              color: _currentIndex == 2 ? pColor2 : pColor2.withAlpha(100),
            ),
          ],
          onTap: (index) => _setIndex(index),
        ),
      ),
    );
  }
}
