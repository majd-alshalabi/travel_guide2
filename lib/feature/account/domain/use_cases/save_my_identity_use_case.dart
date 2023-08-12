import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/account/data/models/local/my_identity_model.dart';
import 'package:travel_guide/feature/account/data/repositories/account_repositories.dart';

class SaveMyIdentityUseCase extends UseCase<bool, MyIdentity> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, bool>> call(MyIdentity params) async {
    return await repository.saveMyIdentity(params);
  }
}
