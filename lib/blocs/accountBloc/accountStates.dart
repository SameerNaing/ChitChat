import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

enum AccountScreen {
  Splash,
  OnBoarding,
  Login_Register,
  App,
  Accounts,
  AddUserInfoScreen,
}

enum AccountStatus {
  Normal,
  Loading,
  Error,
  RegisterSuccess,
  ProfilePhotoUploaded,
  UserInfoAdded,
}

class AccountState extends Equatable {
  final AccountScreen accountScreen;
  final AccountStatus accountStatus;
  final UserModel userModel;
  final String profilePicUrl;
  final List<Accounts> accounts;
  final String errorMessage;
  final bool onLine;

  AccountState({
    @required this.accountScreen,
    @required this.accountStatus,
    @required this.userModel,
    @required this.profilePicUrl,
    @required this.accounts,
    @required this.errorMessage,
    @required this.onLine,
  });

  AccountState update({
    AccountScreen accountScreen,
    AccountStatus accountStatus,
    UserModel userModel,
    String profilePicUrl,
    List<Accounts> accounts,
    String errorMessage,
    bool onLine,
  }) {
    return AccountState(
      accountScreen: accountScreen ?? this.accountScreen,
      accountStatus: accountStatus ?? this.accountStatus,
      userModel: userModel ?? this.userModel,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      accounts: accounts ?? this.accounts,
      errorMessage: errorMessage ?? this.errorMessage,
      onLine: onLine ?? this.onLine,
    );
  }

  static AccountState initial() {
    return AccountState(
      accountScreen: AccountScreen.Splash,
      accountStatus: AccountStatus.Normal,
      userModel: null,
      profilePicUrl: null,
      accounts: null,
      errorMessage: null,
      onLine: null,
    );
  }

  @override
  List<Object> get props => [
        accountScreen,
        accountStatus,
        userModel,
        profilePicUrl,
        accounts,
        errorMessage,
        onLine,
      ];
}
