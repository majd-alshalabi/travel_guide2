import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/rate_models.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class AddRateUseCase extends UseCase<AddRateResponseModel, AddRateParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, AddRateResponseModel>> call(
      AddRateParamsModel params) async {
    return await repository.rateActivity(params);
  }
}

class RateGuideUseCase
    extends UseCase<AddGuideRateResponseModel, AddGuideRateParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, AddGuideRateResponseModel>> call(
      AddGuideRateParamsModel params) async {
    return await repository.rateGuide(params);
  }
}
