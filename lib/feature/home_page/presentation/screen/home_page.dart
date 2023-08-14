import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/home_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController searchController = TextEditingController();

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.35,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          ImagesApp.imagesRedSyriaMapPoster,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  searchWithNotifcations(
                    width: width,
                    searchController: searchController,
                    theme: theme,
                  ),
                ],
              ),
              CustomText(
                titleName:
                    AppLocalizations.of(context)?.translate("Places") ?? "",
                onTap: () {},
                textStyleForTextTilte: StylesText.textStyleForTextTilte,
                defaultTextStyle: StylesText.defaultTextStyle,
              ),
              ListOfImages(
                height: height,
                width: width,
              ),
              CustomText(
                titleName:
                    AppLocalizations.of(context)?.translate("Top search") ?? "",
                onTap: () {},
                textStyleForTextTilte: StylesText.textStyleForTextTilte,
                defaultTextStyle: StylesText.defaultTextStyle,
              ),
              ListOfImages(
                height: height,
                width: width,
              ),
              CustomText(
                titleName:
                    AppLocalizations.of(context)?.translate("Top rating") ?? "",
                onTap: () {},
                textStyleForTextTilte: StylesText.textStyleForTextTilte,
                defaultTextStyle: StylesText.defaultTextStyle,
              ),
              ListOfImages(
                height: height,
                width: width,
              ),
              CustomText(
                titleName:
                    AppLocalizations.of(context)?.translate("Nearby places") ??
                        "",
                onTap: () {},
                textStyleForTextTilte: StylesText.textStyleForTextTilte,
                defaultTextStyle: StylesText.defaultTextStyle,
              ),
              ListOfImages(
                height: height,
                width: width,
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.search_sharp, size: 30),
            Icon(Icons.location_searching, size: 30),
            Icon(Icons.favorite_border, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: theme.white,
          buttonBackgroundColor: theme.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOutCirc,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) {},
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
