import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/constants/enums.dart';
import 'package:travel_guide/feature/account/presentation/login_page/presentation/login_page.dart';
import 'package:travel_guide/feature/account/presentation/onboarding_page/presentation/onBoarding_page.dart';
import 'package:travel_guide/feature/account/presentation/splash_screen/bloc/splash_screen_bloc/splash_screen_cubit.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/toggle_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenCubit()..initState(),
      child: Builder(builder: (context) {
        return BlocListener<SplashScreenCubit, SplashScreenState>(
          listener: (context, state) {
            if (state is SplashScreenLoaded) {
              if (state.toWhere == ToWhereShouldINavigateFromSplash.home) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TogglePage(),
                  ),
                  (route) => false,
                );
              } else if (state.toWhere ==
                  ToWhereShouldINavigateFromSplash.signInPage) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              } else if (state.toWhere ==
                  ToWhereShouldINavigateFromSplash.onBoarding) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnBoardingPage(),
                  ),
                  (route) => false,
                );
              }
            } else if (state is SplashScreenError) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            }
          },
          child: const Scaffold(
            backgroundColor: Colors.black87,
          ),
        );
      }),
    );
  }
}
