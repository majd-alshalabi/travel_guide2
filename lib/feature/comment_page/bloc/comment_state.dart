part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class ErrorGetAllComment extends CommentState {}

class CompleteGetAllComment extends CommentState {}

class LoadingForAnyThingButNotGetAllComment extends CommentState {}

class AddCommentLoading extends CommentState {}

class AddCommentLoaded extends CommentState {}

class AddCommentError extends CommentState {
  final String error;

  AddCommentError(this.error);
}

class LoadingGetAllComment extends CommentState {}

class GettingNewPageLoading extends CommentState {}
