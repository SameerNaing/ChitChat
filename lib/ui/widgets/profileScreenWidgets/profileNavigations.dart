import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/models/models.dart';
import 'package:chit_chat/blocs/blocs.dart';

class ProfileNavigations {
  static toImagesScreen({
    @required BuildContext context,
    @required UserModel user,
    @required bool currentUser,
  }) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ProfileBloc>(context),
        child: ImagesScreen(
          user: currentUser ? null : user,
          currentUser: currentUser,
        ),
      ),
    ));
  }

  static toProfileScreen({@required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<PeopleBloc>(context),
          child: BlocProvider.value(
            value: BlocProvider.of<ProfileBloc>(context),
            child: BlocBuilder<PeopleBloc, PeopleStates>(
              builder: (context, peopleState) {
                return BlocBuilder<ProfileBloc, ProfileStates>(
                  builder: (context, profileState) => ProfileScreen(
                    profileStates: profileState,
                    relation: peopleState.relation,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  static toMoreScreen({@required BuildContext context}) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BlocProvider.value(
              value: BlocProvider.of<ProfileBloc>(context),
              child: BlocProvider.value(
                value: BlocProvider.of<PeopleBloc>(context),
                child: BlocProvider.value(
                    value: BlocProvider.of<AccountBloc>(context),
                    child: MoreScreenBuilderWidget()),
              ),
            )));
  }

  static toFriendsScreen({@required BuildContext context}) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ProfileBloc>(context),
        child: BlocProvider.value(
          value: BlocProvider.of<PeopleBloc>(context),
          child: BlocBuilder<ProfileBloc, ProfileStates>(
            builder: (context, profileState) {
              return BlocBuilder<PeopleBloc, PeopleStates>(
                builder: (context, peopleState) {
                  return FriendsScreen(peopleStates: peopleState);
                },
              );
            },
          ),
        ),
      ),
    ));
  }

  static toRequestedScreen({@required BuildContext context}) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ProfileBloc>(context),
        child: BlocProvider.value(
          value: BlocProvider.of<PeopleBloc>(context),
          child: BlocBuilder<ProfileBloc, ProfileStates>(
            builder: (context, profileState) {
              return BlocBuilder<PeopleBloc, PeopleStates>(
                builder: (context, peopleState) {
                  return RequestedScreen(peopleStates: peopleState);
                },
              );
            },
          ),
        ),
      ),
    ));
  }
}
