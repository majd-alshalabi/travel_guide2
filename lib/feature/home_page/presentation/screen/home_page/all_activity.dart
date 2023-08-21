import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/comment_page/presentation/comment_page.dart';
import 'package:travel_guide/feature/details_page/presentation/page/details_activity_screen.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_activity_use_case.dart';
import 'package:travel_guide/feature/home_page/presentation/blocs/all_activity_bloc/get_all_ads_bloc.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class AllActivityPage extends StatelessWidget {
  AllActivityPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllAdsBloc()..add(GetNewAdsEvents()),
      child: Builder(builder: (context) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            AppTheme theme = sl<ThemeCubit>().globalAppTheme;

            return Scaffold(
              backgroundColor: theme.darkThemeForScafold,
              appBar: AppBar(
                iconTheme: IconThemeData(color: theme.black),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                title: Text(
                  "all activity",
                  style: StylesText.newTextStyleForAppBar
                      .copyWith(color: theme.black),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                child: RefreshIndicator(
                  color: theme.mainAppColor,
                  onRefresh: () async {
                    final result = await GetAllActivityUseCase().call(
                      GetActivityParamsModel(page: 1),
                    );
                    result.fold(
                      (l) => context
                          .read<GetAllAdsBloc>()
                          .add(UpdateAllPostPage(list: const [])),
                      (r) {
                        context
                            .read<GetAllAdsBloc>()
                            .add(UpdateAllPostPage(list: r.data?.data ?? []));
                      },
                    );
                  },
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      BlocBuilder<GetAllAdsBloc, GetAllAdsState>(
                        buildWhen: (previous, current) {
                          if (current is CompleteGetAllAds) return true;
                          if (current is LoadingGetAllAds) return true;
                          if (current is ErrorGetAllAds) return true;
                          if (current is GetAllAdsDeleteAdsLoaded) {
                            return true;
                          }
                          return false;
                        },
                        bloc: context.read<GetAllAdsBloc>(),
                        builder: (context, state) {
                          if (state is LoadingGetAllAds) {
                            return const AllActivityLoadingWidget();
                          }
                          return context
                                  .read<GetAllAdsBloc>()
                                  .listOfAllAds
                                  .isEmpty
                              ? Container(
                                  height: 60.h,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "no data to show",
                                        style: StylesText.newDefaultTextStyle
                                            .copyWith(color: Colors.blue),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<GetAllAdsBloc>()
                                              .add(ReGetEvent());
                                        },
                                        child: Text(
                                          "try again",
                                          style: StylesText.newDefaultTextStyle
                                              .copyWith(
                                                  color: theme.mainAppColor),
                                        ),
                                      )
                                    ],
                                  ))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  cacheExtent: 99999999,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        context
                                            .read<GetAllAdsBloc>()
                                            .listOfAllAds
                                            .length) {
                                      return GettingNewAdsTheWholeWidget(
                                        theme: theme,
                                      );
                                    }
                                    return ItemBuilder(
                                      adsData: context
                                          .read<GetAllAdsBloc>()
                                          .listOfAllAds[index],
                                    );
                                  },
                                  itemCount: context
                                          .read<GetAllAdsBloc>()
                                          .listOfAllAds
                                          .length +
                                      1,
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class ItemBuilder extends StatelessWidget {
  final ActivityRemoteModel adsData;
  const ItemBuilder({
    super.key,
    required this.adsData,
  });
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsActivitiesRegionScreen(model: adsData),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * .1,
        ),
        decoration: BoxDecoration(
          color: theme.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdsContainerHeaderWidget(
                theme: theme,
                data: adsData,
              ),

              const SizedBox(height: 10),
              ImagesSection(
                theme: theme,
                images: (adsData.urls ?? []).map((e) => e.url ?? "").toList(),
              ),
              if (adsData.urls?.isNotEmpty ?? true) const SizedBox(height: 10),
              Text(
                "${adsData.name}",
                style:
                    StylesText.newDefaultTextStyle.copyWith(color: theme.black),
              ),
              AdsCommentLikeFav(adsData: adsData),
              // CommentInHomeContainer(
              //   comment: (adsData.comment ?? []).isEmpty
              //       ? null
              //       : adsData.comment?.first,
              //   theme: theme,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdsContainerHeaderWidget extends StatelessWidget {
  const AdsContainerHeaderWidget({
    Key? key,
    required this.theme,
    required this.data,
  }) : super(key: key);
  final AppTheme theme;
  final ActivityRemoteModel data;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SettAlKolUserAvatar(
          width: 10.w,
          imageUrl: data.admin?.image ?? "",
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 55.w,
          child: Text(
            data.admin?.name ?? "user",
            style: StylesText.newDefaultTextStyle.copyWith(
              color: theme.black,
            ),
          ),
        ),
      ],
    );
  }
}

