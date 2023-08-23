part of 'chat_main_bloc.dart';

@immutable
abstract class ChatMainEvent {}

class AddNewMessageFromCubit extends ChatMainEvent {
  final FirebaseMessageModel model;

  AddNewMessageFromCubit(this.model);
}
