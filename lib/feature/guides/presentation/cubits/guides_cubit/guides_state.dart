part of 'guides_cubit.dart';

@immutable
abstract class GuidesState {}

class GuidesInitial extends GuidesState {}

class GuidesLoading extends GuidesState {}

class GuidesLoaded extends GuidesState {}

class GuidesError extends GuidesState {}

class GetChatListLoading extends GuidesState {}

class GetChatListFromFirebaseLoading extends GuidesState {}

class GetChatListFromFirebaseLoaded extends GuidesState {}

class GetChatListLoaded extends GuidesState {}

class GetChatListError extends GuidesState {}
