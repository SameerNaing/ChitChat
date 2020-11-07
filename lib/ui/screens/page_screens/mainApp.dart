import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/blocs/blocs.dart';
import 'package:chit_chat/ui/ui.dart';

class MainApp extends StatelessWidget {
  final AccountState accountState;
  MainApp({Key key, @required this.accountState}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PeopleBloc>(
            create: (context) =>
                PeopleBloc(currentUserId: accountState.userModel)
                  ..add(LoadPeople())),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(currentUser: accountState.userModel)
            ..add(LoadCurrentUserProfile()),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (context) =>
              HomeScreenBloc(currentUserId: accountState.userModel.uid)
                ..add(LoadConversations()),
        ),
      ],
      child: BlocBuilder<PeopleBloc, PeopleStates>(
        builder: (context, peopleState) {
          return BlocBuilder<ProfileBloc, ProfileStates>(
            builder: (context, profileState) {
              return BlocBuilder<HomeScreenBloc, HomeScreenStates>(
                builder: (context, homeScreenState) {
                  return PageViewScreen(
                    peopleStates: peopleState,
                    profileStates: profileState,
                    homeScreenStates: homeScreenState,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
