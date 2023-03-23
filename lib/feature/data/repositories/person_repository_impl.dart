import 'package:dartz/dartz.dart';
import 'package:the_rick_and_morty/core/error/excaption.dart';
import 'package:the_rick_and_morty/core/error/failure.dart';
import 'package:the_rick_and_morty/core/platform/network_info.dart';
import 'package:the_rick_and_morty/feature/data/datasources/person_local_data_source.dart';
import 'package:the_rick_and_morty/feature/data/datasources/person_remote_data_source.dart';
import 'package:the_rick_and_morty/feature/domain/entities/person_entity.dart';
import '../../domain/repositories/person_repository.dart';
import '../models/person_model.dart';

class PersonRepositoryImpl extends PersonRepository {
  final PersonRemoteDataSource remoteDataSorce;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSorce,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return remoteDataSorce.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSorce.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personToCache(remotePerson);
        return Right(remotePerson);
      } on ServerExcaption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheExcaptions {
        return Left(CacheFailure());
      }
    }
  }
}
