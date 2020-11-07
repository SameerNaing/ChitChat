import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/utils/utilities.dart';
import 'package:chit_chat/blocs/blocs.dart';

class LoginScreen extends StatefulWidget {
  final AccountState accountState;

  LoginScreen({Key key, @required this.accountState}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _space = false;
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    AccountStatus accountStatus = widget.accountState.accountStatus;
    SizeConfig().init(context);
    return ClipperBackground(
      accountState: widget.accountState,
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
                child: FadeTtoB(child: HeaderText(text: 'Login'), delay: 1.2),
              ),
            ),
            FadeTtoB(
              child: TextFormFieldWidget(
                onSave: _emailOnSave,
                validate: _validateEmail,
                hintText: 'Email',
                isPassword: false,
                space: _space,
              ),
              delay: 1.3,
            ),
            SizedBox(height: getPropHeight(20)),
            FadeTtoB(
              child: TextFormFieldWidget(
                onSave: _passwrodOnSave,
                validate: _validatePassword,
                hintText: 'Password',
                isPassword: true,
                space: _space,
              ),
              delay: 1.4,
            ),
            SizedBox(height: getPropHeight(20)),
            FadeTtoB(
                child: _registerUser(context, widget.accountState), delay: 1.5),
            SizedBox(height: getPropHeight(25)),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: _buildButton(widget.accountState.accountStatus),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerUser(BuildContext context, AccountState accountState) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<AccountBloc>(context),
                  child: RegisterScreen(),
                )));
      },
      child: Text('I don\'t have Account.',
          style: TextStyle(
            color: pColor1,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          )),
    );
  }

  _onPressed() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    BlocProvider.of<AccountBloc>(context)
        .add(Login(email: _email, password: _password));
  }

  _emailOnSave(value) {
    setState(() => _space = false);
    _email = value;
  }

  _passwrodOnSave(value) {
    setState(() => _space = false);
    _password = value;
  }

  // ignore: missing_return
  String _validateEmail(value) {
    if (!Utilities.validateEmail(value)) {
      setState(() => _space = true);
      return 'Invalid Email';
    }
  }

  // ignore: missing_return
  String _validatePassword(value) {
    if (Utilities.checkPassword(value)) {
      setState(() => _space = true);
      return 'Password should be at lease 6 charaters long';
    }
  }

  _buildButton(AccountStatus accountStatus) {
    if (accountStatus == AccountStatus.Loading) {
      return CircularProgressIndicator();
    } else {
      return FadeTtoB(
          child: AccountButtonWidget(text: 'Login', onPressed: _onPressed),
          delay: 1.6);
    }
  }
}
