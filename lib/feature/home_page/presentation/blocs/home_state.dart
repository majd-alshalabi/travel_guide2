part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetAllActivityLoading extends HomeState {}

class GetAllActivityLoaded extends HomeState {}

class GetAllActivityError extends HomeState {}

class GetAllRegionLoading extends HomeState {}

class GetAllRegionLoaded extends HomeState {}

class GetAllRegionError extends HomeState {}

class GetTopRatedLoading extends HomeState {}

class GetTopRatedLoaded extends HomeState {}

class GetTopRatedError extends HomeState {}

class GetNearByLoading extends HomeState {}

class GetNearByLoaded extends HomeState {}

class GetNearByError extends HomeState {}
