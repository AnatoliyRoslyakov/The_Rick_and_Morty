import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:the_rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:the_rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

import 'person_card_widget.dart';

class PersonsList extends StatelessWidget {
  const PersonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      List<PersonEntity> persons = [];
      if (state is PersonLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is PersonLoaded) {
        persons = state.personsList;
      }
      return ListView.separated(
          itemBuilder: (context, index) {
            return PersonCard(person: persons[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
          itemCount: persons.length);
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
