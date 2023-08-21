part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class LogoutLoading extends MainState {}

class LogoutLoaded extends MainState {}

class LogoutError extends MainState {}
