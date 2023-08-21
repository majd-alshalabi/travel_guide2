
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_guide/core/constants/shared_constant.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  Language? language;
  HomeCubit() : super(HomeInitial());
  void changeLanguage(String languageName) async {
    emit(LocalizationLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ShaderConstant.localization, languageName);
    if (languageName == 'ar') {
      language = Language.Arabic;
    } else {
      language = Language.english;
    }
    emit(LocalizationLoaded(languageName));
  }

  void getCurrentLanguage() async {
    emit(GetLocalizationLoading());
    final prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString(ShaderConstant.localization);
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

}

enum Language { english, Arabic }
