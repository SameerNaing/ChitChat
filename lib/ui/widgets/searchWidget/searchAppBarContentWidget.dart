import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class SearchAppBarContentWidget extends StatefulWidget {
  SearchAppBarContentWidget({Key key}) : super(key: key);

  @override
  _SearchAppBarContentWidgetState createState() =>
      _SearchAppBarContentWidgetState();
}

class _SearchAppBarContentWidgetState extends State<SearchAppBarContentWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: aColor2),
          iconSize: getPropWidth(20),
          onPressed: () => _goBack(),
        ),
        Expanded(
          child: TextField(
            onChanged: (value) => _onSubmit(),
            controller: _controller,
            cursorColor: Colors.black,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: 'Search'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: aColor2),
          iconSize: getPropWidth(20),
          onPressed: () => _clearText(),
        ),
      ],
    );
  }

  _goBack() {
    return Navigator.of(context).pop();
  }

  _clearText() {
    _controller.text = '';
    context.bloc<SearchCubit>().clearList();
  }

  _onSubmit() {
    if (_controller.text != '') {
      context.bloc<SearchCubit>().search(_controller.text);
    } else {
      context.bloc<SearchCubit>().clearList();
    }
  }
}
