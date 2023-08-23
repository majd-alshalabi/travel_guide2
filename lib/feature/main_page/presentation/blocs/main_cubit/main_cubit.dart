import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/core/storage/shared/shared_prefrance.dart';
import 'package:travel_guide/feature/account/domain/use_cases/log_out_use_case.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  Language? language;

  MainCubit() : super(MainInitial());
  void changeLanguage(String languageName) async {
    emit(LocalizationLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedService.localization, languageName);
    if (languageName == 'ar') {
      language = Language.Arabic;
    } else {
      language = Language.english;
    }
    emit(LocalizationLoaded(languageName: languageName));
  }

  void getCurrentLanguage() async {
    emit(GetLocalizationLoading());
    final prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString(SharedService.localization);
    if (res != null) {
      if (res == 'ar') {
        language = Language.Arabic;
      } else {
        language = Language.english;
      }
    } else {
      language = Language.english;
    }
    emit(GetLocalizationLoaded());
  }

  void logout() async {
    emit(LogoutLoading());
    final res = await LogOutUseCase().call(NoParams());
    res.fold((l) => emit(LogoutError()), (r) => emit(LogoutLoaded()));
  }
}

enum Language { english, Arabic }
