part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class DeleteAdsInSearchLoading extends SearchState {}

class AddToFavoriteLoading extends SearchState {}

class AddToFavoriteLoaded extends SearchState {
  final int id;
  final bool fav;

  AddToFavoriteLoaded(this.id, this.fav);
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {}

class SearchError extends SearchState {}

class UpdateAdsInSearchInfoLoading extends SearchState {}

class UpdateAdsInSearchCommentCount extends SearchState {
  final int adsId;
  final CommentModel comment;

  UpdateAdsInSearchCommentCount({
    required this.adsId,
    required this.comment,
  });
}

class GettingNewSearchPageLoading extends SearchState {}

class GettingNewSearchPageLoaded extends SearchState {}

class SelectTypeLoading extends SearchState {}

class SelectTypeLoaded extends SearchState {}
