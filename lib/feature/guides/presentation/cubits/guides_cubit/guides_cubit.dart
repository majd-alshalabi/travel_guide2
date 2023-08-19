import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/account/domain/use_cases/get_guide_use_case.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';

part 'guides_state.dart';

class GuidesCubit extends Cubit<GuidesState> {
  GuidesCubit() : super(GuidesInitial());
  List<GuideModel> guides = [];
  void getAllGuide() async {
    emit(GuidesLoading());
    final res = await GetGuidesUseCase().call(NoParams());
    res.fold((l) => emit(GuidesError()), (r) {
      guides = r.data ?? [];
      emit(GuidesLoaded());
    });
  }
}
