import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/repository/repository.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvents, HomeScreenStates> {
  StreamSubscription _conversationsStreamSub;
  MessageFireStore _singleMessageFireStore = MessageFireStore();
  String currentUserId;
  HomeScreenBloc({@required this.currentUserId})
      : super(HomeScreenStates.initial());
  @override
  Stream<HomeScreenStates> mapEventToState(HomeScreenEvents event) async* {
    if (event is LoadConversations) {
      yield* _mapLoadConversationsToState();
    } else if (event is ConversationsLoaded) {
      yield* _mapConversationsLoadedToState(event);
    }
  }

  Stream<HomeScreenStates> _mapLoadConversationsToState() async* {
    _conversationsStreamSub?.cancel();
    _conversationsStreamSub = _singleMessageFireStore
        .loadDisplayMessages(currentUserId)
        .listen((displayMessageModel) =>
            add(ConversationsLoaded(displayMessageModel: displayMessageModel)));
  }

  Stream<HomeScreenStates> _mapConversationsLoadedToState(
      ConversationsLoaded event) async* {
    List<DisplayMessageModel> displayMessages = [];
    for (DisplayMessageModel messages in event.displayMessageModel) {
      if (messages.isNew) {
        displayMessages.insert(0, messages);
      } else {
        displayMessages.add(messages);
      }
    }
    yield state.update(conversations: displayMessages);
  }

  @override
  Future<void> close() {
    _conversationsStreamSub.cancel();
    return super.close();
  }
}
