import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

abstract class HomeScreenEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadConversations extends HomeScreenEvents {}

class ConversationsLoaded extends HomeScreenEvents {
  final List<DisplayMessageModel> displayMessageModel;
  ConversationsLoaded({@required this.displayMessageModel});
  @override
  List<Object> get props => [displayMessageModel];
}
