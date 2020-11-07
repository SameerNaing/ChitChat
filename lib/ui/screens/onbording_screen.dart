import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  bool _showButton = false;
  List<Map<String, String>> onBordingData = [
    {
      'title': 'CHIT CHAT',
      'subtitle': 'Welcome to CHIT CHAT',
      'svg': 'assets/SvgIcons/undraw_new_message.svg',
    },
    {
      'title': 'Make Friends',
      'subtitle': 'Make friends by sending and accepting chat requests.',
      'svg': 'assets/SvgIcons/undraw_accept_request.svg',
    },
    {
      'title': 'Chat',
      'subtitle': 'Chat with your friends.',
      'svg': 'assets/SvgIcons/undraw_chat_with_friends.svg',
    },
    {
      'title': 'Images',
      'subtitle': 'Upload images',
      'svg': 'assets/SvgIcons/undraw_upload_image.svg',
    },
    {
      'title': 'Ok',
      'subtitle': ' Start App.',
      'svg': 'assets/SvgIcons/undraw_begin_chat.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return;
                  },
                  child: PageView.builder(
                    onPageChanged: (value) {
                      if (value == onBordingData.length - 1) {
                        setState(() {
                          _showButton = true;
                        });
                      } else {
                        setState(() {
                          _showButton = false;
                        });
                      }
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    itemCount: onBordingData.length,
                    itemBuilder: (context, index) {
                      String title = onBordingData[index]['title'];
                      String sub = onBordingData[index]['subtitle'];
                      String svg = onBordingData[index]['svg'];
                      return OnBoardingWidget(
                          title: title, subtitle: sub, svg: svg);
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onBordingData.length,
                        (index) => _buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 1),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          child: child,
                          scale: animation,
                        );
                      },
                      child: _buildButton(context),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer _buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? pColor1 : aColor2,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _startButton(BuildContext context, Key key) {
    return SizedBox(
      key: key,
      width: getPropWidth(300),
      height: getPropHeight(40),
      child: FlatButton(
        onPressed: () {
          BlocProvider.of<AccountBloc>(context)
              .add(ShowLoginRegisterPage()); //Bloc Event
        },
        color: pColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: Text(
          'Get Started !',
          style: TextStyle(
            color: pColor2,
            fontFamily: 'Roboto',
            fontSize: getPropWidth(18),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    if (_showButton) {
      return _startButton(context, Key('FlatButton'));
    } else {
      return Container(key: Key('EmptyContainer'));
    }
  }
}
