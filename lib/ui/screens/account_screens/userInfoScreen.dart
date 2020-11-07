import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen({Key key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _bio;
  String _relationalstatus;
  String _location;
  bool _space = false;
  void _setErrorSpace(bool value) => setState(() => _space = value);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, accountState) {
        if (accountState.accountScreen == AccountScreen.App) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, accountState) {
          return ClipperBackground(
            accountState: accountState,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getPropHeight(20),
                        horizontal: getPropWidth(30),
                      ),
                      child:
                          FadeTtoB(child: HeaderText(text: 'Info'), delay: 1.2),
                    ),
                  ),
                  FadeTtoB(
                    child: BioFieldWidget(
                      onSave: _bioOnSave,
                      validate: _validateBio,
                    ),
                    delay: 1.3,
                  ),
                  SizedBox(height: getPropHeight(20)),
                  FadeTtoB(
                      child: TextFormFieldWidget(
                        space: _space,
                        hintText: 'location',
                        onSave: _locationOnSave,
                        validate: _validatelocation,
                        isPassword: false,
                      ),
                      delay: 1.4),
                  SizedBox(height: getPropHeight(20)),
                  FadeTtoB(
                    child: TextFormFieldWidget(
                      space: _space,
                      hintText: 'relational status',
                      onSave: _statusOnSave,
                      validate: _validateStatus,
                      isPassword: false,
                    ),
                    delay: 1.5,
                  ),
                  SizedBox(height: getPropHeight(30)),
                  FadeTtoB(
                      child: _buildButton(accountState.accountStatus),
                      delay: 1.6),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton(AccountStatus status) {
    if (status == AccountStatus.Loading) {
      return CircularProgressIndicator();
    } else {
      return AccountButtonWidget(text: 'Done', onPressed: _onDone);
    }
  }

  // ignore: missing_return
  String _validateBio(value) {
    if (value.isEmpty) return 'Add Bio';
  }

  // ignore: missing_return
  String _validatelocation(value) {
    if (value.isEmpty) {
      _setErrorSpace(true);
      return 'Add location';
    }
  }

  // ignore: missing_return
  String _validateStatus(value) {
    if (value.isEmpty) {
      _setErrorSpace(true);
      return 'Add relational status';
    }
  }

  _bioOnSave(value) {
    _setErrorSpace(false);
    _bio = value;
  }

  _locationOnSave(value) {
    _setErrorSpace(false);
    _location = value;
  }

  _statusOnSave(value) {
    _setErrorSpace(false);
    _relationalstatus = value;
  }

  _onDone() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    BlocProvider.of<AccountBloc>(context).add(AddInfo(
        bio: _bio, relationStatus: _relationalstatus, location: _location));
  }
}
