import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/home_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom != 0 ? 0 : 8.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
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
                  Container(
                    child: searchWithNotifications(
                      width: width,
                      searchController: searchController,
                      theme: theme,
                    ),
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
      ),
    );
  }
}