class ImagesSection extends StatelessWidget {
  const ImagesSection({Key? key, required this.theme, required this.images})
      : super(key: key);
  final AppTheme theme;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const Offstage();
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
          height: 30.h,
          child: MasonryGridView.count(
            crossAxisCount: images.length > 1 ? 2 : 1,
            shrinkWrap: true,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            itemCount: images.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index != 2) {
                return SizedBox(
                  height: index == 0 || (index == 1 && images.length == 2)
                      ? 35.h
                      : 17.4.h,
                  child: InkWell(
                    onTap: () {},
                    child: CachedNetworkImage(
                      imageUrl:
                          "${NetworkConfigurations.BaseUrl}${images[index]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                int extraImage = images.length - 3;
                return SizedBox(
                  height: index == 0 ? 35.h : 17.4.h,
                  child: InkWell(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl:
                                "${NetworkConfigurations.BaseUrl}${images[index]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (extraImage > 0)
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            child: Text(
                              "+$extraImage",
                              style: StylesText.defaultTextStyle.copyWith(
                                color: theme.white,
                                fontSize: 15,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }
            },
          )),
    );
  }
}

class GettingNewAdsTheWholeWidget extends StatelessWidget {
  const GettingNewAdsTheWholeWidget({Key? key, required this.theme})
      : super(key: key);
  final AppTheme theme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder(
        bloc: context.read<GetAllAdsBloc>(),
        buildWhen: (previous, current) {
          if (current is GettingNewPageLoading) {
            return true;
          }
          if (current is CompleteGetAllAds) {
            return true;
          }
          if (current is ErrorGetAllAds) return true;
          return false;
        },
        builder: (context, state) {
          if (context.read<GetAllAdsBloc>().lastPage) {
            return Center(
              child: Text(
                "no more places",
                style: StylesText.newDefaultTextStyle
                    .copyWith(color: Colors.black),
              ),
            );
          }
          if (state is GettingNewPageLoading) {
            return LoadingWhileGettingAds(
              theme: theme,
            );
          }
          return GetNewAdsButton(
            theme: theme,
          );
        },
      ),
    );
  }
}

class LoadingWhileGettingAds extends StatelessWidget {
  const LoadingWhileGettingAds({Key? key, required this.theme})
      : super(key: key);
  final AppTheme theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.reserveDarkScaffold,
          width: 1,
        ),
      ),
      child: CircularProgressIndicator(
        color: theme.black,
        strokeWidth: 1,
      ),
    );
  }
}

class GetNewAdsButton extends StatelessWidget {
  const GetNewAdsButton({Key? key, required this.theme}) : super(key: key);
  final AppTheme theme;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<GetAllAdsBloc>().add(
              GetNewAdsEvents(),
            );
      },
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.reserveDarkScaffold,
            width: 1,
          ),
        ),
        child: Icon(
          Icons.add,
          color: theme.black,
        ),
      ),
    );
  }
}

class AdsCommentLikeFav extends StatelessWidget {
  const AdsCommentLikeFav({Key? key, required this.adsData}) : super(key: key);
  final ActivityRemoteModel adsData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CommentPage(activityId: adsData.id ?? -1),
                ),
              );
            },
            child: const FaIcon(FontAwesomeIcons.comments, size: 20),
          ),
          const SizedBox(width: 10),
          Text(
            adsData.comments.toString(),
            style: StylesText.defaultTextStyle,
          ),
        ],
      ),
    );
  }
}
