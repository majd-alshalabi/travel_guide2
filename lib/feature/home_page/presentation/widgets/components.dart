import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';

class CustomText extends StatelessWidget {
  final String titleName;
  final TextStyle textStyleForTextTilte;
  final TextStyle defaultTextStyle;
  final Function onTap;
  CustomText({
    super.key,
    required this.titleName,
    required this.onTap,
    required this.textStyleForTextTilte,
    required this.defaultTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleName,
            style: textStyleForTextTilte,
          ),
          InkWell(
            onTap: () {
              onTap();
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)?.translate('See all') ?? "",
                    style: defaultTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class searchWithNotifcations extends StatelessWidget {
  const searchWithNotifcations({
    super.key,
    required this.width,
    required this.searchController,
    required this.theme,
  });

  final double width;
  final TextEditingController searchController;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: width * 0.8,
            height: 60,
            child: TextField(
              controller: searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)?.translate('To Where') ?? "",
                hintStyle: StylesText.textStyleForTextFormTilte,
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  size: 35,
                  color: theme.black,
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: theme.black,
            radius: 25,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.notifications,
                size: 25,
              ),
              color: theme.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class ListOfImages extends StatelessWidget {
  const ListOfImages({
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
                            width: width * 0.35,
                            height: height * 0.15,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            Icons.favorite_outline_sharp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Place Name',
                    style: StylesText.textStyleForTextFormTilte,
                  ),
                  Text('Location'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
