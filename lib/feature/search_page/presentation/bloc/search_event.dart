part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class NewSearchEvents extends SearchEvent {
  final String? name;
  NewSearchEvents({required this.name});
}

class PaginationEvent extends SearchEvent {
  final String? name;
  PaginationEvent({required this.name});
}

class SelectType extends SearchEvent {
  final int? type;
  final String? name;
  SelectType({
    required this.name,
    required this.type,
  });
}

class DeleteAdsEvent extends SearchEvent {
  final int adsId;

  DeleteAdsEvent(this.adsId);
}

class AddToFavorite extends SearchEvent {
  final int adsId;
  final bool fav;

  AddToFavorite(this.adsId, this.fav);
}

class UpdateAdsInfo extends SearchEvent {
  final int adsId;
  final CommentModel comment;

  UpdateAdsInfo({
    required this.adsId,
    required this.comment,
  });
}
