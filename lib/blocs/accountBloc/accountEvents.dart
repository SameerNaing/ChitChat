import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Authenticate extends AccountEvent {}

class SignOut extends AccountEvent {}

class Authenticated extends AccountEvent {
  final String uid;
  Authenticated({@required this.uid});
  List<Object> get props => [uid];
}

class Login extends AccountEvent {
  final String email;
  final String password;

  Login({@required this.email, @required this.password});
}

class Register extends AccountEvent {
  final String username;
  final String password;
  final String email;
  Register({
    @required this.username,
    @required this.password,
    @required this.email,
  });
}

class AddInfo extends AccountEvent {
  final String bio;
  final String relationStatus;
  final String location;
  AddInfo({this.bio, this.relationStatus, this.location});
}

class UploadProfileImage extends AccountEvent {
  final File imageFile;
  UploadProfileImage({this.imageFile});
}

class RemoveAccount extends AccountEvent {
  final int index;
  RemoveAccount({@required this.index});
}

class ShowLoginRegisterPage extends AccountEvent {}
