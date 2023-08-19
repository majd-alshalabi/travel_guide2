import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/account/domain/use_cases/log_out_use_case.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  void logout() async {
    emit(LogoutLoading());
    final res = await LogOutUseCase().call(NoParams());
    res.fold((l) => emit(LogoutError()), (r) => emit(LogoutLoaded()));
  }
}
