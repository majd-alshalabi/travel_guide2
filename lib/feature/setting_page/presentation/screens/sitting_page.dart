
import 'package:flutter/material.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/feature/setting_page/presentation/pages/delete_account_screen.dart';
import 'package:travel_guide/feature/setting_page/presentation/pages/languages_screen.dart';
import 'package:travel_guide/feature/setting_page/presentation/pages/mode_color_screen.dart';
import 'package:travel_guide/feature/setting_page/presentation/widget/ItemBuilderSetting.dart';
import 'package:travel_guide/injection.dart';



class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool status = false;
  bool statusOfMode = false;
  bool statusOfLanguages = false;
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
        backgroundColor: theme.darkThemeForScafold,
        appBar: CustomAppBar(title: AppLocalizations.of(context)?.translate('My_Setting') ?? "",),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemBuilderSetting(
              title: AppLocalizations.of(context)
                      ?.translate('White_dark_mode') ??
                  "",
              icon: Icons.sunny,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ModeColorScreen(),
                    ));
              },
              description: AppLocalizations.of(context)
                      ?.translate('Change_your_color_Mode_setting') ??
                  "",
            ),
            ItemBuilderSetting(
              title: AppLocalizations.of(context)?.translate('Languages') ?? "",
              icon: Icons.language,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  LanguagesScreen(),
                    ));
              },
              description: AppLocalizations.of(context)
                      ?.translate('Change_your_languages_setting') ??
                  "",
            ),
            ItemBuilderSetting(
              title:
                  AppLocalizations.of(context)?.translate('delete_Account') ??
                      "",
              icon: Icons.logout,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeleteAccount(),
                  ),
                );
              },
              description: AppLocalizations.of(context)
                      ?.translate('delete_your_account') ??
                  "",
            ),
          ],
        ));
  }
}
