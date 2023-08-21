import 'package:dartz/dartz.dart';
import 'package:travel_guide/feature/account/data/data_sources/local/account_local_data_source.dart';
import 'package:travel_guide/feature/account/data/data_sources/remote/account_remote_data_source.dart';
import 'package:travel_guide/feature/account/data/models/local/my_identity_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/change_password_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/get_guide_models.dart';
import 'package:travel_guide/feature/account/data/models/remote/log_out_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/register_model.dart';
import 'package:travel_guide/feature/account/domain/repositories/iaccount_repository.dart';

class AccountRepositories implements IAccountRepository {
  final AccountRemoteDataSource accountRemoteDataSource =
      AccountRemoteDataSource();
  final AccountLocalDataSource accountLocalDataSource =
      AccountLocalDataSource();

  @override
  Future<Either<String, RegisterResponseModel>> register(
    RegisterParamsModel model,
  ) async {
    try {
      final RegisterResponseModel res = await accountRemoteDataSource.register(
        model,
      );
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, LogOutModel>> logOut() async {
    try {
      final LogOutModel res = await accountRemoteDataSource.logout();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, LoginResponseModel>> login(
    LoginParamsModel model,
  ) async {
    try {
      final LoginResponseModel res = await accountRemoteDataSource.login(
        model,
      );
      return Right(res);
    } catch (e) {
      return const Left("Error while logging in");
    }
  }

  @override
  Future<Either<String, ChangePasswordResponseModel>> changePassword(
    ChangePasswordParamsModel model,
  ) async {
    try {
      final ChangePasswordResponseModel res =
          await accountRemoteDataSource.changePassword(
        model,
      );
      return Right(res);
    } catch (e) {
      return const Left("Error while logging in");
    }
  }

  @override
  Future<Either<String, MyIdentity?>> getMyIdentity() async {
    try {
      final MyIdentity? res = await accountLocalDataSource.getMyIdentity();

      return Right(res);
    } catch (e) {
      return const Left("Error while getting identity");
    }
  }

  @override
  Future<Either<String, GetAllGuideResponseModel>> getAllGuide() async {
    try {
      final GetAllGuideResponseModel res =
          await accountRemoteDataSource.getAllGuide();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, bool>> saveMyIdentity(MyIdentity identity) async {
    try {
      final bool res = await accountLocalDataSource.saveMyIdentity(identity);

      return Right(res);
    } catch (e) {
      return const Left("Error while getting identity");
    }
  }

  @override
  Future<Either<String, bool>> deleteMyIdentity() async {
    try {
      final bool res = await accountLocalDataSource.deleteMyIdentity();

      return Right(res);
    } catch (e) {
      return const Left("Error while getting identity");
    }
  }
}
