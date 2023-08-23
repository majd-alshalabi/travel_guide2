import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/constants/enums.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/account/presentation/splash_screen/screen/splash_screen.dart';
import 'package:travel_guide/feature/main_page/presentation/blocs/main_cubit/main_cubit.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class SettAlKolMaterialApp extends StatefulWidget {
  const SettAlKolMaterialApp({Key? key}) : super(key: key);

  @override
  State<SettAlKolMaterialApp> createState() => _SettAlKolMaterialAppState();
}

class _SettAlKolMaterialAppState extends State<SettAlKolMaterialApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    AppSettings().appState = AppState.foreground;
    super.initState();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppSettings().appState = AppState.foreground;
    } else {
      AppSettings().appState = AppState.background;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: sl<ThemeCubit>()..getCurrentTheme(),
            ),
            BlocProvider(
              create: (context) => MainCubit()..getCurrentLanguage(),
            ),
          ],
          child: Builder(builder: (context) {
            return BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    if (context.read<MainCubit>().language == null)
                      return const Offstage();
                    if (state is ThemeLoadedState) {
                      return MaterialApp(
                        navigatorKey: AppSettings().navigatorKey,
                        supportedLocales: const [
                          Locale('en', 'US'), // English (United States)
                          Locale('ar', 'AR'), // Dutch (Netherlands)
                        ],
                        localeListResolutionCallback:
                            (allLocales, supportedLocales) {
                          if (context.read<MainCubit>().language ==
                              Language.english) {
                            return const Locale('en', 'US');
                          }
                          return const Locale('ar', 'AR');
                        },
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
                                supportedLocale.countryCode ==
                                    locale?.countryCode) {
                              return supportedLocale;
                            }
                          }
                          return supportedLocales.first;
                        },
                        debugShowCheckedModeBanner: false,
                        title: AppConstant.appName,
                        theme: state.theme,
                        home: SplashScreen(),
                      );
                    }
                    return const Offstage();
                  },
                );
              },
            );
          }),
        );
      },
    );
  }
}
