import 'package:flutter/material.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/guides/presentation/pages/guide_profile.dart';
import 'package:travel_guide/feature/guides/presentation/widget/components.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class GuidesPage extends StatelessWidget {
  const GuidesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
      backgroundColor: theme.darkThemeForScafold,
      appBar: CustomAppBar(title: AppLocalizations.of(context)?.translate('guides')??"",),
      body:ListView.builder(itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GuideProfile(),)),
          child: GuideItem()),
      itemCount: 5,)

    );
  }
}
