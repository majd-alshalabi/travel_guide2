part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class LogoutLoading extends MainState {}

class LogoutLoaded extends MainState {}

class LogoutError extends MainState {}

class GetLocalizationLoading extends MainState {}

class GetLocalizationLoaded extends MainState {}

class LocalizationLoading extends MainState {}

class LocalizationLoaded extends MainState {
  final String languageName;

  LocalizationLoaded({required this.languageName});
}
