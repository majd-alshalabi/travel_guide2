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
      backgroundColor: theme.darkThemeForScafold,
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
                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Name Activity",
                      style: StylesText.defaultTextStyleForAnotherModel.copyWith(color: theme.reserveDarkScaffold ,fontSize: 25),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '5000\$',
                        style: StylesText.textStyleForDescription
                            .copyWith(fontSize: 15 ,color: theme.accent2),
                      ),
                    ),
                  ],
                ),
              ),
              10.w,
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "This place is for description guys This place is for description guys This place is for description guys This place is for description guysThis place is for description guys",
                  style: StylesText.newDefaultTextStyle.copyWith(color: theme.reserveDarkScaffold ,fontSize:14 ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "Read More",
                      style: StylesText.defaultHintStyle
                          .copyWith(color: theme.accent2),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: theme.accent2,
                    )
                  ],
                ),
              ),
              10.h,
              GestureDetector(
                onTap: () {
                },
                child: Row(
                  children: [
                    Text("Add your comment" ,  style: StylesText.newDefaultTextStyle
                    .copyWith(color: theme.reserveDarkScaffold),),
                    3.w,
                    Icon(Icons.comment_outlined ,size: 30, color: theme.reserveDarkScaffold,)
                  ],
                ),
              ),
              10.h,

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  width: width,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: theme.grey,
                  ),
                  child: Center(child: Text('This is for MAP Majd')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
