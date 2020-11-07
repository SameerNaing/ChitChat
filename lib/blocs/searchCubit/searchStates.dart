import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

class SearchStates extends Equatable {
  final List<DisplayUserModel> allUsers;
  final List<DisplayUserModel> searchedUsers;

  SearchStates({
    @required this.allUsers,
    @required this.searchedUsers,
  });

  static SearchStates initial() {
    return SearchStates(
      allUsers: [],
      searchedUsers: [],
    );
  }

  SearchStates update({
    List<DisplayUserModel> allUsers,
    List<DisplayUserModel> searchedUsers,
  }) {
    return SearchStates(
      allUsers: allUsers ?? this.allUsers,
      searchedUsers: searchedUsers ?? this.searchedUsers,
    );
  }

  @override
  List<Object> get props => [
        allUsers,
        searchedUsers,
      ];
}
