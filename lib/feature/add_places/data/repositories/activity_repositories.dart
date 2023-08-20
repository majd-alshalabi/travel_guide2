import 'package:dartz/dartz.dart';
import 'package:travel_guide/feature/add_places/data/data_source/remote/activity_remote_data_source.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/city_models.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/get_activity_model.dart';
import 'package:travel_guide/feature/add_places/domain/repositories/iacctivity_repository.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';

class ActivityRepositories implements IActivityRepository {
  final ActivityRemoteDataSource accountRemoteDataSource =
      ActivityRemoteDataSource();
  @override
  Future<Either<String, AddActivityResponseModel>> addActivity(
      AddActivityParamsModel paramsModel) async {
    try {
      final AddActivityResponseModel res =
          await accountRemoteDataSource.addActivity(paramsModel);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, GetActivityResponseModel>> getAllActivity(
      GetActivityParamsModel params) async {
    try {
      final GetActivityResponseModel res =
          await accountRemoteDataSource.getActivity(params);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  Future<Either<String, GetAllCityResponseModel>> getAllCity() async {
    try {
      final GetAllCityResponseModel res =
          await accountRemoteDataSource.getAllCities();
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, AddCityResponseModel>> addCity(
      AddCityParamsModel params) async {
    try {
      final AddCityResponseModel res =
          await accountRemoteDataSource.addCity(params);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, GetAllRegionResponseModel>> getRegion(
      GetRegionParamsModel params) async {
    try {
      final GetAllRegionResponseModel res =
          await accountRemoteDataSource.getRegion(params);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }

  @override
  Future<Either<String, AddRegionResponseModel>> addRegion(
      AddRegionParamsModel params) async {
    try {
      final AddRegionResponseModel res =
          await accountRemoteDataSource.addRegion(params);
      return Right(res);
    } catch (e) {
      return const Left("Error while updating fcm token");
    }
  }
}
