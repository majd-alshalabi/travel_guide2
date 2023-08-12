import 'package:dartz/dartz.dart';

abstract class UseCase<DataEntity, Params> {
  Future<Either<String, DataEntity>> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams {}
