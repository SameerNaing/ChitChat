import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';

class AddAccountScreen extends StatelessWidget {
  AddAccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.accountScreen == AccountScreen.AddUserInfoScreen ||
            state.accountScreen == AccountScreen.App) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, accountState) {
          return LoginScreen(accountState: accountState);
        },
      ),
    );
  }
}
