import 'package:dartz/dartz.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/get_activity_model.dart';
import 'package:travel_guide/feature/home_page/data/data_sources/local/home_local_data_source.dart';
import 'package:travel_guide/feature/home_page/data/data_sources/remote/home_remote_data_source.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/book_mark_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/get_list_of_user.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/rate_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/regions_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/wether_api.dart';
import 'package:travel_guide/feature/home_page/domain/repositories/ihome_repository.dart';

class HomeRepositories implements IHomeRepository {
  final HomeRemoteDataSource accountRemoteDataSource = HomeRemoteDataSource();
  final HomeLocalDataSource accountLocalDataSource = HomeLocalDataSource();

  @override
  Future<Either<String, GetActivityResponseModel>> getAllActivity(
      GetActivityParamsModel params) async {
    final GetActivityResponseModel res =
        await accountRemoteDataSource.getActivity(params);
    return Right(res);
  }

  @override
  Future<Either<String, GetRegionResponseModel>> getAllRegion() async {
    try {
      final GetRegionResponseModel res =
          await accountRemoteDataSource.getAllRegion();
      return Right(res);
    } catch (e) {
      print(e);
      print("d2asfga2sdg");
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, WitherApiModel>> getWitherApi(
      WitherApiParams params) async {
    final WitherApiModel res =
        await accountRemoteDataSource.getWitherApi(params);
    return Right(res);
  }

  @override
  Future<Either<String, GetNearbyActivityResponseModel>> getBookMarked() async {
    try {
      final GetNearbyActivityResponseModel res =
          await accountRemoteDataSource.getAllBookMarked();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, GetNearbyActivityResponseModel>> getNearbyLocation(
      GetNearbyActivityParamsModel params) async {
    try {
      final GetNearbyActivityResponseModel res =
          await accountRemoteDataSource.getNearbyLocation(params);
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
  Future<Either<String, GetNearbyActivityResponseModel>> getActivityInRegion(
      GetActivityInRegionParamsModel params) async {
    try {
      final GetNearbyActivityResponseModel res =
          await accountRemoteDataSource.getActivityInRegion(params);
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
  Future<Either<String, GetListOfUserResponseModel>> getListOfUser(
      GetListOfUserParamsModel params) async {
    try {
      final GetListOfUserResponseModel res =
          await accountRemoteDataSource.getListOfUser(params);
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

  @override
  Future<Either<String, List<CommentModel>?>> getComment(
      GetCommentParamsModel model) async {
    final List<CommentModel>? res =
        await accountRemoteDataSource.getAllComment(model);
    return Right(res);
  }
}
