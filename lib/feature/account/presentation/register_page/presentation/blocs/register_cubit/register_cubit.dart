import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/feature/account/data/models/remote/register_model.dart';
import 'package:travel_guide/feature/account/domain/use_cases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void register(
      {required String name,
      required String email,
      required String password,
      String? number}) async {
    emit(RegisterLoading());
    final res = await RegisterUseCase().call(
      RegisterParamsModel(
          number: number ?? "", name: name, email: email, password: password),
    );
    res.fold(
      (l) => emit(RegisterError()),
      (r) => emit(RegisterLoaded()),
    );
  }
}
