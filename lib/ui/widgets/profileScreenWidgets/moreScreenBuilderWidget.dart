import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class MoreScreenBuilderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileStates>(
      builder: (context, profileStates) {
        return BlocBuilder<PeopleBloc, PeopleStates>(
          builder: (context, peopleStates) {
            return BlocBuilder<AccountBloc, AccountState>(
              builder: (context, accountStates) {
                return MoreScreen(
                    profileStates: profileStates, peopleStates: peopleStates);
              },
            );
          },
        );
      },
    );
  }
}
