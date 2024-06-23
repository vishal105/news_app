import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';

/// Abstract class representing a use case.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
