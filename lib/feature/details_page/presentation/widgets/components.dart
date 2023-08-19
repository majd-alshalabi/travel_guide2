import 'package:flutter/material.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/extensions.dart';
import 'package:travel_guide/core/utils/themes.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          imageIcons(
            image: ImagesApp.imagesGreyLocation,
          ),
          5.w,
          Text(
            'Name Place, Name Region',
          ),
          20.w,
          imageIcons(
            image: ImagesApp.star,
          ),
          5.h,
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
            child: InkWell(
              onTap: () {},
              child: IconsDetails(
                theme: theme,
                widget: Icon(
                  Icons.favorite,
                  color: theme.red,
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
    return Container(
      width: width,
      height: height * 0.125,
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
                    "Name Activity",
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
                  color: theme.red,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        AppLocalizations.of(context)?.translate("restaurant") ??
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
                color: theme.red,
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
    );
  }
}
