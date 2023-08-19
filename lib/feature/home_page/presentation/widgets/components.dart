import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/favorite_page/presentation/screen/favorite_page.dart';
import 'package:travel_guide/feature/guides/presentation/pages/guides_page.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/feature/setting_page/presentation/screens/sitting_page.dart';
import 'package:travel_guide/injection.dart';

class searchWithNotifications extends StatelessWidget {
  const searchWithNotifications({
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                hintStyle: StylesText.textStyleForDescription
                    .copyWith(color: theme.reserveDarkScaffold, fontSize: 18),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  size: 35,
                  color: theme.reserveDarkScaffold,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: theme.reserveDarkScaffold,
                      width: 2,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: theme.reserveDarkScaffold,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: theme.darkThemeForScafold,
            radius: 25,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.notifications,
                size: 25,
              ),
              color: theme.reserveDarkScaffold,
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
                          child: LikeButton(
                            size: 20,
                            circleColor: CircleColor(
                                start: Color(0xffffffff),
                                end: Color(0xffffffff)),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    'Place Name',
                    style: StylesText.defaultTextStyleForAnotherModel,
                  ),
                  Text(AppLocalizations.of(context)?.translate("Location") ??
                      ''),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DrawerHome extends StatelessWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Drawer(
      width: 50.w,
      backgroundColor: theme.greyWeak,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 13.h,
            padding: EdgeInsets.only(top: 3.h),
            color: theme.white,
            child: Center(
              child: ListTile(
                leading: TravelGuideUserAvatar(
                  width: 13.w,
                  imageUrl: ImagesApp.imagesUserAvatarUserAvatarImage,
                ),
                title: Text(
                  AppSettings().identity?.name ?? "login",
                  style: StylesText.newDefaultTextStyle.copyWith(
                    color: theme.black,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: theme.black,
            ),
            title: Text(
              AppLocalizations.of(context)?.translate('settings') ?? "",
              style: StylesText.newDefaultTextStyle.copyWith(
                color: theme.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.favorite_border_outlined,
              color: theme.black,
            ),
            title: Text(
              AppLocalizations.of(context)?.translate('favorite') ?? "",
              style: StylesText.newDefaultTextStyle.copyWith(
                color: theme.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_pin_circle_outlined,
              color: theme.black,
            ),
            title: Text(
              AppLocalizations.of(context)?.translate('guides') ?? "",
              style: StylesText.newDefaultTextStyle.copyWith(
                color: theme.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GuidesPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
