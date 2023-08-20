import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/extensions.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/details_page/presentation/widgets/components.dart';

import '../../../../injection.dart';
import '../../../other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class DetailsActivitysRegionScreen extends StatelessWidget {
  const DetailsActivitysRegionScreen({Key? key}) : super(key: key);

  static const List<String> images = [
    ImagesApp.imagesRedSyriaMapPoster,
    ImagesApp.imagesRedSyriaMapPoster,
    ImagesApp.imagesRedSyriaMapPoster,
    ImagesApp.imagesRedSyriaMapPoster,
    ImagesApp.imagesRedSyriaMapPoster,
    ImagesApp.imagesRedSyriaMapPoster,
  ];
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return ListOfImagesDetails(
                    width: width,
                    height: height,
                    theme: theme,
                  );
                },
                options: CarouselOptions(
                  height: height * 0.5,
                  autoPlay: false,
                  animateToClosest: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 2.0,
                  initialPage: 1,
                ),
              ),
              LocationInformation(),
              10.h,
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Name Activity",
                      style: StylesText.textStyleForTitle,
                    ),
                    Text(
                      '5000\$',
                      style: StylesText.textStyleForDescription
                          .copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "This place is for description guys This place is for description guys This place is for description guys This place is for description guysThis place is for description guys",
                  style: StylesText.textStyleForDescription,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "Read More",
                      style: StylesText.textStyleForButton
                          .copyWith(color: theme.error),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: theme.error,
                    )
                  ],
                ),
              ),
              // 10.h,
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
              //   image: ImagesApp.imagesSyria,
              // ),
              10.h,
              CustomBottom(
                text: AppLocalizations.of(context)?.translate("commment") ?? '',
                height: height * 0.07,
                buttonColor: theme.mainAppColor,
                onPress: () {},
                borderColor: theme.white,
                textStyleForButton: StylesText.textStyleForButton,
              ),
              Container(
                width: width,
                height: height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: theme.grey,
                ),
                child: Center(child: Text('This is for MAP Majd')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}