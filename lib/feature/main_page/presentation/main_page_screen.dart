import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class SettAlKolMainPage extends StatelessWidget {
  const SettAlKolMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstant.appName),
        backgroundColor: theme.mainAppColor,
      ),
    );
  }
}
