import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/constants/enums.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/storage/shared/shared_prefrance.dart';
import 'package:travel_guide/feature/account/domain/use_cases/get_my_identity_use_case.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  void initState() async {
    emit(SplashScreenLoading());

    ToWhereShouldINavigateFromSplash toWhere =
        ToWhereShouldINavigateFromSplash.signInPage;
    bool result = await SharedService.getOnBoarding();
    if (result != true) {
      toWhere = ToWhereShouldINavigateFromSplash.onBoarding;
    }
    final res = await GetMyIdentityUseCase().call(NoParams());
    res.fold((l) => emit(SplashScreenError()), (r) async {
      if (r != null) {
        AppSettings().identity = r;
        toWhere = ToWhereShouldINavigateFromSplash.home;
      }
      emit(SplashScreenLoaded(toWhere: toWhere));
    });
  }
}
