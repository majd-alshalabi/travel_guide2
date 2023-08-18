import 'package:flutter/material.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class AllActivityPage extends StatelessWidget {
  AllActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "all activity",
          style: StylesText.newDefaultTextStyle.copyWith(color: Colors.black),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: theme.darkThemeForScafold,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(),
    );
  }
}
