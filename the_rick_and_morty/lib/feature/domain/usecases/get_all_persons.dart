import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../../core/error/usecases/usecase.dart';
import '../entities/person_entity.dart';
import '../repositories/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepositoty;
  GetAllPersons({
    required this.personRepositoty,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepositoty.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;
  PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
