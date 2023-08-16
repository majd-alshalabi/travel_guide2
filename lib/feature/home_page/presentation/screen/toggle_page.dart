import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/favorite_page/presentation/screen/favorite_page.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/home_page/home_page.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';
import 'package:travel_guide/feature/home_page/presentation/widgets/components.dart';
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

  final List<Widget> bottomBarPages = [
    HomePage(),
    MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
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
        /// Provide NotchBottomBarController
        notchBottomBarController: _controller,
        color: theme.reserveDarkScaffold,
        notchColor: theme.reserveDarkScaffold,
        showShadow: false,
        removeMargins: false,
        itemLabelStyle: StylesText.newDefaultTextStyle
            .copyWith(fontSize: 14, color: theme.darkThemeForScafold),
        bottomBarWidth: double.infinity,
        durationInMilliSeconds: 200,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.home,
              color: theme.white,
            ),
            itemLabel: 'text',
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
            itemLabel: 'text',
          ),

        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
