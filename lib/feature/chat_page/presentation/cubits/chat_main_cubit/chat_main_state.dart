part of 'chat_main_bloc.dart';

@immutable
abstract class ChatMainState {}

class ChatMainInitial extends ChatMainState {}

class NewMessageAddStateLoading extends ChatMainState {}

class NewMessageAddStateLoaded extends ChatMainState {}
