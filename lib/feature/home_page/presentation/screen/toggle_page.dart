import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/presentation/login_page/presentation/login_page.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/home_page/home_page.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';
import 'package:travel_guide/feature/home_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/main_page/presentation/blocs/main_cubit/main_cubit.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class TogglePage extends StatefulWidget {
  TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);
  int currentIndex = 0;

  int maxCount = 5;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    AppSettings().getCurrentLocation();
    super.initState();
  }

  final List<Widget> bottomBarPages = [
    HomePage(),
    MapScreen(
      gesture: true,
      onTap: (argument) {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        if (state is LogoutLoaded) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
            (route) => false,
          );
        } else if (state is LogoutError) {
          Utils.showCustomToast("error while logging out");
        }
      },
      child: Scaffold(
        drawer: DrawerHome(),
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        extendBodyBehindAppBar: true,
        backgroundColor: theme.darkThemeForScafold,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: PageView(
          onPageChanged: (value) {
            currentIndex = value;
          },
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            bottomBarPages.length,
            (index) => bottomBarPages[index],
          ),
        ),
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          color: theme.accent2,
          notchColor: theme.accent2,
          showShadow: false,
          removeMargins: false,
          itemLabelStyle: StylesText.newDefaultTextStyle.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
          bottomBarWidth: double.infinity,
          durationInMilliSeconds: 200,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              activeItem: Icon(
                Icons.home_filled,
                color: theme.white,
              ),
              itemLabel: 'home',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.location_searching_outlined,
                color: Colors.white,
              ),
              activeItem: Icon(
                Icons.location_searching,
                color: theme.white,
              ),
              itemLabel: 'map',
            ),
          ],
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
