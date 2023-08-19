import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/extensions.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/details_page/presentation/page/details_activity_screen.dart';

import '../../../../injection.dart';
import '../../../other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class imageIcons extends StatelessWidget {
  const imageIcons({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: 19,
      height: 19,
    );
  }
}

class LocationInformation extends StatelessWidget {
  const LocationInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          imageIcons(
            image: ImagesApp.imagesGreyLocation,
          ),
          Text(
            'Name Region',
          ),
          20.w,
          Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme.mainAppColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)?.translate("type") ?? ''),
              ],
            ),
          ),
          20.w,
          imageIcons(
            image: ImagesApp.star,
          ),
          Text(
            '4.5',
            style: StylesText.textStyleForDescription,
          ),
        ],
      ),
    );
  }
}

class IconsDetails extends StatelessWidget {
  const IconsDetails({
    super.key,
    required this.theme,
    required this.widget,
  });

  final AppTheme theme;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: theme.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}

class ListOfImagesDetails extends StatelessWidget {
  const ListOfImagesDetails({
    super.key,
    required this.width,
    required this.height,
    required this.theme,
  });

  final double width;
  final double height;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.5,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: height * 0.45,
            child: Align(
              child: SizedBox(
                width: width,
                height: height * 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    ImagesApp.imagesRedSyriaMapPoster,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 25,
            top: 40,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: IconsDetails(
                theme: theme,
                widget: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: 30,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: theme.white,
              child: LikeButton(
                size: 35,
                circleColor: CircleColor(
                    start: Color.fromARGB(255, 236, 75, 75),
                    end: Color.fromARGB(255, 8, 3, 3)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class meansOfComfort extends StatelessWidget {
  const meansOfComfort({
    super.key,
    required this.theme,
    required this.image,
    required this.title,
  });

  final AppTheme theme;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: theme.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: theme.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}

class ActivitysOfRegion extends StatelessWidget {
  const ActivitysOfRegion({
    super.key,
    required this.width,
    required this.height,
    required this.theme,
    required this.image,
  });

  final double width;
  final double height;
  final String image;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsActivitysRegionScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 75,
              height: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            10.w,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Restaurant Name",
                      style: StylesText.textStyleForTitle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                5.h,
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.mainAppColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)?.translate("type") ??
                          ''),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                width: 35,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.mainAppColor,
                ),
                child: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: theme.white,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfImagesActivities extends StatelessWidget {
  const ListOfImagesActivities({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        height: height * 0.21,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailsActivitysRegionScreen()));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: Image.asset(
                            ImagesApp.imagesSyria,
                            width: width * 0.35,
                            height: height * 0.15,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: LikeButton(
                            size: 20,
                            circleColor: CircleColor(
                                start: Color(0xffffffff),
                                end: Color(0xffffffff)),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    'Activity Name',
                    style: StylesText.defaultTextStyleForAnotherModel,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CircleIconsDetails extends StatelessWidget {
  const CircleIconsDetails({
    super.key,
    required this.theme,
    required this.widget,
    required this.color,
    required this.function,
  });

  final AppTheme theme;
  final Widget widget;
  final Color color;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        return function();
      },
      child: CircleAvatar(
        backgroundColor: theme.white.withOpacity(0.6),
        child: widget,
        foregroundColor: color,
      ),
    );
  }
}

class PopupDialog extends StatelessWidget {
  PopupDialog({Key? key, required this.onPress}) : super(key: key);
  final Function onPress;
  AppTheme theme = sl<ThemeCubit>().globalAppTheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: AlertDialog(
        backgroundColor: theme.white,
        elevation: 10,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close_outlined,
                  color: theme.reserveDarkScaffold,
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)?.translate("could see") ?? '',
              style: StylesText.textStyleForTitle.copyWith(
                fontSize: 25,
              ),
            ),
            Image.asset(
              ImagesApp.weather,
              fit: BoxFit.cover,
              width: 150,
              height: 100,
            ),
            Text(
              '31 C',
              style: StylesText.textStyleForDescription.copyWith(
                fontSize: 20,
              ),
            ),
            10.h,
            Container(
              width: 250,
              color: theme.grey.withOpacity(0.2),
              child: Column(
                children: [
                  Text('5-day forecast'),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Today'),
                      Text('40 C'),
                      Image.asset(
                        ImagesApp.weather,
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Today'),
                      Text('40 C'),
                      Image.asset(
                        ImagesApp.weather,
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Today'),
                      Text('40 C'),
                      Image.asset(
                        ImagesApp.weather,
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            25.h,
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                onPressed: () {
                  onPress();
                },
                child: Text(
                  'Close',
                  style: StylesText.textStyleForButton
                      .copyWith(color: theme.black),
                ),
              ),
            ),
          ],
        ),
        actions: [],
      ),
    );
  }
}
