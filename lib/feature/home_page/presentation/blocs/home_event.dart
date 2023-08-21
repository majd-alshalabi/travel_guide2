part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetAllActivityEvent extends HomeEvent {}

class GetAllRegionEvent extends HomeEvent {}

class GetTopRatedActivityEvent extends HomeEvent {}

class GetNearbyActivityEvent extends HomeEvent {}
