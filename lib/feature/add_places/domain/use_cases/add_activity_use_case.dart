import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/city_models.dart';
import 'package:travel_guide/feature/add_places/data/repositories/activity_repositories.dart';


class AddActivityUseCase
    extends UseCase<AddActivityResponseModel, AddActivityParamsModel> {
  ActivityRepositories repository = ActivityRepositories();

  @override
  Future<Either<String, AddActivityResponseModel>> call(
    AddActivityParamsModel params,
  ) async {
    return repository.addActivity(params);
  }
}
class GetAllCityUseCase extends UseCase<GetAllCityResponseModel, NoParams> {
  ActivityRepositories repository = ActivityRepositories();

  @override
  Future<Either<String, GetAllCityResponseModel>> call(
      NoParams params,
      ) async {
    return repository.getAllCity();
  }
}
