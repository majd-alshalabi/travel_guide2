import 'package:dartz/dartz.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/get_activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/book_mark_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/get_list_of_user.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/rate_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/regions_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/wether_api.dart';

abstract class IHomeRepository {
  Future<Either<String, GetActivityResponseModel?>> getAllActivity(
      GetActivityParamsModel params);
  Future<Either<String, AddRateResponseModel>> rateActivity(
      AddRateParamsModel params);
  Future<Either<String, List<CommentModel>?>> getComment(
      GetCommentParamsModel model);
  Future<Either<String, GetListOfUserResponseModel>> getListOfUser(
      GetListOfUserParamsModel params);
  Future<Either<String, WitherApiModel>> getWitherApi(WitherApiParams params);
  Future<Either<String, GetTopRatedResponseModel>> getTopRatedUseCase();
  Future<Either<String, ToggleBookMarkResponseModel>> toggleBookMark(
      ToggleBookMarkParamsModel params);
  Future<Either<String, GetNearbyActivityResponseModel>> getBookMarked();
  Future<Either<String, GetNearbyActivityResponseModel>> getNearbyLocation(
      GetNearbyActivityParamsModel params);
  Future<Either<String, AddCommentResponseModel>> addCommentModel(
      AddCommentParamsModel params);
  Future<Either<String, AddGuideRateResponseModel>> rateGuide(
      AddGuideRateParamsModel params);
  Future<Either<String, TopGuideResponseModel>> getTopGuide();
  Future<Either<String, GetRegionResponseModel>> getAllRegion();
}
