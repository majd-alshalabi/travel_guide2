import 'package:dartz/dartz.dart';
import 'package:travel_guide/feature/home_page/data/data_sources/local/home_local_data_source.dart';
import 'package:travel_guide/feature/home_page/data/data_sources/remote/home_remote_data_source.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/book_mark_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/rate_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:travel_guide/feature/home_page/domain/repositories/ihome_repository.dart';

class HomeRepositories implements IHomeRepository {
  final HomeRemoteDataSource accountRemoteDataSource = HomeRemoteDataSource();
  final HomeLocalDataSource accountLocalDataSource = HomeLocalDataSource();

  @override
  Future<Either<String, GetActivityResponseModel>> getAllActivity() async {
    try {
      final GetActivityResponseModel res =
          await accountRemoteDataSource.getActivity();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, GetActivityResponseModel>> getBookMarked() async {
    try {
      final GetActivityResponseModel res =
          await accountRemoteDataSource.getAllBookMarked();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, GetActivityResponseModel>> getNearbyLocation() async {
    try {
      final GetActivityResponseModel res =
          await accountRemoteDataSource.getNearbyLocation();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, TopGuideResponseModel>> getTopGuide() async {
    try {
      final TopGuideResponseModel res =
          await accountRemoteDataSource.getTopGuide();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, GetTopRatedResponseModel>> getTopRatedUseCase() async {
    try {
      final GetTopRatedResponseModel res =
          await accountRemoteDataSource.getTopRated();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, AddRateResponseModel>> rateActivity(
      AddRateParamsModel params) async {
    try {
      final AddRateResponseModel res =
          await accountRemoteDataSource.addRate(params);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, AddGuideRateResponseModel>> rateGuide(
      AddGuideRateParamsModel params) async {
    try {
      final AddGuideRateResponseModel res =
          await accountRemoteDataSource.addGuideRate(params);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, ToggleBookMarkResponseModel>> toggleBookMark(
      ToggleBookMarkParamsModel params) async {
    try {
      final ToggleBookMarkResponseModel res =
          await accountRemoteDataSource.toggleBookMark(params);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, AddCommentResponseModel>> addCommentModel(
      AddCommentParamsModel params) async {
    try {
      final AddCommentResponseModel res =
          await accountRemoteDataSource.addComment(params);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }
}
