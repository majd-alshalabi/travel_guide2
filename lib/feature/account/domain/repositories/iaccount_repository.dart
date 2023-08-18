import 'package:dartz/dartz.dart';
import 'package:travel_guide/feature/account/data/models/local/my_identity_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/log_out_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/register_model.dart';

abstract class IAccountRepository {
  Future<Either<String, MyIdentity?>> getMyIdentity();
  Future<Either<String, bool>> saveMyIdentity(MyIdentity identity);

  Future<Either<String, bool>> deleteMyIdentity();
  Future<Either<String, RegisterResponseModel>> register(
    RegisterParamsModel model,
  );
  Future<Either<String, LoginResponseModel>> login(
    LoginParamsModel model,
  );
  Future<Either<String, LogOutModel>> logOut();
}
