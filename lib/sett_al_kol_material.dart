import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/feature/account/presentation/splash_screen/screen/splash_screen.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class SettAlKolMaterialApp extends StatelessWidget {
  const SettAlKolMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (_) => ThemeCubit()..getCurrentTheme(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              if (state is ThemeLoadedState) {
                return MaterialApp(
                  supportedLocales: const [
                    Locale('en', 'US'), // English (United States)
                    Locale('ar', 'AR'), // Dutch (Netherlands)
                  ],
                  // localeListResolutionCallback:
                  //     (allLocales, supportedLocales) {
                  //   if (sl<HomeCubit>().language == Language.english) {
                  //     return const Locale('en', 'US');
                  //   }
                  //   return const Locale('nl', 'NL');
                  // },
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  localeResolutionCallback: (locale, supportedLocales) {
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode ==
                              locale?.languageCode &&
                          supportedLocale.countryCode == locale?.countryCode) {
                        return supportedLocale;
                      }
                    }
                    return supportedLocales.first;
                  },
                  debugShowCheckedModeBanner: false,
                  title: AppConstant.appName,
                  theme: state.theme,
                  home: const SplashScreen(),
                );
              }
              return const Offstage();
            },
          ),
        );
      },
    );
  }
}
