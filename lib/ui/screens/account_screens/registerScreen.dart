import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/utils/utilities.dart';
import 'package:chit_chat/blocs/blocs.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _space = false;
  String _username;
  String _email;
  String _password;
  String _conformPassword;

  void _setErrorSpace(bool val) => setState(() => _space = val);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, accountstate) {
        if (accountstate.accountScreen == AccountScreen.AddUserInfoScreen) {
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
                        vertical: getPropHeight(30),
                        horizontal: getPropWidth(30),
                      ),
                      child: FadeTtoB(
                          child: HeaderText(text: 'Register'), delay: 1.2),
                    ),
                  ),
                  FadeTtoB(
                      child: TextFormFieldWidget(
                        hintText: 'Username',
                        isPassword: false,
                        onSave: _userNameonSave,
                        validate: _userNameValidate,
                        space: _space,
                      ),
                      delay: 1.2),
                  SizedBox(height: getPropHeight(15)),
                  FadeTtoB(
                      child: TextFormFieldWidget(
                        hintText: 'Email',
                        isPassword: false,
                        onSave: _emailonSave,
                        validate: _emailValidate,
                        space: _space,
                      ),
                      delay: 1.3),
                  SizedBox(height: getPropHeight(15)),
                  FadeTtoB(
                      child: TextFormFieldWidget(
                        hintText: 'Password',
                        isPassword: true,
                        onSave: _passwordonSave,
                        validate: _passwordValidate,
                        onChange: _passwordOnChange,
                        space: _space,
                      ),
                      delay: 1.4),
                  SizedBox(height: getPropHeight(15)),
                  FadeTtoB(
                      child: TextFormFieldWidget(
                        hintText: 'Conform Password',
                        isPassword: true,
                        onChange: _conformPasswordOnChange,
                        validate: _conformPasswordValidate,
                        space: _space,
                      ),
                      delay: 1.5),
                  SizedBox(height: getPropHeight(25)),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: _buildButton(context, accountState),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onPressed(BuildContext context, AccountState accountstate) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('Done');

    BlocProvider.of<AccountBloc>(context)
        .add(Register(username: _username, password: _password, email: _email));
  }

  _passwordOnChange(value) {
    _password = value;
  }

  _conformPasswordOnChange(value) => _conformPassword = value;
  String _userNameValidate(value) {
    if (value.isEmpty) {
      _setErrorSpace(true);
      return 'Please Enter Username';
    }
  }

  String _emailValidate(value) {
    if (!Utilities.validateEmail(value)) {
      _setErrorSpace(true);
      return 'Invalid Email';
    }
  }

  String _passwordValidate(value) {
    if (Utilities.checkPassword(value)) {
      _setErrorSpace(true);
      return 'Password should be at least 6 characters long';
    }
  }

  String _conformPasswordValidate(value) {
    if (!Utilities.conformPassword(_password, _conformPassword)) {
      _setErrorSpace(true);
      return 'Incorrect Password';
    }
  }

  _userNameonSave(value) {
    _setErrorSpace(false);
    _username = value;
  }

  _emailonSave(value) {
    _setErrorSpace(false);
    _email = value;
  }

  _passwordonSave(value) {
    _setErrorSpace(false);
    _password = value;
  }

  _buildButton(BuildContext context, AccountState accountState) {
    if (accountState.accountStatus == AccountStatus.Loading) {
      return Container(child: CircularProgressIndicator());
    } else {
      return FadeTtoB(
        child: AccountButtonWidget(
          text: 'Register',
          onPressed: () => _onPressed(context, accountState),
        ),
        delay: 1.6,
      );
    }
  }
}
