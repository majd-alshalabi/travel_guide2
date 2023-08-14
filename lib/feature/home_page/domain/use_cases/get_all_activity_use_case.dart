import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class GetAllActivityUseCase
    extends UseCase<GetActivityResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetActivityResponseModel>> call(NoParams params) async {
    return await repository.getAllActivity();
  }
}

class ShowTopRatedUseCase extends UseCase<GetTopRatedResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetTopRatedResponseModel>> call(NoParams params) async {
    return await repository.getTopRatedUseCase();
  }
}

class GetBookMarked extends UseCase<GetActivityResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetActivityResponseModel>> call(NoParams params) async {
    return await repository.getBookMarked();
  }
}

class GetNearbyLocationUseCase
    extends UseCase<GetActivityResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, GetActivityResponseModel>> call(NoParams params) async {
    return await repository.getNearbyLocation();
  }
}

class GetTopGuidesUseCase extends UseCase<TopGuideResponseModel, NoParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, TopGuideResponseModel>> call(NoParams params) async {
    return await repository.getTopGuide();
  }
}
