import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class ConversationsListWidget extends StatelessWidget {
  final List<DisplayMessageModel> displayMessages;
  ConversationsListWidget({Key key, @required this.displayMessages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = getPropHeight(120);
    int length = displayMessages.length;
    return Container(
      height: length == 0 ? height : height * length,
      child: _getPage(context),
    );
  }

  _getPage(BuildContext context) {
    if (displayMessages.length == 0) {
      return Center(
        child: Text('No Conversations.',
            style: TextStyle(
                color: aColor2.withOpacity(0.6),
                fontFamily: 'Roboto',
                fontSize: getPropWidth(18))),
      );
    } else {
      return _getListView(context);
    }
  }

  Widget _getListView(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayMessages.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onTap(context, displayMessages[index]),
          child: DisplayMessageListItem(displayMessage: displayMessages[index]),
        );
      },
    );
  }

  _onTap(BuildContext context, DisplayMessageModel displayMessageModel) {
    return NavigateToChatScreenWidget.navigate(context,
        reciverId: displayMessageModel.uid,
        reciverUserName: displayMessageModel.name);
  }
}
