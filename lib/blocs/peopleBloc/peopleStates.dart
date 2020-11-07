import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

enum PeoplePageStatus { Loading, Loaded, Error }
enum UserRelation { None, Friend, RequestSend, RequestGet, CurrentUser }

class PeopleStates extends Equatable {
  final List<DisplayUserModel> friends;
  final List<DisplayUserModel> getRequests;
  final List<DisplayUserModel> sendRequests;
  final List<DisplayUserModel> allUsers;
  final List<DisplayUserModel> userToShow; //[20 only]
  final PeoplePageStatus peoplePageStatus;
  final String errorMessage;

  final UserRelation relation;

  PeopleStates({
    @required this.friends,
    @required this.getRequests,
    @required this.sendRequests,
    @required this.allUsers,
    @required this.userToShow,
    @required this.peoplePageStatus,
    @required this.errorMessage,
    @required this.relation,
  });

  static PeopleStates initial() {
    return PeopleStates(
      friends: [],
      getRequests: [],
      sendRequests: [],
      allUsers: [],
      userToShow: [],
      peoplePageStatus: PeoplePageStatus.Loading,
      errorMessage: null,
      relation: null,
    );
  }

  PeopleStates update({
    List<DisplayUserModel> friends,
    List<DisplayUserModel> getRequests,
    List<DisplayUserModel> sendRequests,
    List<DisplayUserModel> allUsers,
    List<DisplayUserModel> userToShow,
    PeoplePageStatus peoplePageStatus,
    String errorMessage,
    UserRelation relation,
  }) {
    return PeopleStates(
      friends: friends ?? this.friends,
      getRequests: getRequests ?? this.getRequests,
      sendRequests: sendRequests ?? this.sendRequests,
      allUsers: allUsers ?? this.allUsers,
      userToShow: userToShow ?? this.userToShow,
      peoplePageStatus: peoplePageStatus ?? this.peoplePageStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      relation: relation ?? this.relation,
    );
  }

  @override
  List<Object> get props => [
        friends,
        getRequests,
        sendRequests,
        allUsers,
        userToShow,
        peoplePageStatus,
        errorMessage,
        relation,
      ];
}
