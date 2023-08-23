import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/account/presentation/my_profile_page/presentation/my_profile_page.dart';
import 'package:travel_guide/feature/add_places/presentation/add_places.dart';
import 'package:travel_guide/feature/details_page/presentation/cubits/book_mark_cubit/book_mark_cubit.dart';
import 'package:travel_guide/feature/details_page/presentation/page/details_activity_screen.dart';
import 'package:travel_guide/feature/details_page/presentation/page/details_region.dart';
import 'package:travel_guide/feature/favorite_page/presentation/screen/favorite_page.dart';
import 'package:travel_guide/feature/guides/presentation/pages/chat_page_for_guide.dart';
import 'package:travel_guide/feature/guides/presentation/pages/guides_page.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/main_page/presentation/blocs/main_cubit/main_cubit.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/feature/search_screen/presentation/search_screen.dart';
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
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: theme.reserveDarkScaffold, width: 1),
                ),
                child: Text(
                  AppLocalizations.of(context)?.translate('To Where') ?? "",
                  style: StylesText.newDefaultTextStyle
                      .copyWith(color: theme.reserveDarkScaffold),
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
                color: theme.accent2,
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

class ListOfPlaces extends StatelessWidget {
  const ListOfPlaces({
    super.key,
    required this.height,
    required this.width,
    required this.regions,
  });

  final double height;
  final double width;
  final List<RegionModel> regions;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        height: height * 0.18,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: regions.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsRegion(model: regions[index]),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: CachedNetworkImage(
                        width: width * 0.35,
                        height: height * 0.15,
                        imageUrl:
                            "${NetworkConfigurations.BaseUrl}${regions[index].images?.first.url}",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            ImagesApp.imagesSyria,
                            width: width * 0.35,
                            height: height * 0.15,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    regions[index].name ?? "",
                    style: StylesText.newDefaultTextStyle
                        .copyWith(color: theme.reserveDarkScaffold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListActivity extends StatelessWidget {
  const ListActivity({
    super.key,
    required this.height,
    required this.width,
    required this.activities,
  });

  final double height;
  final double width;
  final List<ActivityRemoteModel> activities;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        height: height * 0.19,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsActivitiesRegionScreen(
                              model: activities[index],
                            ),
                          ));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: CachedNetworkImage(
                            width: width * 0.35,
                            height: height * 0.15,
                            imageUrl:
                                "${NetworkConfigurations.BaseUrl}${activities[index].urls?.isNotEmpty ?? false ? activities[index].urls?.first.url : ""}",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                ImagesApp.imagesSyria,
                                width: width * 0.35,
                                height: height * 0.15,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Positioned(
                            top: 10,
                            right: 10,
                            child: BlocBuilder<BookMarkCubit, BookMarkState>(
                              buildWhen: (previous, current) {
                                if (current is AddToBookMarkLoaded &&
                                    activities[index].id == current.id) {
                                  activities[index].bookmarked = current.added;
                                  return true;
                                }
                                return false;
                              },
                              builder: (context, state) {
                                return LikeButton(
                                  isLiked: activities[index].bookmarked,
                                  onTap: (isLiked) async {
                                    context.read<BookMarkCubit>().addToBookMark(
                                          activities[index].id ?? -1,
                                        );
                                    return true;
                                  },
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  size: 20,
                                  circleColor: CircleColor(
                                      start: Color(0xffffffff),
                                      end: Color(0xffffffff)),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                );
                              },
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    activities[index].name ?? "",
                    style: StylesText.newDefaultTextStyle
                        .copyWith(color: theme.reserveDarkScaffold),
                  ),
                  Text(
                    activities[index].region?.name ?? "",
                    style: StylesText.newDefaultTextStyle
                        .copyWith(color: theme.reserveDarkScaffold),
                  ),
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
      backgroundColor: theme.darkThemeForScafold,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 13.h,
            padding: EdgeInsets.only(top: 3.h),
            color: theme.accent2,
            child: Center(
              child: ListTile(
                leading: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(),
                      )),
                  child: TravelGuideUserAvatar(
                    width: 13.w,
                    imageUrl: ImagesApp.imagesUserAvatarUserAvatarImage,
                  ),
                ),
                title: Text(
                  AppSettings().identity?.name ??
                      AppLocalizations.of(context)?.translate('login') ??
                      "",
                  style: StylesText.newDefaultTextStyle.copyWith(
                    color: theme.darkThemeForScafold,
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
          if (AppSettings().identity?.guide == UserType.guide)
            ListTile(
              leading: Icon(
                Icons.add_rounded,
                color: theme.black,
              ),
              title: Text(
                AppLocalizations.of(context)?.translate('add_places') ?? "",
                style: StylesText.newDefaultTextStyle.copyWith(
                  color: theme.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPlaces(),
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
              Icons.groups_outlined,
              color: theme.black,
            ),
            title: Text(
              AppSettings().identity?.guide == UserType.guide
                  ? AppLocalizations.of(context)?.translate('chat') ?? ""
                  : AppLocalizations.of(context)?.translate('guides') ?? "",
              style: StylesText.newDefaultTextStyle.copyWith(
                color: theme.black,
              ),
            ),
            onTap: () {
              if (AppSettings().identity?.guide == UserType.guide) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPageForGuide(),
                    ));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GuidesPage(),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: theme.black,
            ),
            title: Text(
              AppLocalizations.of(context)?.translate('logout') ?? "",
              style: StylesText.newDefaultTextStyle.copyWith(
                color: theme.black,
              ),
            ),
            onTap: () {
              context.read<MainCubit>().logout();
            },
          ),
        ],
      ),
    );
  }
}

class PopupMap extends StatelessWidget {
  const PopupMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
