part of 'rate_cubit.dart';

@immutable
abstract class RateState {}

class RateInitial extends RateState {}

class AddRateLoading extends RateState {}

class AddRateError extends RateState {}

class AddRateLoaded extends RateState {}
