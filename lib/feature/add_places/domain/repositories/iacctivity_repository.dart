import 'package:dartz/dartz.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/city_models.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/get_activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';

abstract class IActivityRepository {
  Future<Either<String, AddRegionResponseModel>> addRegion(
      AddRegionParamsModel params);
  Future<Either<String, AddCityResponseModel>> addCity(
      AddCityParamsModel params);
  Future<Either<String, AddActivityResponseModel>> addActivity(
      AddActivityParamsModel paramsModel);
  Future<Either<String, GetAllRegionResponseModel>> getRegion(
      GetRegionParamsModel params);
  Future<Either<String, GetActivityResponseModel>> getAllActivity(
      GetActivityParamsModel params);
}
