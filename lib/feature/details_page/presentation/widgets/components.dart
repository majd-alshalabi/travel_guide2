import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/extensions.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/details_page/presentation/cubits/region_details_cubit/region_details_cubit.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/home_page/rate_app_page.dart';

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
    required this.name,
    required this.type,
    required this.activityId,
    required this.rate,
  });
  final int activityId;
  final String name;
  final String type;
  final String rate;
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            imageIcons(
              image: ImagesApp.imagesGreyLocation,
            ),
            SizedBox(width: 10),
            Text(
              name,
              style:
                  StylesText.newDefaultTextStyle.copyWith(color: theme.reserveDarkScaffold),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.center,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.mainAppColor,
          ),
          child: Text(
            type,
            style: StylesText.newDefaultTextStyle.copyWith(color: theme.darkThemeForScafold),
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RatingApp(
                        activityId: activityId,
                      ),
                    ));
              },
              child: imageIcons(
                image: ImagesApp.star,
              ),
            ),
            SizedBox(width: 10),
            Text(
              rate,
              style:
                  StylesText.newDefaultTextStyle.copyWith(color: theme.reserveDarkScaffold),
            ),
          ],
        )
      ],
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
          color: theme.darkThemeForScafold,
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
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
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
                widget: Icon(
                  Icons.arrow_back_ios,
                  color: theme.reserveDarkScaffold,
                ),
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
  PopupDialog(
      {Key? key, required this.onPress, required this.lat, required this.lang})
      : super(key: key);
  final Function onPress;
  final double lat;
  final double lang;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;

    return BlocProvider(
      create: (context) => RegionDetailsCubit()
        ..getWitherForFiveDay(
          lang,
          lat,
        ),
      child: Builder(builder: (context) {
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
                Container(
                  height: 100,
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverFillRemaining(
                        fillOverscroll: true,
                        child: Column(
                          children: <Widget>[
                            Text('Hello ... '),
                            Divider(
                              height: 2,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.red,
                              ), // replace this Container with your listview
                            )
                          ],
                        ),
                      )
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
      }),
    );
  }
}
