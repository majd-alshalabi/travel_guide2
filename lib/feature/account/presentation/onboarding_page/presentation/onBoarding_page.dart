import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_guide/core/storage/shared/shared_prefrance.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/account/presentation/login_page/presentation/login_page.dart';
import 'package:travel_guide/feature/account/presentation/onboarding_page/presentation/onboarding_widget.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
      backgroundColor: theme.white,
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == 2;
          });
        },
        children: [
          BuildPage(
            title: "iIf you need to go on a trip",
            color: theme.darkThemeForScafold,
            subTitle: "We will give you the right place",
            urlImage: "https://lottie.host/9e5eb354-57bb-4236-a93e-5b0fb2878859/NoFJbeZ5Qu.json",
          ),
          BuildPage(
            title: "What do you think is a good place for this trip",
            color: theme.darkThemeForScafold,
            subTitle: "Open your map and let us introduce you to this place",
            urlImage: "https://lottie.host/b7cb2722-db31-41b5-bd7b-4ed67adee15e/YvZDdJw5FK.json",
          ),
          BuildPage(
            title: "Tourist trip to Syria",
            color: theme.darkThemeForScafold,
            subTitle: "Yes, everything you need is in our app . Come on, let's continue our journey ",
            urlImage: "https://lottie.host/a2634eb0-8139-424f-8938-40c0a41bef44/clKCjjTO7H.json",
          )
        ],
      ),
      bottomSheet: isLastPage
          ? Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        backgroundColor: theme.accent2,
                        minimumSize: const Size.fromHeight(60.0)),
                    onPressed: () async {
                      SharedService.saveOnBoarding(true).then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 21.0, color: theme.white),
                    )),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 80.0,
              color: theme.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      SharedService.saveOnBoarding(true).then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "SKIP",
                      style: TextStyle(color: theme.accent2),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      count: 3,
                      controller: controller,
                      effect: WormEffect(
                        dotColor: theme.accent1,
                        spacing: 16,
                        activeDotColor: theme.accent2,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 5000),
                        curve: Curves.easeInSine,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(microseconds: 5000),
                        curve: Curves.easeInSine,
                      );
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: theme.accent2),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
