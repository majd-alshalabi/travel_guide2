import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/account/data/models/remote/log_out_model.dart';
import 'package:travel_guide/feature/account/data/repositories/account_repositories.dart';
import 'package:travel_guide/feature/account/domain/use_cases/delete_my_identity_use_case.dart';

class LogOutUseCase extends UseCase<LogOutModel, NoParams> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, LogOutModel>> call(NoParams params) async {
    final res = await repository.logOut();
    res.fold(
      (l) => null,
      (r) async {
        await DeleteMyIdentityUseCase().call(NoParams());
        AppSettings().identity = null;
      },
    );
    return res;
  }
}
