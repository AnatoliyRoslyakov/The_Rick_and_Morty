import 'package:dartz/dartz.dart';
import 'package:the_rick_and_morty/core/error/failure.dart';

@override
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
