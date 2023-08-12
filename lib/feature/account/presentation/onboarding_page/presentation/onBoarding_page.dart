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
            title: "pick an image ",
            color: theme.white,
            subTitle: "easily to shard your Ads moment , spread the word ",
            urlImage: "assets/images/back01.png",
          ),
          BuildPage(
            title: "it's your Ads",
            color: theme.white,
            subTitle: "Moment share is your Ads , comment ,like and share",
            urlImage: "assets/images/back02.png",
          ),
          BuildPage(
            title: "Many categories options ",
            color: theme.white,
            subTitle: "Select your proper to explore , post and share ",
            urlImage: "assets/images/hobby3.png",
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
                        backgroundColor: theme.blue,
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
                      style: TextStyle(color: theme.blue),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      count: 3,
                      controller: controller,
                      effect: WormEffect(
                        dotColor: Colors.blueAccent,
                        spacing: 16,
                        activeDotColor: theme.blue,
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
                      style: TextStyle(color: theme.blue),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
