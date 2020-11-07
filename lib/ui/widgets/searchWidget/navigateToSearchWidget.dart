import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';

class NavigateToSearchScreenWidget {
  static navigate({@required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<PeopleBloc>(context),
          child: BlocProvider.value(
            value: BlocProvider.of<ProfileBloc>(context),
            child: BlocBuilder<ProfileBloc, ProfileStates>(
              builder: (context, profileStates) {
                return BlocBuilder<PeopleBloc, PeopleStates>(
                  builder: (context, peopleState) {
                    return BlocProvider(
                      create: (_) => SearchCubit()
                        ..loadAllUsers(allUsers: peopleState.allUsers),
                      child: BlocBuilder<SearchCubit, SearchStates>(
                        builder: (context, searchState) {
                          return SearchScreen(searchStates: searchState);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
