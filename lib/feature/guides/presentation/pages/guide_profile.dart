import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/presentation/chat_page/presentation/pages/chat_details.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class GuideProfile extends StatelessWidget {
  final GuideModel guide;

  const GuideProfile({super.key, required this.guide});
  @override
  Widget build(BuildContext context) {
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
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 30),
                        child: TravelGuideUserAvatar(
                          width: 25.w,
                          imageUrl: guide.image ?? "",
                        ),
                      ),
                      Text(
                        guide.name ?? "",
                        style: StylesText.newDefaultTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          guide.location ?? "",
                          style: StylesText.newDefaultTextStyle
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Since : ",
                            style: StylesText.newDefaultTextStyle
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            Utils.dateToUtcFormattedForNotificationFromString(
                              guide.createdAt ?? "",
                            ),
                            style: StylesText.newDefaultTextStyle
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          backgroundColor: theme.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(guide: guide),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.comment_bank_outlined,
                            color: theme.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "gender : ",
                        style: StylesText.newDefaultTextStyle
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: 5.h,
                        ),
                        decoration: BoxDecoration(
                            color: theme.greyWeak.withAlpha(90),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            guide.gender ?? "",
                            style: StylesText.newDefaultTextStyle.copyWith(
                                color: theme.reserveDarkScaffold, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Age : ",
                        style: StylesText.newDefaultTextStyle
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: 5.h,
                        ),
                        decoration: BoxDecoration(
                            color: theme.greyWeak.withAlpha(90),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            guide.age.toString(),
                            style: StylesText.newDefaultTextStyle
                                .copyWith(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "years Of Experience : ",
                        style: StylesText.newDefaultTextStyle
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: 5.h,
                        ),
                        decoration: BoxDecoration(
                            color: theme.greyWeak.withAlpha(90),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            guide.yearsofExperience.toString(),
                            style: StylesText.newDefaultTextStyle
                                .copyWith(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "bio : ",
                        style: StylesText.newDefaultTextStyle
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: 5.h,
                        ),
                        decoration: BoxDecoration(
                            color: theme.greyWeak.withAlpha(90),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            guide.bio ?? "",
                            style: StylesText.newDefaultTextStyle
                                .copyWith(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
