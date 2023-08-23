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
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 30),
                        child: TravelGuideUserAvatar(width: 25.w, imageUrl: ""),
                      ),
                      Text(
                        "Abdalrahman",
                        style: StylesText.defaultTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "abd233661@gmail.com",
                        style: StylesText.defaultTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "Damascus",
                        style: StylesText.defaultTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Since : ",
                            style: StylesText.defaultTextStyle
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "2023/15/11",
                            style: StylesText.defaultTextStyle
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       bottom: 8.0, left: 16, right: 16),
                      //   child: Align(
                      //     alignment: Alignment.centerRight,
                      //     child: Container(
                      //       height: MediaQuery.of(context).size.height * 0.05,
                      //       width: MediaQuery.of(context).size.width * 0.1,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(20.0),
                      //       ),
                      //       child: IconButton(
                      //         onPressed: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => const ChatDetails(
                      //                   senderName: "Harry Peterson"),
                      //             ),
                      //           );
                      //         },
                      //         icon: Icon(Icons.chat_bubble_outline_rounded),
                      //       ),
                      //     ),
                      //   ),
                      // )
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
                        "gender: ",
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
                            "male",
                            style: StylesText.newDefaultTextStyle.copyWith(
                                color: theme.reserveDarkScaffold, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Age: ",
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
                            "22",
                            style: StylesText.newDefaultTextStyle
                                .copyWith(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "bio: ",
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
                            "sadnlk/asdnasn.asn.asdna.jskdna.sdnaj.kdnajdnaj.kdn.ajdnasjkdna.jkdnajk.dnajkdnakj.dnajk.dna.jdknadjk.andjk.adnjak.dnjak.sdnjak.dnj.kad",
                            style: StylesText.newDefaultTextStyle
                                .copyWith(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomBottom(
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
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
