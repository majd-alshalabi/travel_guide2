import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 50.0,
        ),
      ),
      child: Scaffold(
        backgroundColor: theme.darkThemeForScafold,
        appBar: CustomAppBar(title:  AppLocalizations.of(context)?.translate('delete_Account') ?? "",),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.translate('delete_Account') ??
                      "",
                  style: StylesText.newDefaultTextStyle
                      .copyWith(fontSize: 20, color: theme.greyWeak),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LogOutCustomBottom(
                        text: AppLocalizations.of(context)
                            ?.translate('delete') ??
                            "",
                        height: 60,
                        onPress: () {
                        },
                        borderColor: theme.greyWeak,
                        textStyleForButton: StylesText.defaultTextStyle
                            .copyWith(color: theme.darkThemeForScafold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
