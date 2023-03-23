import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_rick_and_morty/core/error/failure.dart';
import 'package:the_rick_and_morty/feature/presentation/bloc/search_bloc.dart/search_event.dart';
import 'package:the_rick_and_morty/feature/presentation/bloc/search_bloc.dart/search_state.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/usecases/search_person.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  Stream<PersonSearchState> mapEventState(PersonSearchEvent event) async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: personQuery));

    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
