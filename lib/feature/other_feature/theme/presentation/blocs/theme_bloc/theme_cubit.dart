import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/services/theme_services/theme_cache_helper.dart';
import 'package:travel_guide/core/utils/themes.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  AppTheme globalAppTheme = appThemeData[ThemeType.settAlKolLight]!;
  ThemeType themeType = ThemeType.settAlKolLight;

  Future<void> getCurrentTheme() async {
    final themeIndex = await ThemeCacheHelper().getCachedThemeIndex();
    themeType =
        ThemeType.values.firstWhere((appTheme) => appTheme.index == themeIndex);
    globalAppTheme = appThemeData[themeType]!;
    emit(ThemeLoadedState(
        theme: appThemeData[themeType]!.themeData,
        globalAppTheme: globalAppTheme));
  }

  Future<void> themeChanged({required ThemeType themeType}) async {
    final themeIndex = themeType.index;
    await ThemeCacheHelper().cacheThemeIndex(themeIndex);
    globalAppTheme = appThemeData[themeType]!;
    this.themeType = themeType;
    emit(ThemeLoadedState(
        theme: appThemeData[themeType]!.themeData,
        globalAppTheme: globalAppTheme));
  }

  Future<void> chooseThemeFromDialog({required ThemeType value}) async {
    emit(ThemeChooseDoneFromDialog(themeType: value));
    themeType = value;

    emit(
      ThemeLoadedState(
        theme: appThemeData[value]!.themeData,
        globalAppTheme: globalAppTheme,
      ),
    );
  }
}
