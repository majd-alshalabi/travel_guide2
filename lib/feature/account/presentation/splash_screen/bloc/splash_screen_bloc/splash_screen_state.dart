part of 'splash_screen_cubit.dart';

@immutable
abstract class SplashScreenState {}

class SplashScreenInitial extends SplashScreenState {}

class SplashScreenLoading extends SplashScreenState {}

class SplashScreenLoaded extends SplashScreenState {
  final ToWhereShouldINavigateFromSplash toWhere;

  SplashScreenLoaded({required this.toWhere});
}

class SplashScreenError extends SplashScreenState {}
