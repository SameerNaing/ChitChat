import 'package:chit_chat/ui/screens/account_screens/addAccountScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/ui/ui.dart';

class ExistingAccountScreen extends StatelessWidget {
  final List<Accounts> accounts;
  ExistingAccountScreen({Key key, this.accounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/SvgIcons/chat.svg',
                  height: getPropHeight(90), width: getPropWidth(90)),
              SizedBox(height: getPropHeight(50)),
              ExistingAccountListWidget(accounts: accounts),
              SizedBox(height: getPropHeight(30)),
              GestureDetector(
                onTap: () => _addNewAccount(context),
                child: Container(
                  decoration: BoxDecoration(color: pColor1),
                  height: getPropHeight(40),
                  width: getPropWidth(300),
                  child: Row(
                    children: [
                      Spacer(flex: 2),
                      Icon(Icons.add, color: pColor2),
                      Spacer(flex: 1),
                      Text('Add new Account',
                          style: TextStyle(
                              color: pColor2,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500)),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addNewAccount(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BlocProvider.value(
              value: BlocProvider.of<AccountBloc>(context),
              child: AddAccountScreen(),
            )));
  }
}
