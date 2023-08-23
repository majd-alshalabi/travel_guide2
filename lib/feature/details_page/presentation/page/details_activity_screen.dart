import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/details_page/presentation/page/details_region.dart';
import 'package:travel_guide/feature/details_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/details_page/presentation/widgets/tts.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/home_page/all_activity.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class DetailsActivitiesRegionScreen extends StatelessWidget {
  const DetailsActivitiesRegionScreen({Key? key, required this.model})
      : super(key: key);
  final ActivityRemoteModel model;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
      backgroundColor: theme.darkThemeForScafold,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ImageViewer(
                    images: model.urls?.map((e) => e.url ?? "").toList() ?? [],
                    file: false,
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  child: TravelGuideTTS(description: model.description ?? ""),
                ),
                Positioned(
                  left: 10,
                  top: 50,
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  LocationInformation(
                    activityId: model.id ?? -1,
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
                            color: theme.reserveDarkScaffold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "${model.price}\$",
                          style: StylesText.newDefaultTextStyle
                              .copyWith(fontSize: 15, color: theme.reserveDarkScaffold),
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
                          .copyWith(color: theme.reserveDarkScaffold),
                    ),
                  ),
                  if ((model.urls?.length ?? 0) > 1)
                    MediaQuery.removePadding(
                      removeLeft: true,
                      context: context,
                      removeRight: true,
                      child: GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        itemCount: model.urls?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                            height: MediaQuery.of(context).size.width * 0.1,
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: NetworkConfigurations.BaseUrl +
                                    (model.urls?[index].url ?? "")),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                      ),
                    ),
                  AdsCommentLikeFav(adsData: model),
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
