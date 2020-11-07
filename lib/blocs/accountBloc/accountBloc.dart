import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/repository/repository.dart';
import 'package:chit_chat/models/models.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  FirebaseAuthService _auth = FirebaseAuthService();
  AccountFireStore _userFireDb = AccountFireStore();
  FireStorage _fireStorage = FireStorage();
  HiveDbOperations _hiveDb = HiveDbOperations();
  Uuid _uuid = Uuid();

  String _username;
  String _email;
  String _password;
  String _profilePhotoUrl;
  String _profilePhotoPath;

  AccountBloc() : super(AccountState.initial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    SharedPreferences prefs = await _prefs;

    try {
      await _hiveDb.hiveRegisterAdapter();
      await _hiveDb.hiveOpenBox(boxName: 'Accounts');
    } catch (e) {
      print(e);
    }

    if (event is Authenticate) {
      yield* _mapAuthenticateToState(prefs);
    } else if (event is SignOut) {
      yield* _mapSignOutEventToState(prefs);
    } else if (event is Authenticated) {
      yield* _mapAuthenticatedToState(event.uid);
    } else if (event is Login) {
      yield* _mapLoginToState(event, prefs);
    } else if (event is Register) {
      yield* _mapRegisterToState(event);
    } else if (event is UploadProfileImage) {
      yield* _mapUploadProfilePhotoToState(event.imageFile);
    } else if (event is AddInfo) {
      yield* _mapAddInfoToState(event, prefs);
    } else if (event is SignOut) {
      yield* _mapSignOutEventToState(prefs);
    } else if (event is RemoveAccount) {
      yield* _mapRemoveAccountToState(event.index);
    } else if (event is ShowLoginRegisterPage) {
      yield state.update(accountScreen: AccountScreen.Login_Register);
    }
  }

  Stream<AccountState> _mapAuthenticatedToState(String uid) async* {
    UserModel userModel = await _userFireDb.getUser(uid);
    yield state.update(accountScreen: AccountScreen.App, userModel: userModel);
  }

  Stream<AccountState> _mapAuthenticateToState(SharedPreferences prefs) async* {
    yield state.update(accountScreen: AccountScreen.Splash);
    await Future.delayed(Duration(seconds: 5));
    String uid = prefs.getString('uid');
    bool onBoarding = prefs.getBool('onBoarding') ?? true;

    if (onBoarding) prefs.setBool('onBoarding', false);

    if (uid == null) {
      if (_hiveDb.box.length != 0) {
        List<Accounts> accs = await _hiveDb.getAllAccounts();
        yield state.update(
            accountScreen: AccountScreen.Accounts, accounts: accs);
      } else {
        yield onBoarding
            ? state.update(accountScreen: AccountScreen.OnBoarding)
            : state.update(accountScreen: AccountScreen.Login_Register);
      }
    } else {
      UserModel userModel = await _userFireDb.getUser(uid);

      yield state.update(
          accountScreen: AccountScreen.App, userModel: userModel);
    }
  }

  Stream<AccountState> _mapLoginToState(
      Login event, SharedPreferences prefs) async* {
    yield state.update(accountStatus: AccountStatus.Loading);
    try {
      await _auth.signIn(email: event.email, password: event.password);
      String uid = _auth.userId;
      UserModel user = await _userFireDb.getUser(uid);

      prefs.setString('uid', uid);
      bool exists = await _hiveDb.accountExists(uid);
      if (exists) {
        int index = await _hiveDb.getIndex(uid);
        prefs.setInt('index', index);
      } else {
        Accounts account = Accounts(
          userName: user.name,
          profilePhoto: user.profileImage,
          email: event.email,
          password: event.password,
          uid: uid,
        );
        await _hiveDb.addAccount(account);
        int index = await _hiveDb.getIndex(uid);
        prefs.setInt('index', index);
      }
      UserModel userModel = await _userFireDb.getUser(uid);
      yield state.update(
          accountStatus: AccountStatus.Normal,
          accountScreen: AccountScreen.App,
          userModel: userModel);
    } on FirebaseException catch (e) {
      print(e);
      yield* _yieldError(e.message.toString());
    } catch (e) {
      print(e);
      yield* _yieldError(e.toString());
    }
  }

  Stream<AccountState> _mapRegisterToState(Register event) async* {
    yield state.update(accountStatus: AccountStatus.Loading);
    try {
      await _auth.signUp(email: event.email, password: event.password);
      _username = event.username;
      _email = event.email;
      _password = event.password;
      yield state.update(
          accountStatus: AccountStatus.Normal,
          accountScreen: AccountScreen.AddUserInfoScreen);
    } on FirebaseAuthException catch (e) {
      print(e);
      yield* _yieldError(e.message.toString());
    } catch (e) {
      print(e);
      yield* _yieldError(e.toString());
    }
  }

  Stream<AccountState> _mapUploadProfilePhotoToState(File imageFile) async* {
    yield state.update(accountStatus: AccountStatus.Loading);
    try {
      if (_profilePhotoPath != null) {
        await _fireStorage.openExistingPath(_profilePhotoPath);
        await _fireStorage.deleteImage();
      }
      String userId = _auth.userId;
      String uniqueId = _uuid.v4();
      String picPath = _fireStorage.createProfileReference(userId, uniqueId);
      String imgUrl = await _fireStorage.uploadImage(imageFile);

      _profilePhotoPath = picPath;
      _profilePhotoUrl = imgUrl;

      yield state.update(
          accountStatus: AccountStatus.ProfilePhotoUploaded,
          profilePicUrl: _profilePhotoUrl);
    } catch (e) {
      yield* _yieldError(e.toString());
    }
  }

  Stream<AccountState> _mapAddInfoToState(
      AddInfo addInfo, SharedPreferences prefs) async* {
    yield state.update(accountStatus: AccountStatus.Loading);
    try {
      String uid = _auth.userId;
      Accounts account = Accounts(
        userName: _username,
        profilePhoto: _profilePhotoUrl,
        email: _email,
        password: _password,
        uid: uid,
      );
      UserModel user = UserModel(
        name: _username,
        profileImage: _profilePhotoUrl,
        profileImagePath: _profilePhotoPath,
        bio: addInfo.bio,
        relationStatus: addInfo.relationStatus,
        loacation: addInfo.location,
        uid: uid,
        numFriends: 0,
        uploadPhotosUrl: [],
        uploadPhotosPath: [],
      );

      _profilePhotoPath = null;

      await _hiveDb.addAccount(account);
      await _userFireDb.addUser(user);
      prefs.setString('uid', uid);
      int index = await _hiveDb.getIndex(uid);
      prefs.setInt('index', index);

      yield state.update(
          accountScreen: AccountScreen.App,
          userModel: user,
          accountStatus: AccountStatus.Normal);
    } catch (e) {
      print(e);
      yield* _yieldError(e.toString());
    }
  }

  Stream<AccountState> _mapSignOutEventToState(SharedPreferences prefs) async* {
    try {
      await _auth.signOut();
      prefs.remove('uid');
      prefs.remove('index');
      yield* _getScreen();
    } catch (e) {
      print(e);
      yield* _yieldError(e.toString());
    }
  }

  Stream<AccountState> _mapRemoveAccountToState(int index) async* {
    try {
      await _hiveDb.deleteAccount(index);
      yield* _getScreen();
    } catch (e) {
      print(e);
      yield* _yieldError(e.toString());
    }
  }

  Stream<AccountState> _getScreen() async* {
    if (_hiveDb.box.length == 0) {
      yield state.update(accountScreen: AccountScreen.Login_Register);
    } else {
      List<Accounts> accs = await _hiveDb.getAllAccounts();
      yield state.update(accountScreen: AccountScreen.Accounts, accounts: accs);
    }
  }

  Stream<AccountState> _yieldError(String errorMessage) async* {
    yield state.update(
        accountStatus: AccountStatus.Error, errorMessage: errorMessage);
    await Future.delayed(Duration(seconds: 3));
    yield state.update(accountStatus: AccountStatus.Normal, errorMessage: '');
  }

  @override
  Future<void> close() async {
    await _hiveDb.closeBox();
    return super.close();
  }
}
