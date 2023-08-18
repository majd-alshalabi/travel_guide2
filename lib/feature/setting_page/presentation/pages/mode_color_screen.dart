import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class ModeColorScreen extends StatefulWidget {
  const ModeColorScreen({Key? key}) : super(key: key);

  @override
  State<ModeColorScreen> createState() => _ModeColorScreenState();
}

class _ModeColorScreenState extends State<ModeColorScreen> {
  bool statusOfMode = false;
  ThemeCubit themeCubit = sl<ThemeCubit>();
  @override
  void initState() {
    statusOfMode = sl<ThemeCubit>().themeType == ThemeType.settAlKolLight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return
      Scaffold(
      backgroundColor: theme.darkThemeForScafold,
      appBar: AppBar(
        iconTheme: IconThemeData(color: theme.black),
        title: Text(
          AppLocalizations.of(context)?.translate('Color_Mode_App_Setting') ??
              "",
          style: StylesText.newTextStyleForAppBar.copyWith(color: theme.black),
        ),
        backgroundColor: theme.darkAndWhiteForAppBar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('White_dark_mode') ??
                    "",
                style: StylesText.newDefaultTextStyle
                    .copyWith(fontSize: 20, color: theme.greyWeak),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)?.translate('select_mode') ??
                        "",
                    style: StylesText.defaultTextStyle
                        .copyWith(color: theme.black),
                  ),
                  const Spacer(),
                  FlutterSwitch(
                    width: 80.0,
                    height: 30.0,
                    valueFontSize: 10.0,
                    toggleSize: 20.0,
                    value: statusOfMode,
                    borderRadius: 20.0,
                    padding: 8.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        statusOfMode = val;
                        if (val == false) {
                          sl<ThemeCubit>()
                              .themeChanged(themeType: ThemeType.settAlKolLight);
                        } else {
                          sl<ThemeCubit>()
                              .themeChanged(themeType: ThemeType.settAlKolDark);
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
