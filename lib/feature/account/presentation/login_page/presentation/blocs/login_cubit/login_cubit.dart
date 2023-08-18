import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/account/domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login({
    required bool guide,
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final res = await LoginUseCase().call(
      LoginParamsModel(email: email, password: password, guide: guide),
    );
    res.fold(
      (l) => emit(LoginError()),
      (r) => emit(LoginLoaded()),
    );
  }
}
