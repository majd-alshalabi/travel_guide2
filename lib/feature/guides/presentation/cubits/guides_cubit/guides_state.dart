part of 'guides_cubit.dart';

@immutable
abstract class GuidesState {}

class GuidesInitial extends GuidesState {}

class GuidesLoading extends GuidesState {}

class GuidesLoaded extends GuidesState {}

class GuidesError extends GuidesState {}
