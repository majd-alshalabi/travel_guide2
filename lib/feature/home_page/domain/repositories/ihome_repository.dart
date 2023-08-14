import 'package:dartz/dartz.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/book_mark_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/rate_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';

abstract class IHomeRepository {
  Future<Either<String, GetActivityResponseModel?>> getAllActivity();
  Future<Either<String, AddRateResponseModel>> rateActivity(
      AddRateParamsModel params);
  Future<Either<String, GetTopRatedResponseModel>> getTopRatedUseCase();
  Future<Either<String, ToggleBookMarkResponseModel>> toggleBookMark(
      ToggleBookMarkParamsModel params);
  Future<Either<String, GetActivityResponseModel>> getBookMarked();
  Future<Either<String, GetActivityResponseModel>> getNearbyLocation();
  Future<Either<String, AddCommentResponseModel>> addCommentModel(
      AddCommentParamsModel params);
  Future<Either<String, AddGuideRateResponseModel>> rateGuide(
      AddGuideRateParamsModel params);
  Future<Either<String, TopGuideResponseModel>> getTopGuide();
}
