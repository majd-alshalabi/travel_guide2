import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/details_page/presentation/page/details_activity_screen.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';

class ListOfFavorite extends StatelessWidget {
  const ListOfFavorite({
    super.key,
    required this.height,
    required this.width,
    required this.theme,
    required this.list,
  });

  final double height;
  final double width;
  final AppTheme theme;
  final List<ActivityRemoteModel> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.8,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10.0),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            height: height * 0.8,
            width: width,
            padding: const EdgeInsets.only(right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetailsActivitiesRegionScreen(
                          model: list[index],
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: CachedNetworkImage(
                      imageUrl: NetworkConfigurations.BaseUrl +
                          (list[index].urls?.first.url ?? ""),
                      width: width * 0.9,
                      height: height * 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  list[index].name ?? "",
                  style: StylesText.newDefaultTextStyle
                      .copyWith(color: theme.black),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  list[index].region?.name ?? "",
                  style: StylesText.newDefaultTextStyle
                      .copyWith(color: theme.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
