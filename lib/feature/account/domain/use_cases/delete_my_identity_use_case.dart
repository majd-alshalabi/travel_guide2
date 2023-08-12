import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/account/data/repositories/account_repositories.dart';

class DeleteMyIdentityUseCase extends UseCase<bool, NoParams> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, bool>> call(NoParams params) async {
    return await repository.deleteMyIdentity();
  }
}
