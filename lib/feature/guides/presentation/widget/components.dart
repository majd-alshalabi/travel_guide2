import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/guides/presentation/pages/guide_profile.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class GuideItem extends StatelessWidget {
  const GuideItem({Key? key, required this.guide}) : super(key: key);
  final GuideModel guide;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuideProfile(guide: guide),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        decoration: BoxDecoration(
          color: theme.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TravelGuideUserAvatar(
              width: 13.w,
              imageUrl: guide.image ?? "",
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              guide.name ?? "",
              style:
                  StylesText.newDefaultTextStyle.copyWith(color: Colors.black),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: theme.reserveDarkScaffold,
            )
          ],
        ),
      ),
    );
  }
}
