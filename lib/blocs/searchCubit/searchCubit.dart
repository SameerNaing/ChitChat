import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStates.initial());

  void loadAllUsers({@required List<DisplayUserModel> allUsers}) {
    emit(state.update(allUsers: allUsers));
  }

  void search(String name) {
    List<DisplayUserModel> searchedUsers = state.allUsers
        .where((e) => e.name.toLowerCase().startsWith(name))
        .toList();

    emit(state.update(searchedUsers: searchedUsers));
  }

  void clearList() {
    emit(state.update(searchedUsers: []));
  }
}
