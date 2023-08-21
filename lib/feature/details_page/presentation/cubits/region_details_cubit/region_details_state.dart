part of 'region_details_cubit.dart';

@immutable
abstract class RegionDetailsState {}

class RegionDetailsInitial extends RegionDetailsState {}

class GetWitherOneDayLoading extends RegionDetailsState {}

class GetWitherOneDayLoaded extends RegionDetailsState {}

class GetWitherOneDayError extends RegionDetailsState {}

class GetWitherFiveDayLoading extends RegionDetailsState {}

class GetWitherFiveDayLoaded extends RegionDetailsState {}

class GetWitherFiveDayError extends RegionDetailsState {}

class GetActivityInRegionLoading extends RegionDetailsState {}

class GetActivityInRegionLoaded extends RegionDetailsState {}

class GetActivityInRegionError extends RegionDetailsState {}
