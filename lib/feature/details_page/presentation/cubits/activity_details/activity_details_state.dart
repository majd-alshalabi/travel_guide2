part of 'activity_details_cubit.dart';

@immutable
abstract class ActivityDetailsState {}

class ActivityDetailsInitial extends ActivityDetailsState {}

class UpdateLikeLoading extends ActivityDetailsState {}

class UpdateLikeLoaded extends ActivityDetailsState {
  final bool added;

  UpdateLikeLoaded(this.added);
}
