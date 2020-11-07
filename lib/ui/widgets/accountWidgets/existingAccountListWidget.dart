import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';

class ExistingAccountListWidget extends StatelessWidget {
  final List<Accounts> accounts;
  const ExistingAccountListWidget({Key key, @required this.accounts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPropHeight(200),
      width: getPropWidth(270),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: ListView.builder(
          itemCount: accounts?.length,
          itemBuilder: (context, index) {
            Accounts account = accounts[index];
            return GestureDetector(
              onTap: () =>
                  _loginToAccount(context, account.email, account.password),
              child: Container(
                margin: EdgeInsets.only(bottom: getPropHeight(10)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        account.profilePhoto,
                        height: getPropHeight(60),
                        width: getPropWidth(60),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(account.userName,
                            style: TextStyle(
                                color: aColor2,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500)),
                        trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeAccount(context, index)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _removeAccount(BuildContext context, int index) {
    BlocProvider.of<AccountBloc>(context).add(RemoveAccount(index: index));
  }

  _loginToAccount(BuildContext context, String email, String password) {
    BlocProvider.of<AccountBloc>(context)
        .add(Login(email: email, password: password));
  }
}
