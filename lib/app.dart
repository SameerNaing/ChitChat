import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => AccountBloc()..add(Authenticate()),
        child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, accountState) {
          return AnimatedSwitcher(
            duration: Duration(microseconds: 200),
            child: _buildPage(context, accountState),
          );
        }),
      ),
    );
  }

  _buildPage(BuildContext context, AccountState accountState) {
    if (accountState.accountScreen == AccountScreen.OnBoarding) {
      return OnBoardingScreen(key: Key('OnBoardingScreen'));
    } else if (accountState.accountScreen == AccountScreen.Splash) {
      return SplashScreen(key: Key('SplashScreen'));
    } else if (accountState.accountScreen == AccountScreen.Login_Register) {
      return LoginScreen(key: Key('LoginScreen'), accountState: accountState);
    } else if (accountState.accountScreen == AccountScreen.AddUserInfoScreen) {
      return UploadProfilePicScreen(
          key: Key('ProfilePicScreen'), accountState: accountState);
    } else if (accountState.accountScreen == AccountScreen.Accounts) {
      return ExistingAccountScreen(accounts: accountState.accounts);
    } else if (accountState.accountScreen == AccountScreen.App) {
      return MainApp(accountState: accountState);
    }
  }
}
