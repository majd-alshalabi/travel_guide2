import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/get_list_of_user.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class GetListOfUser
    extends UseCase<GetListOfUserResponseModel, GetListOfUserParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetListOfUserResponseModel>> call(
      GetListOfUserParamsModel params) async {
    return await repository.getListOfUser(params);
  }
}
