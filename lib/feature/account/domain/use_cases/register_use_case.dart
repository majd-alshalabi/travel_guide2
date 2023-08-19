import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/account/data/models/local/my_identity_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/register_model.dart';
import 'package:travel_guide/feature/account/data/repositories/account_repositories.dart';
import 'package:travel_guide/feature/account/domain/use_cases/save_my_identity_use_case.dart';

class RegisterUseCase
    extends UseCase<RegisterResponseModel, RegisterParamsModel> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, RegisterResponseModel>> call(
    RegisterParamsModel params,
  ) async {
    final res = await repository.register(params);
    res.fold((l) => null, (r) async {
      AppSettings().identity = MyIdentity(
        phoneNumber: params.number,
        name: params.name,
        email: params.email,
        token: r.accessToken,
        guide: UserType.user,
        serverId: r.id,
      );
      if (AppSettings().identity != null) {
        await SaveMyIdentityUseCase().call(AppSettings().identity!);
      }
    });
    return res;
  }
}
