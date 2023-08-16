import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/color_utils.dart';

enum ThemeType {
  settAlKolLight('Light Theme'),
  settAlKolDark('Dark Theme'),
  systemMode('Use System Theme');

  final String name;

  const ThemeType(this.name);
}

final appThemeData = {
  ThemeType.settAlKolLight: AppTheme(
    reserveDarkScaffold: const Color(0xff2A2D3E),
    reserveBlue: Colors.blue,
    //......................................
    darkAndWhiteForAppBar: const Color(0xff909f9c),
    darkThemeForScafold: Colors.white,
    black: Colors.black,
    blue: Colors.blue,
    white: Colors.white,
    isDark: false,
    mainAppColor: Colors.blue,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xffE6E6E6),
      filled: true,
      border: InputBorder.none,
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
    ),

    text: Colors.black,
    accentText: Colors.white,
    background: const Color(0xfff1f7f0),
    surface: Colors.white,
    accent1: const Color(0xff00a086),
    accent1Darker: const Color(0xff006b5a),

    // scroll over color
    accent2: const Color(0xff5bc91a),
    greyWeak: const Color(0xff909f9c),
    error: Colors.red.shade900,
  ),
  ThemeType.settAlKolDark: AppTheme(
    reserveDarkScaffold: Colors.white,
    reserveBlue: Colors.deepOrange,
    darkAndWhiteForAppBar: const Color(0xff212332),
    darkThemeForScafold: const Color(0xff2A2D3E),
    black: Colors.white,
    blue: Colors.blue,
    white: Colors.black,
    isDark: true,
    mainAppColor: Colors.blue,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xffE6E6E6),
      filled: true,
      border: InputBorder.none,
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
    ),
    text: Colors.white,
    accentText: Colors.black,
    background: const Color(0xff121212),
    surface: const Color(0xff252525),
    accent1: const Color(0xff00a086),
    accent1Darker: const Color(0xff00caa5),
    accent2: const Color(0xfff19e46),
    greyWeak: const Color(0xffa8b3b0),
    error: const Color(0xffe55642),
  ),
  ThemeType.systemMode: AppTheme.brightness == Brightness.dark
      ? AppTheme(
    reserveDarkScaffold: Colors.white,
    reserveBlue: Colors.deepOrange,
    darkAndWhiteForAppBar: const Color(0xff212332),
    darkThemeForScafold: const Color(0xff2A2D3E),
    black: Colors.black,
    blue: Colors.blue,
    white: Colors.black,
    isDark: true,
    mainAppColor: Colors.blue,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xffE6E6E6),
      filled: true,
      border: InputBorder.none,
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
    ),
    text: Colors.white,
    accentText: Colors.black,
    background: const Color(0xff121212),
    surface: const Color(0xff252525),
    accent1: const Color(0xff00a086),
    accent1Darker: const Color(0xff00caa5),
    accent2: const Color(0xfff19e46),
    greyWeak: const Color(0xffa8b3b0),
    error: const Color(0xffe55642),
  )
      : AppTheme(
    reserveDarkScaffold: const Color(0xff2A2D3E),
    reserveBlue: Colors.blue,
    ///..................................
    darkAndWhiteForAppBar: const Color(0xff909f9c),
    darkThemeForScafold: Colors.white,
    black: Colors.black,
    blue: Colors.blue,
    white: Colors.white,
    isDark: false,
    mainAppColor: Colors.blue,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xffE6E6E6),
      filled: true,
      border: InputBorder.none,
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
      ),
    ),
    text: Colors.black,
    accentText: Colors.white,
    background: const Color(0xfff1f7f0),
    surface: Colors.white,
    accent1: const Color(0xff00a086),
    accent1Darker: const Color(0xff006b5a),
    // scroll over color
    accent2: const Color(0xff5bc91a),
    greyWeak: const Color(0xff909f9c),
    error: Colors.red.shade900,
  ),
};

class AppTheme {
  static ThemeType defaultTheme = ThemeType.settAlKolLight;
  static Brightness brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  bool isDark;
  Color mainAppColor;
  final Color black;
  final Color reserveDarkScaffold;
  final Color accent1;
  final Color accent1Darker;
  final Color darkAndWhiteForAppBar;
  final Color accent2;
  final Color reserveBlue;
  final Color background;
  final Color surface;
  final Color text;
  final Color white;
  final Color accentText;
  final Color greyWeak;
  final Color error;
  final Color blue;
  final Color darkThemeForScafold;
  InputDecorationTheme inputDecorationTheme;

  /// Default constructor
  AppTheme({
    required this.reserveDarkScaffold,
    required this.reserveBlue,
    required this.darkAndWhiteForAppBar,
    required this.darkThemeForScafold,
    required this.black,
    required this.blue,
    required this.white,
    required this.background,
    required this.isDark,
    required this.mainAppColor,
    required this.accent1Darker,
    required this.accent1,
    required this.accent2,
    required this.surface,
    required this.accentText,
    required this.text,
    required this.greyWeak,
    required this.error,
    required this.inputDecorationTheme,
  });

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: accent1,
        primaryContainer: accent1Darker,
        secondary: accent2,
        secondaryContainer: ColorUtils.shiftHsl(accent2, -.2),
        background: background,
        surface: surface,
        onBackground: text,
        onSurface: text,
        onError: text,
        onPrimary: accentText,
        onSecondary: accentText,
        error: error,
      ),
    );

    return t.copyWith(
      textTheme: const TextTheme()
          .apply(
        displayColor: isDark ? Colors.white : Colors.black,
        bodyColor: isDark ? Colors.white : Colors.black,
      )
          .copyWith(
        labelMedium: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        titleLarge: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        headlineSmall: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        headlineMedium: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        headlineLarge: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        titleMedium: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        labelLarge: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        displayLarge: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        bodyMedium: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        labelSmall: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        bodyLarge: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        displayMedium: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        displaySmall: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        bodySmall: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        titleSmall: isDark
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,

          ///TODO add font family
        ),
      ),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStateColor.resolveWith((states) => Colors.white),
          trackColor: MaterialStateColor.resolveWith((states) => Colors.grey)),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        border: InputBorder.none,
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(Corners.lg)),
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: greyWeak,
        selectionHandleColor: Colors.transparent,
        cursorColor: accent1,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: accent1,
      ),
      highlightColor: Colors.transparent,
    );
  }

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));
}
