import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class GuideItem extends StatelessWidget {
  const GuideItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme  = sl<ThemeCubit>().globalAppTheme;
    return Container(
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
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            TravelGuideUserAvatar(
            width: 13.w,
            imageUrl: 'assets/images/user_avatar/user_avatar_image.png',
          ),
          SizedBox(width: 3.w,),
          Text("name",
            style: StylesText.defaultTextStyle,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Icon(Icons.arrow_forward_ios_rounded,size: 20,color: theme.reserveDarkScaffold,),
          )
        ],
      ) ,
    );
  }
}
