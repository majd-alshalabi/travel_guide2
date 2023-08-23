import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class BuildPage extends StatelessWidget {
  const BuildPage({
    Key? key,
    required this.title,
    required this.color,
    required this.subTitle,
    required this.urlImage,
  }) : super(key: key);

  final Color color;
  final String urlImage;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Container(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100)
              ),
              child: Lottie.network(
                  urlImage),
            )
          ),
          const SizedBox(
            height: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              style: TextStyle(
                  color: theme.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              subTitle,
              style: TextStyle(
                color: theme.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
