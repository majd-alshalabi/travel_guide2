import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/change_password_model.dart';
import 'package:travel_guide/feature/account/data/repositories/account_repositories.dart';

class ChangePasswordUseCase
    extends UseCase<ChangePasswordResponseModel, ChangePasswordParamsModel> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, ChangePasswordResponseModel>> call(
    ChangePasswordParamsModel params,
  ) async {
    return await repository.changePassword(params);
  }
}
