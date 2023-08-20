import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/city_models.dart';
import 'package:travel_guide/feature/add_places/data/repositories/activity_repositories.dart';

class AddCityUseCase extends UseCase<AddCityResponseModel, AddCityParamsModel> {
  ActivityRepositories repository = ActivityRepositories();

  @override
  Future<Either<String, AddCityResponseModel>> call(
    AddCityParamsModel params,
  ) async {
    return repository.addCity(params);
  }
}
