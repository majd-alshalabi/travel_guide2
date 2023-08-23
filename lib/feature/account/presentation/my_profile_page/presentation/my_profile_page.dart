import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/account/presentation/edit_profile/edit_profile.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
      backgroundColor: theme.darkThemeForScafold,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.37,
                  decoration: BoxDecoration(
                    gradient: Constant.primaryBodyColor,
                  ),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 30),
                        child: TravelGuideUserAvatar(width: 25.w, imageUrl: ""),
                      ),
                      Text(
                        "Abdalrahman",
                        style: StylesText.defaultTextStyle
                            .copyWith(color: theme.darkThemeForScafold),
                      ),
                      Text(
                        "abd233661@gmail.com",
                        style: StylesText.defaultTextStyle
                            .copyWith(color: theme.darkThemeForScafold),
                      ),
                      Text(
                        "Damascus",
                        style: StylesText.defaultTextStyle
                            .copyWith(color: theme.darkThemeForScafold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                          AppLocalizations.of(context)!.translate('since')??"",
                            style: StylesText.defaultTextStyle
                                .copyWith(color: theme.darkThemeForScafold),
                          ),
                          Text(
                            "2023/15/11",
                            style: StylesText.defaultTextStyle
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),

            Center(
              child: CustomBottom(
                text: AppLocalizations.of(context)?.translate("edit") ??
                    '',
                height: height * 0.07,
                buttonColor: Constant.primaryBodyColor,
                onPress: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const EditNameWidget();
                    },
                  );
                },
                borderColor: theme.white,
                textStyleForButton: StylesText.textStyleForButton,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
