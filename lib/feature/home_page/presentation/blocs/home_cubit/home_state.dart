part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LogOutLoading extends HomeState {}

class LogOutLoaded extends HomeState {}

class LogOutError extends HomeState {}

class DeleteAccountLoading extends HomeState {}

class DeleteAccountLoaded extends HomeState {}

class DeleteAccountError extends HomeState {}

class GetLocalizationLoading extends HomeState {}

class GetLocalizationLoaded extends HomeState {}

class LocalizationLoading extends HomeState {}

class LocalizationLoaded extends HomeState {
  final String languageName;

  LocalizationLoaded(this.languageName);
}
