import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

class HomeScreenStates {
  final List<DisplayMessageModel> conversations;
  HomeScreenStates({@required this.conversations});

  static HomeScreenStates initial() {
    return HomeScreenStates(conversations: null);
  }

  HomeScreenStates update({
    List<DisplayMessageModel> conversations,
  }) {
    return HomeScreenStates(conversations: conversations ?? this.conversations);
  }
}
