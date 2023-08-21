import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/details_page/presentation/cubits/region_details_cubit/region_details_cubit.dart';
import 'package:travel_guide/feature/details_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';
import 'package:travel_guide/feature/home_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class DetailsRegion extends StatelessWidget {
  const DetailsRegion({super.key, required this.model});
  final RegionModel model;
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) => RegionDetailsCubit()
        ..getActivityInRegion(model.id ?? -1)
        ..getWitherForOneDay(model.longitude ?? 0, model.latitude ?? 0),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ImageViewer(
                      file: false,
                      images:
                          (model.images ?? []).map((e) => e.url ?? "").toList(),
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
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 25,
                      child:
                          BlocBuilder<RegionDetailsCubit, RegionDetailsState>(
                        buildWhen: (previous, current) {
                          if (current is GetWitherOneDayError) return true;
                          if (current is GetWitherOneDayLoaded) return true;
                          if (current is GetWitherOneDayLoading) return true;
                          return false;
                        },
                        builder: (context, state) {
                          if (state is GetWitherOneDayLoaded)
                            return InkWell(
                              onTap: () {
                                // showSimple(context, model.latitude ?? 0,
                                //     model.longitude ?? 0);
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
                                    Image.network(
                                      "http://openweathermap.org/img/w/" +
                                          (context
                                                  .read<RegionDetailsCubit>()
                                                  .witherModel
                                                  ?.weather
                                                  ?.first
                                                  .icon ??
                                              "") +
                                          ".png",
                                    ),
                                    Text((context
                                            .read<RegionDetailsCubit>()
                                            .witherModel
                                            ?.main
                                            ?.temp)
                                        .toString())
                                  ],
                                ),
                              ),
                            );
                          return const Offstage();
                        },
                      ),
                    )
                  ],
                ),
                CustomText(
                  seeAllButton: false,
                  titleName:
                      AppLocalizations.of(context)?.translate("could see") ??
                          "",
                  onTap: () {},
                ),
                BlocBuilder<RegionDetailsCubit, RegionDetailsState>(
                  buildWhen: (previous, current) {
                    if (current is GetActivityInRegionLoading) return true;
                    if (current is GetActivityInRegionLoaded) return true;
                    if (current is GetActivityInRegionError) return true;
                    return false;
                  },
                  builder: (context, state) {
                    if (state is GetActivityInRegionLoading) {
                      return HomeLoadingWidget();
                    }
                    if (context
                        .read<RegionDetailsCubit>()
                        .activityList
                        .isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            Text(
                              "no data to show",
                              style: StylesText.newDefaultTextStyle
                                  .copyWith(color: Colors.black),
                            ),
                            TextButton(
                              child: Text(
                                "try again",
                                style: StylesText.newDefaultTextStyle
                                    .copyWith(color: Colors.blue),
                              ),
                              onPressed: () {
                                context
                                    .read<RegionDetailsCubit>()
                                    .getActivityInRegion(
                                      model.id ?? -1,
                                    );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return ListActivity(
                      height: height,
                      width: width,
                      activities:
                          context.read<RegionDetailsCubit>().activityList,
                    );
                  },
                ),
                MapForDetails(
                  latLng: LatLng(model.latitude ?? 0, model.longitude ?? 0),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

void showSimple(BuildContext context, double lat, double lang) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupDialog(
          lang: lang,
          lat: lat,
          onPress: () {
            Navigator.pop(context);
          },
        );
      },
    );

class ImageViewer extends StatefulWidget {
  const ImageViewer({
    Key? key,
    required this.images,
    required this.file,
  }) : super(key: key);
  final List<String> images;
  final bool file;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: PageView.builder(
          controller: _pageController,
          pageSnapping: true,
          padEnds: false,
          itemBuilder: (context, index) {
            String imageUrl = widget.images[index];
            return Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  onTap: () {},
                  child: widget.file
                      ? Image.file(
                          File(imageUrl),
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "${NetworkConfigurations.BaseUrl}${imageUrl}",
                        ),
                ),
              ),
            );
          },
          itemCount: widget.images.length,
        ),
      );
    }
    return const Offstage();
  }
}
