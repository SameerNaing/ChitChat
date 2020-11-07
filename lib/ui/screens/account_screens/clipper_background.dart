import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';

class ClipperBackground extends StatefulWidget {
  final Widget child;
  final AccountState accountState;
  ClipperBackground({this.child, @required this.accountState});
  @override
  _ClipperBackgroundState createState() => _ClipperBackgroundState();
}

class _ClipperBackgroundState extends State<ClipperBackground> {
  bool _scroll = false;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(
          () {
            _scroll = visible;
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AccountStatus accountStatus = widget.accountState.accountStatus;
    String errorMessage = widget.accountState.errorMessage;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: _scroll ? ScrollPhysics() : NeverScrollableScrollPhysics(),
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SlideTtoB(child: TopClipper(), delay: 1.1),
                  ),
                ),
                widget.child,
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        children: [
                          SlideBtoT(child: BottomClipper(), delay: 1.1),
                          Positioned(
                            left: getPropWidth(55),
                            bottom: getPropHeight(50),
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: _buildErrorBox(
                                    accountStatus, errorMessage)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildErrorBox(AccountStatus accountstatus, String errorMessage) {
    if (accountstatus == AccountStatus.Normal) {
      return Container();
    } else if (accountstatus == AccountStatus.Error) {
      return AccountErrorMessageBox(errormessage: errorMessage);
    }
  }
}
