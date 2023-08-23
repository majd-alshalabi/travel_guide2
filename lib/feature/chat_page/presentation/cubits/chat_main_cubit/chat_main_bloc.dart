import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:travel_guide/core/constants/enums.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/chat_page/presentation/services/chat_service/chat_service.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';

part 'chat_main_event.dart';
part 'chat_main_state.dart';

class ChatMainBloc extends Bloc<ChatMainEvent, ChatMainState> {
  List<FirebaseMessageModel> messagesList = [];
  List<types.Message> uiList = [];
  final AdminModel model;
  final ChatService services;
  StreamSubscription? streamSubscription;
  @override
  Future<void> close() async {
    streamSubscription?.cancel();
    super.close();
  }

  ChatMainBloc(this.services, this.model) : super(ChatMainInitial()) {
    streamSubscription = services.chatStream.stream.listen((event) {
      if (event is AddNewMessageFromStreamEvent) {
        add(AddNewMessageFromCubit(event.message));
      }
    });
    on<ChatMainEvent>((event, emit) {
      switch (event.runtimeType) {
        case AddNewMessageFromCubit:
          event as AddNewMessageFromCubit;
          emit(NewMessageAddStateLoading());
          messagesList.add((event).model);
          if (MessageType.fromInt(event.model.type ?? 0) == MessageType.text) {
            uiList.insert(
                0,
                types.TextMessage(
                  createdAt: event.model.created_at,
                  id: event.model.id ?? "",
                  text: event.model.message ?? "",
                  author: types.User(
                    id: event.model.senderId ?? "",
                    firstName: event.model.senderId ==
                            Utils.getIdForChat(
                              AppSettings().identity?.serverId ?? -1,
                              AppSettings().identity?.guide ?? UserType.user,
                            )
                        ? AppSettings().identity?.name ?? ""
                        : model.name ?? "",
                    imageUrl: NetworkConfigurations.BaseUrl +
                        (event.model.senderId ==
                                Utils.getIdForChat(
                                  AppSettings().identity?.serverId ?? -1,
                                  AppSettings().identity?.guide ??
                                      UserType.user,
                                )
                            ? AppSettings().identity?.imageUrl ?? ""
                            : model.image ?? ""),
                  ),
                ));
          } else {}
          emit(NewMessageAddStateLoaded());
          break;
      }
    });
  }
}
