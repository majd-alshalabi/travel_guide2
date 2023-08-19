import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/regions_model.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class GetAllRegionUseCase extends UseCase<GetRegionResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetRegionResponseModel>> call(NoParams params) async {
    return await repository.getAllRegion();
  }
}
