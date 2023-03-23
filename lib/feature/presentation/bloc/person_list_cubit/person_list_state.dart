// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:the_rick_and_morty/feature/domain/entities/person_entity.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  PersonLoading({required this.oldPersonsList, this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPersonsList];
}

class PersonLoaded extends PersonState {
  final List<PersonEntity> personsList;
  PersonLoaded({required this.personsList});

  @override
  List<Object?> get props => [personsList];
}

class PersonError extends PersonState {
  final String message;
  PersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
