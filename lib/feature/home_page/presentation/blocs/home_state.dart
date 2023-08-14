part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetAllActivityLoading extends HomeState {}

class GetAllActivityLoaded extends HomeState {}

class GetAllActivityError extends HomeState {}
