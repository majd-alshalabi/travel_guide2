import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/get_activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class GetAllActivityUseCase
    extends UseCase<GetActivityResponseModel, GetActivityParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetActivityResponseModel>> call(
      GetActivityParamsModel params) async {
    return await repository.getAllActivity(params);
  }
}

class ShowTopRatedUseCase extends UseCase<GetTopRatedResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetTopRatedResponseModel>> call(NoParams params) async {
    final res = await repository.getTopRatedUseCase();

    return res;
  }
}

class GetActivityInRegion extends UseCase<GetNearbyActivityResponseModel,
    GetActivityInRegionParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetNearbyActivityResponseModel>> call(
      GetActivityInRegionParamsModel params) async {
    final res = await repository.getActivityInRegion(params);

    return res;
  }
}

class GetBookMarked extends UseCase<GetNearbyActivityResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetNearbyActivityResponseModel>> call(
      NoParams params) async {
    return await repository.getBookMarked();
  }
}

class GetNearbyLocationUseCase extends UseCase<GetNearbyActivityResponseModel,
    GetNearbyActivityParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetNearbyActivityResponseModel>> call(
      GetNearbyActivityParamsModel params) async {
    final res = await repository.getNearbyLocation(params);
    res.fold((l) => null, (r) {
      AppSettings().controller.add(
            NearByLocationEvent(r.data ?? []),
          );
    });
    return res;
  }
}

class GetTopGuidesUseCase extends UseCase<TopGuideResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, TopGuideResponseModel>> call(NoParams params) async {
    return await repository.getTopGuide();
  }
}
