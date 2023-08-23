import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  bool statusOfLanguages = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
      backgroundColor: theme.darkThemeForScafold,
      appBar:CustomAppBar(title: AppLocalizations.of(context)?.translate('Languages_Setting') ?? "",),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                AppLocalizations.of(context)?.translate('Languages') ?? "",
              style: StylesText.newDefaultTextStyle
                  .copyWith(fontSize: 20, color: theme.greyWeak),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)?.translate('Arabic') ??
                      "",
                  style:
                      StylesText.defaultTextStyle.copyWith(color: theme.black),
                ),
                const Spacer(),
                FlutterSwitch(
                  width: 80.0,
                  height: 30.0,
                  valueFontSize: 10.0,
                  toggleSize: 30.0,
                  activeColor: theme.accent2,
                  value: statusOfLanguages,
                  borderRadius: 20.0,
                  padding: 8.0,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      statusOfLanguages = val;
                      if (val == true) {
                        AppLocalizations.changeLanguage(
                          context,
                          const Locale('nl', "NL"),
                        );
                      } else {
                        AppLocalizations.changeLanguage(
                          context,
                          const Locale('en', "US"),
                        );
                      }

                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
