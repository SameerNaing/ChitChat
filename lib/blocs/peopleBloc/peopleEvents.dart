import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

abstract class PeopleEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateFriends extends PeopleEvents {
  final List<DisplayUserModel> friends;
  UpdateFriends({@required this.friends});
  @override
  List<Object> get props => [friends];
}

class UpdateSendRequest extends PeopleEvents {
  final List<DisplayUserModel> sendRequests;
  UpdateSendRequest({@required this.sendRequests});
  @override
  List<Object> get props => [sendRequests];
}

class UpdateGetRequest extends PeopleEvents {
  final List<DisplayUserModel> getRequests;
  UpdateGetRequest({@required this.getRequests});
  @override
  List<Object> get props => [getRequests];
}

class UpdateAllUsers extends PeopleEvents {
  final List<DisplayUserModel> otherUsers;
  UpdateAllUsers({@required this.otherUsers});
  @override
  List<Object> get props => [otherUsers];
}

class UpdateUserToShow extends PeopleEvents {}

class LoadPeople extends PeopleEvents {}

class SendRequest extends PeopleEvents {
  final DisplayUserModel toUser;
  SendRequest({@required this.toUser});
  @override
  List<Object> get props => [toUser];
}

class AcceptGetRequest extends PeopleEvents {
  final DisplayUserModel fromUser;
  AcceptGetRequest({@required this.fromUser});
  @override
  List<Object> get props => [fromUser];
}

class CancleSendRequest extends PeopleEvents {
  final DisplayUserModel toUser;
  CancleSendRequest({@required this.toUser});
  @override
  List<Object> get props => [toUser];
}

class CancleGetRequest extends PeopleEvents {
  final DisplayUserModel fromUser;
  CancleGetRequest({@required this.fromUser});
  @override
  List<Object> get props => [fromUser];
}

class RemoveFromFriends extends PeopleEvents {
  final DisplayUserModel user;
  RemoveFromFriends({@required this.user});
  @override
  List<Object> get props => [user];
}

class PeoplePageError extends PeopleEvents {}

class CheckUserRelation extends PeopleEvents {
  final DisplayUserModel requestedUser;
  CheckUserRelation({@required this.requestedUser});
  @override
  List<Object> get props => [requestedUser];
}
