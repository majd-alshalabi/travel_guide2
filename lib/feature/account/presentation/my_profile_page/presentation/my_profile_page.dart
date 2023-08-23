import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
      backgroundColor: theme.darkThemeForScafold,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.37,
        decoration: BoxDecoration(
          gradient: Constant.primaryBodyColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 30),
              child: TravelGuideUserAvatar(
                width: 25.w,
                imageUrl: AppSettings().identity?.imageUrl ?? "",
              ),
            ),
            Text(
              AppSettings().identity?.name ?? "",
              style: StylesText.newDefaultTextStyle
                  .copyWith(color: theme.darkThemeForScafold),
            ),
            SizedBox(height: 10),
            Text(
              AppSettings().identity?.email ?? "",
              style: StylesText.newDefaultTextStyle
                  .copyWith(color: theme.darkThemeForScafold),
            ),
          ],
        ),
      ),
    );
  }
}
