part of 'book_mark_cubit.dart';

@immutable
abstract class BookMarkState {}

class BookMarkInitial extends BookMarkState {}

class AddToBookMarkLoading extends BookMarkState {}

class AddToBookMarkLoaded extends BookMarkState {
  final int id;
  final bool added;

  AddToBookMarkLoaded(this.id, this.added);
}

class AddToBookMarkError extends BookMarkState {}

class GetBookMarkedLoading extends BookMarkState {}

class GetBookMarkedLoaded extends BookMarkState {}

class GetBookMarkedError extends BookMarkState {}
