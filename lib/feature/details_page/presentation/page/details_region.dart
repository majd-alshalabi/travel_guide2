import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/extensions.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/activities/presentation/screen/activities.dart';
import 'package:travel_guide/feature/details_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

import '../../../../injection.dart';

class DetailsRegion extends StatelessWidget {
  const DetailsRegion({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  ImagesApp.kemarea,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleIconsDetails(
                        theme: theme,
                        widget: Icon(Icons.arrow_back),
                        color: theme.black,
                        function: () {},
                      ),
                      // SizedBox(
                      //   width: width * 0.6,
                      // ),
                      // CircleIconsDetails(
                      //   theme: theme,
                      //   widget: Icon(Icons.favorite),
                      //   color: theme.black,
                      //   function: () {},
                      // ),
                      LikeButton(
                        size: 35,
                        circleColor: CircleColor(
                            start: Color.fromARGB(255, 236, 75, 75),
                            end: Color.fromARGB(255, 8, 3, 3)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 75,
                  child: InkWell(
                    onTap: () {
                      return showSimple(context);
                    },
                    child: Container(
                      width: 40,
                      height: 70,
                      decoration: BoxDecoration(
                        color: theme.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            ImagesApp.weather,
                          ),
                          Text('31 C')
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 25,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          theme.white.withOpacity(0.5),
                          theme.white.withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          ImagesApp.imagesUserAvatarUserAvatarImage,
                          width: 50,
                          height: 50,
                        ),
                        10.w,
                        Column(
                          children: [
                            Text(
                              'Guide Name',
                              style: StylesText.textStyleForDescription,
                            ),
                            Text(
                              'Location Guide',
                              style: StylesText.textStyleForDescription,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            CustomText(
              seeAllButton: false,
              titleName:
                  AppLocalizations.of(context)?.translate("could see") ?? "",
              onTap: () {},
            ),
            ListOfImagesActivities(
              height: height,
              width: width,
            ),
            CustomText(
              titleName:
                  AppLocalizations.of(context)?.translate("activities") ?? "",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivitiesScreen()));
              },
              seeAllButton: false,
            ),
            SizedBox(
              width: width,
              height: height * 0.3,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return ActivitysOfRegion(
                    width: width,
                    height: height,
                    theme: theme,
                    image: ImagesApp.imagesSyria1,
                  );
                },
              ),
            ),

            // ActivitysOfRegion(
            //   width: width,
            //   height: height,
            //   theme: theme,
            //   image: ImagesApp.imagesSyria1,
            // ),
            // Divider(
            //   thickness: 2,
            // ),
            // ActivitysOfRegion(
            //   width: width,
            //   height: height,
            //   theme: theme,
            //   image: ImagesApp.imagesSyria1,
            // ),
            // SizedBox(
            //   height: height * 0.18,
            //   child: ListView(
            //     padding: EdgeInsets.symmetric(horizontal: 10.0),
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       meansOfComfort(
            //         theme: theme,
            //         image: ImagesApp.restaurant,
            //         title:
            //             AppLocalizations.of(context)?.translate("restaurant") ??
            //                 '',
            //       ),
            //       10.w,
            //       meansOfComfort(
            //         theme: theme,
            //         image: ImagesApp.park,
            //         title:
            //             AppLocalizations.of(context)?.translate("park") ?? '',
            //       ),
            //       10.w,
            //       meansOfComfort(
            //         theme: theme,
            //         image: ImagesApp.restaurant,
            //         title:
            //             AppLocalizations.of(context)?.translate("hotel") ?? '',
            //       ),
            //       10.w,
            //       meansOfComfort(
            //         theme: theme,
            //         image: ImagesApp.game,
            //         title: AppLocalizations.of(context)
            //                 ?.translate("entertainment") ??
            //             '',
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

void showSimple(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupDialog(
          onPress: () {
            Navigator.pop(context);
          },
        );
      },
    );
