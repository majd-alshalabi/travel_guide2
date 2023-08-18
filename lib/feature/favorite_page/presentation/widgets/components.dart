import 'package:flutter/material.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';

class ListOfFavorite extends StatelessWidget {
  const ListOfFavorite({
    super.key,
    required this.height,
    required this.width,
    required this.theme,
  });

  final double height;
  final double width;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.8,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10.0),
        itemCount: 5,
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) =>
                    //            ),);
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: Image.asset(
                          ImagesApp.imagesSyria,
                          width: width * 0.9,
                          height: height * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 50,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_rounded,
                              color: theme.red,
                              size: 74,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  AppLocalizations.of(context)?.translate("Place Name") ?? '',
                  style: StylesText.textStyleForTextFormTilte,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  AppLocalizations.of(context)?.translate("Location") ?? '',
                  style: StylesText.defaultTextStyle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
