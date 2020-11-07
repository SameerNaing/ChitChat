import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/repository/repository.dart';

class PeopleBloc extends Bloc<PeopleEvents, PeopleStates> {
  StreamSubscription _friendsStreamSub;
  StreamSubscription _requestSendStreamSub;
  StreamSubscription _requestGetStreamSub;
  StreamSubscription _allUserStreamSub;
  PeopleFireStore _peopleFireStore;
  AccountFireStore _accountFireStore = AccountFireStore();
  FirebaseAuthService _auth = FirebaseAuthService();
  MessageFireStore _messageFireStore = MessageFireStore();
  String _userId;

  PeopleBloc({@required UserModel currentUserId})
      : super(PeopleStates.initial()) {
    _peopleFireStore = PeopleFireStore(currentUser: currentUserId);
    _userId = currentUserId.uid;
  }

  @override
  Stream<PeopleStates> mapEventToState(PeopleEvents event) async* {
    if (event is LoadPeople) {
      yield* _mapLoadPeopleToState();
    } else if (event is UpdateFriends) {
      yield* _mapUpdateFriendsToState(event.friends);
    } else if (event is UpdateGetRequest) {
      yield* _mapUpdateGetRequestToState(event.getRequests);
    } else if (event is UpdateSendRequest) {
      yield* _mapUpdateSendRequestToState(event.sendRequests);
    } else if (event is UpdateAllUsers) {
      yield* _mapUpdateAllUsersToState(event.otherUsers);
    } else if (event is UpdateUserToShow) {
      yield* _mapUpdateUserToShowToState();
    } else if (event is SendRequest) {
      yield* _mapSendRequestToState(event);
    } else if (event is AcceptGetRequest) {
      yield* _mapAcceptGetRequestToState(event);
    } else if (event is CancleSendRequest) {
      yield* _mapCancleSendRequestToState(event);
    } else if (event is RemoveFromFriends) {
      yield* _mapRemoveFromFriendsToState(event);
    } else if (event is CancleGetRequest) {
      yield* _mapCancleGetRequestToState(event);
    } else if (event is PeoplePageError) {
      yield* _mapPeoplePageErrorToState();
    } else if (event is CheckUserRelation) {
      yield* _mapCheckUserRelationToState(event.requestedUser);
    }
  }

  Stream<PeopleStates> _mapCheckUserRelationToState(
      DisplayUserModel requestedUser) async* {
    if (state.friends.contains(requestedUser)) {
      yield state.update(relation: UserRelation.Friend);
    } else if (state.getRequests.contains(requestedUser)) {
      yield state.update(relation: UserRelation.RequestGet);
    } else if (state.sendRequests.contains(requestedUser)) {
      yield state.update(relation: UserRelation.RequestSend);
    } else {
      yield state.update(relation: UserRelation.None);
    }
  }

  Stream<PeopleStates> _mapCancleGetRequestToState(
      CancleGetRequest event) async* {
    try {
      yield state.update(
        relation: null,
      );
      await _peopleFireStore.cancleGetRequest(event.fromUser);
      yield state.update(
        relation: UserRelation.None,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<PeopleStates> _mapRemoveFromFriendsToState(
      RemoveFromFriends event) async* {
    try {
      await _peopleFireStore.removeFromFriends(event.user);
      await _messageFireStore.removeMessages(_auth.userId, event.user.uid);
    } catch (e) {
      print(e);
    }
  }

  Stream<PeopleStates> _mapCancleSendRequestToState(
      CancleSendRequest event) async* {
    try {
      yield state.update(
        relation: null,
      );
      await _peopleFireStore.cancleSendRequest(event.toUser);
      yield state.update(
        relation: UserRelation.None,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<PeopleStates> _mapAcceptGetRequestToState(
      AcceptGetRequest event) async* {
    try {
      yield state.update(
        relation: null,
      );
      await _peopleFireStore.acceptGetRequest(event.fromUser);
      yield state.update(
        relation: UserRelation.Friend,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<PeopleStates> _mapSendRequestToState(SendRequest event) async* {
    try {
      yield state.update(
        relation: null,
      );
      await _peopleFireStore.sendRequest(event.toUser);
      yield state.update(
        relation: UserRelation.RequestSend,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<PeopleStates> _mapUpdateAllUsersToState(
      List<DisplayUserModel> otherUsers) async* {
    UserModel currentUser = await _accountFireStore.getUser(_userId);
    DisplayUserModel user = DisplayUserModel(
        name: currentUser.name,
        profilePic: currentUser.profileImage,
        uid: currentUser.uid);
    otherUsers.remove(user);
    yield state.update(allUsers: otherUsers);
  }

  Stream<PeopleStates> _mapUpdateSendRequestToState(
      List<DisplayUserModel> sendRequests) async* {
    yield state.update(sendRequests: sendRequests);
    add(UpdateUserToShow());
  }

  Stream<PeopleStates> _mapUpdateGetRequestToState(
      List<DisplayUserModel> getRequests) async* {
    yield state.update(
        getRequests: getRequests, peoplePageStatus: PeoplePageStatus.Loaded);
    add(UpdateUserToShow());
  }

  Stream<PeopleStates> _mapUpdateFriendsToState(
      List<DisplayUserModel> friends) async* {
    yield state.update(friends: friends);
    add(UpdateUserToShow());
  }

  Stream<PeopleStates> _mapUpdateUserToShowToState() async* {
    List<DisplayUserModel> friends = state.friends;
    List<DisplayUserModel> sendRequests = state.sendRequests;
    List<DisplayUserModel> getRequests = state.getRequests;
    List<DisplayUserModel> allUsers = state.allUsers;

    List<DisplayUserModel> userToShow = List.from(allUsers.where((user) =>
        !friends.contains(user) &&
        !sendRequests.contains(user) &&
        !getRequests.contains(user)));

    if (userToShow.length > 20) {
      yield state.update(userToShow: userToShow.sublist(0, 20));
    } else {
      yield state.update(userToShow: userToShow);
    }
  }

  Stream<PeopleStates> _mapLoadPeopleToState() async* {
    yield state.update(peoplePageStatus: PeoplePageStatus.Loading);
    _friendsStreamSub?.cancel();
    _requestSendStreamSub?.cancel();
    _requestGetStreamSub?.cancel();
    _allUserStreamSub?.cancel();

    _allUserStreamSub = _peopleFireStore.allUsersStream().listen(
          (users) => add(UpdateAllUsers(otherUsers: users)),
          onError: (_) => add(PeoplePageError()),
        );

    _friendsStreamSub = _peopleFireStore.friendsStream().listen(
          (friends) => add(UpdateFriends(friends: friends)),
          onError: (_) => add(PeoplePageError()),
        );

    _requestSendStreamSub = _peopleFireStore.requestSendStream().listen(
          (sendRequests) => add(UpdateSendRequest(sendRequests: sendRequests)),
          onError: (_) => add(PeoplePageError()),
        );

    _requestGetStreamSub = _peopleFireStore.requestGetStream().listen(
          (getRequests) => add(UpdateGetRequest(getRequests: getRequests)),
          onError: (_) => add(PeoplePageError()),
        );
  }

  Stream<PeopleStates> _mapPeoplePageErrorToState() async* {
    yield state.update(
        peoplePageStatus: PeoplePageStatus.Error,
        errorMessage: 'Check your Connection!');
  }

  @override
  Future<void> close() {
    _friendsStreamSub.cancel();
    _requestSendStreamSub.cancel();
    _requestGetStreamSub.cancel();
    _allUserStreamSub.cancel();
    return super.close();
  }
}
