import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  static late Locale _locale;
  static late Map<String, String> _localizationStrings;

  AppLocalizations._();

  static Locale get locale => _locale;

  static void setLocale(Locale locale) {
    _locale = locale;
  }

  static Future<AppLocalizations> load(Locale locale) async {
    String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizationStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return AppLocalizations._();
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  String? translate(String key) {
    return _localizationStrings[key];
  }

  static Future<void> changeLanguage(BuildContext context, Locale newLocale) async {
    final appLocalization = AppLocalizations.of(context);
    if (appLocalization == null) return;

    await AppLocalizations.load(newLocale);
    AppLocalizations.setLocale(newLocale);
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'nl'].contains(locale.languageCode.toLowerCase());
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations.setLocale(locale);
    await AppLocalizations.load(locale);
    return AppLocalizations._();
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
