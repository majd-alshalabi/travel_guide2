import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/home_page/presentation/blocs/home_bloc.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/home_page/all_activity.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';
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
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(GetAllRegionEvent())
        ..add(GetNearbyActivityEvent())
        ..add(GetTopRatedActivityEvent())
        ..add(GetAllActivityEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: theme.darkThemeForScafold,
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: EdgeInsets.only(
                bottom:
                    MediaQuery.of(context).viewInsets.bottom != 0 ? 0 : 9.h),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>()
                  ..add(GetAllRegionEvent())
                  ..add(GetNearbyActivityEvent())
                  ..add(GetTopRatedActivityEvent())
                  ..add(GetAllActivityEvent());
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: MapScreen(
                            gesture: false,
                            onTap: (argument) {},
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
                          AppLocalizations.of(context)?.translate("region") ??
                              "",
                      onTap: () {},
                      seeAllButton: false,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) {
                        if (current is GetAllRegionLoading) return true;
                        if (current is GetAllRegionLoaded) return true;
                        if (current is GetAllRegionError) return true;
                        return false;
                      },
                      builder: (context, state) {
                        if (state is GetAllRegionLoading)
                          return HomeLoadingWidget();
                        if (context.read<HomeBloc>().regionList.isEmpty) {
                          return Column(
                            children: [
                              Text("no data to show"),
                              TextButton(
                                child: Text("try again"),
                                onPressed: () {
                                  context.read<HomeBloc>().add(
                                        GetAllRegionEvent(),
                                      );
                                },
                              ),
                            ],
                          );
                        }
                        return ListOfPlaces(
                          height: height,
                          width: width,
                          regions: context.read<HomeBloc>().regionList,
                        );
                      },
                    ),
                    CustomText(
                      titleName: AppLocalizations.of(context)
                              ?.translate("Top rating") ??
                          "",
                      onTap: () {},
                      seeAllButton: false,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) {
                        if (current is GetTopRatedLoaded) return true;
                        if (current is GetTopRatedError) return true;
                        if (current is GetTopRatedLoading) return true;
                        return false;
                      },
                      builder: (context, state) {
                        if (state is GetTopRatedLoading)
                          return HomeLoadingWidget();
                        if (context.read<HomeBloc>().topRated.isEmpty) {
                          return Column(
                            children: [
                              Text("no data to show"),
                              TextButton(
                                child: Text("try again"),
                                onPressed: () {
                                  context.read<HomeBloc>().add(
                                        GetTopRatedActivityEvent(),
                                      );
                                },
                              ),
                            ],
                          );
                        }
                        return ListActivity(
                          height: height,
                          width: width,
                          activities: context.read<HomeBloc>().topRated,
                        );
                      },
                    ),
                    CustomText(
                      titleName: AppLocalizations.of(context)
                              ?.translate("Nearby places") ??
                          "",
                      onTap: () {},
                      seeAllButton: false,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) {
                        if (current is GetNearByError) return true;
                        if (current is GetNearByLoaded) return true;
                        if (current is GetNearByLoading) return true;
                        return false;
                      },
                      builder: (context, state) {
                        if (state is GetNearByLoading)
                          return HomeLoadingWidget();
                        if (context.read<HomeBloc>().nearby.isEmpty) {
                          return Column(
                            children: [
                              Text("no data to show"),
                              TextButton(
                                child: Text("try again"),
                                onPressed: () {
                                  context.read<HomeBloc>().add(
                                        GetNearbyActivityEvent(),
                                      );
                                },
                              ),
                            ],
                          );
                        }
                        return ListActivity(
                          height: height,
                          width: width,
                          activities: context.read<HomeBloc>().nearby,
                        );
                      },
                    ),
                    CustomText(
                      titleName: AppLocalizations.of(context)
                              ?.translate("all places") ??
                          "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllActivityPage(),
                          ),
                        );
                      },
                      seeAllButton: true,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) {
                        if (current is GetAllActivityLoading) return true;
                        if (current is GetAllActivityLoaded) return true;
                        if (current is GetAllActivityError) return true;
                        return false;
                      },
                      builder: (context, state) {
                        if (state is GetAllActivityLoading)
                          return HomeLoadingWidget();
                        if (context.read<HomeBloc>().activityList.isEmpty) {
                          return Column(
                            children: [
                              Text("no data to show"),
                              TextButton(
                                child: Text("try again"),
                                onPressed: () {
                                  context.read<HomeBloc>().add(
                                        GetAllActivityEvent(),
                                      );
                                },
                              ),
                            ],
                          );
                        }
                        return ListActivity(
                          height: height,
                          width: width,
                          activities: context.read<HomeBloc>().activityList,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
