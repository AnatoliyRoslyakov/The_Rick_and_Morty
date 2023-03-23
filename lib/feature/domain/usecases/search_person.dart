// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:the_rick_and_morty/core/error/usecases/usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';
import '../repositories/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepositoty;
  SearchPerson({
    required this.personRepositoty,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async {
    return await personRepositoty.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;
  SearchPersonParams({required this.query});
  @override
  List<Object?> get props => [query];
}
