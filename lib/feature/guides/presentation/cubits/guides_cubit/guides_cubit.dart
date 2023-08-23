import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/account/domain/use_cases/get_guide_use_case.dart';
import 'package:travel_guide/feature/chat_page/presentation/services/chat_service/guide_chats_service.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/get_list_of_user.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_list_of_user.dart';

part 'guides_state.dart';

class GuidesCubit extends Cubit<GuidesState> {
  GuidesCubit({this.guide}) : super(GuidesInitial()) {
    guide?.chatStream.stream.listen((event) {
      if (event is UpdateChatsForGuide) {
        print(event.ids);
        print("Adsgdsgsg");
        getChatList(event.ids);
      }
    });
  }
  final GuideChatService? guide;
  List<GuideModel> guides = [];
  List<int> chats = [];
  List<UserModel> user = [];
  void getAllGuide() async {
    emit(GuidesLoading());
    final res = await GetGuidesUseCase().call(NoParams());
    res.fold((l) => emit(GuidesError()), (r) {
      guides = r.data ?? [];
      emit(GuidesLoaded());
    });
  }

  void getChatList(List<String> ids) async {
    List<int> intIds = [];
    ids.forEach((element) {
      final stringNumber = element.replaceAll(RegExp(r'[a-z]'), '');
      int res = int.tryParse(stringNumber) ?? -1;
      intIds.add(res);
    });

    emit(GetChatListFromFirebaseLoading());
    chats.addAll(intIds);
    emit(GetChatListFromFirebaseLoaded());

    emit(GetChatListLoading());

    final res =
        await GetListOfUser().call(GetListOfUserParamsModel(ids: intIds));
    res.fold((l) => emit(GetChatListError()), (r) {
      user.addAll(r.users ?? []);
      emit(GetChatListLoaded());
    });
  }
}
