part of 'activity_cubit.dart';

@immutable
abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class GetAllCityLoading extends ActivityState {}

class GetAllCityLoaded extends ActivityState {
  final List<CityModel> cities;

  GetAllCityLoaded(this.cities);
}

class GetAllCityError extends ActivityState {}

class GetAllRegionLoading extends ActivityState {}

class GetAllRegionLoaded extends ActivityState {
  final List<RegionModel> regions;

  GetAllRegionLoaded(this.regions);
}

class GetAllRegionError extends ActivityState {
  GetAllRegionError();
}

class AddCityLoading extends ActivityState {}

class AddCityLoaded extends ActivityState {
  final CityModel? model;

  AddCityLoaded(this.model);
}

class AddCityError extends ActivityState {}

class AddRegionLoading extends ActivityState {}

class AddRegionLoaded extends ActivityState {
  final RegionModel? model;
  final int cityId;

  AddRegionLoaded(this.model, this.cityId);
}

class AddRegionError extends ActivityState {}

class AddActivityError extends ActivityState {}

class AddActivityLoaded extends ActivityState {}

class AddActivityLoading extends ActivityState {}
