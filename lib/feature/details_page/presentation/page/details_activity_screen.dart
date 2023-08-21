import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/feature/details_page/presentation/page/details_region.dart';
import 'package:travel_guide/feature/details_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/home_page/all_activity.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';

class DetailsActivitiesRegionScreen extends StatelessWidget {
  const DetailsActivitiesRegionScreen({Key? key, required this.model})
      : super(key: key);
  final ActivityRemoteModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ImageViewer(
                  images: model.urls?.map((e) => e.url ?? "").toList() ?? [],
                  file: false,
                ),
                Positioned(
                  right: 20,
                  bottom: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        shape: BoxShape.circle),
                    child: LikeButton(
                      size: 40,
                      animationDuration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.zero,
                      onTap: (isLiked) async {
                        return true;
                      },
                    ),
                  ),
                ),
              ],
            ),
            AdsCommentLikeFav(adsData: model),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  LocationInformation(
                    name: model.city?.name ?? "",
                    type: model.type ?? "",
                    rate: model.rating.toString(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.name ?? "",
                          style: StylesText.newDefaultTextStyle.copyWith(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "${model.price}\$",
                          style: StylesText.newDefaultTextStyle
                              .copyWith(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      model.description ?? "",
                      style: StylesText.newDefaultTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  MapForDetails(
                    latLng: LatLng(model.latitude ?? 0, model.longitude ?? 0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
