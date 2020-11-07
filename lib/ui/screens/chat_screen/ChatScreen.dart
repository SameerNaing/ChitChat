import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class ChatScreen extends StatefulWidget {
  final MessageStates messageState;
  final String reciverUserName;
  ChatScreen(
      {Key key, @required this.messageState, @required this.reciverUserName})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _keyboard = false;
  _setKeyBoard(value) => setState(() => _keyboard = value);
  @override
  void dispose() {
    BlocProvider.of<MessageBloc>(context).add(CloseMessageStream());
    super.dispose();
  }

  @override
  void initState() {
    KeyboardVisibilityNotification()
        .addNewListener(onChange: (bool visible) => _setKeyBoard(visible));
    super.initState();
  }

  @override
  void didUpdateWidget(ChatScreen oldWidget) {
    BlocProvider.of<MessageBloc>(context).add(MessageSeen());
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: pColor2,
        appBar: ChatScreenAppBar(
            reciverName: widget.reciverUserName, state: widget.messageState),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  child: _buildPage(context, widget.messageState),
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: _buildContainer(context, widget.messageState),
              ),
              Container(
                height: getPropHeight(90),
                width: SizeConfig.screenWidth,
                child: Row(
                  children: [
                    SizedBox(width: getPropWidth(15)),
                    SendImageButtonWidget(),
                    SizedBox(width: getPropWidth(15)),
                    SendGifButtonWidget(),
                    SizedBox(width: getPropWidth(18)),
                    TextMessageField(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildPage(BuildContext context, MessageStates messageState) {
    if (messageState.status == MessageStateStatus.Loading) {
      return Container(
        key: Key('LoadingIndicator'),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (messageState.status == MessageStateStatus.Error) {
      return Container(
        key: Key('ErrorText'),
        child: Center(
          child: Text('Oops...'),
        ),
      );
    } else if (messageState.status == MessageStateStatus.Loaded) {
      if (messageState.messages.length == 0 &&
          messageState.messageStatus != MessageStatus.Sending &&
          !_keyboard) {
        return NoChatWidget(key: Key('NoChats'));
      } else {
        return DisplayChatMessagesWidget(
            key: Key('AllChats'), messageState: messageState);
      }
    }
  }

  _buildContainer(BuildContext context, MessageStates state) {
    if (state.messageStatus == MessageStatus.Sent &&
        state.imageSendingStatus == ImageSendingStatus.Sent) {
      return Container(key: Key('EmptyContainer'));
    } else if (state.messageStatus == MessageStatus.Sending) {
      return LoadingTextMessageWidget(key: Key('LoadingTextMessage'));
    } else if (state.imageSendingStatus == ImageSendingStatus.Sending) {
      return LoadingImageWidget(
        key: Key('LoadingImageWidget'),
      );
    }
  }
}
