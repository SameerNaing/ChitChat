import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class TextMessageField extends StatefulWidget {
  @override
  _TextMessageFieldState createState() => _TextMessageFieldState();
}

class _TextMessageFieldState extends State<TextMessageField> {
  bool _writing = false;
  bool _activateSendButton = false;
  TextEditingController _textEditingController = TextEditingController();

  void _setActivate(val) => setState(() => _activateSendButton = val);

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: getPropHeight(_writing ? 480 : 45),
          width: getPropWidth(200),
          child: TextField(
            onChanged: (val) {
              if (val.length > 23) {
                setState(() => _writing = true);
              }
              if (val.length < 22) {
                setState(() => _writing = false);
              }
              if (val != '' && val.trim() != '') {
                _setActivate(true);
              } else {
                _setActivate(false);
              }
            },
            controller: _textEditingController,
            maxLines: null,
            style: TextStyle(color: aColor2, fontFamily: 'Roboto'),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pColor1.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pColor1.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Type a message...',
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getPropWidth(20), vertical: getPropHeight(11)),
            ),
          ),
        ),
        SizedBox(width: getPropWidth(15)),
        SendTextMessageButtonWidget(
          activate: _activateSendButton,
          onPressed: _sendMessage,
        ),
      ],
    );
  }

  _sendMessage() {
    if (_activateSendButton) {
      BlocProvider.of<MessageBloc>(context)
          .add(SendTextMessage(messageText: _textEditingController.text));
      setState(() => _textEditingController.text = '');
      _setActivate(false);
    }
  }
}
