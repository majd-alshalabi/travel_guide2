import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/city_models.dart';
import 'package:travel_guide/feature/add_places/data/repositories/activity_repositories.dart';
class AddRegionUseCase
    extends UseCase<AddRegionResponseModel, AddRegionParamsModel> {
  ActivityRepositories repository = ActivityRepositories();

  @override
  Future<Either<String, AddRegionResponseModel>> call(
    AddRegionParamsModel params,
  ) async {
    return repository.addRegion(params);
  }
}
class GetRegionUseCase
    extends UseCase<GetAllRegionResponseModel, GetRegionParamsModel> {
  ActivityRepositories repository = ActivityRepositories();

  @override
  Future<Either<String, GetAllRegionResponseModel>> call(
      GetRegionParamsModel params,
      ) async {
    return repository.getRegion(params);
  }
}