import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/home_page/all_activity.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/feature/search_page/presentation/bloc/search_bloc.dart';
import 'package:travel_guide/injection.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: theme.darkThemeForScafold,
          appBar: AppBar(
            leadingWidth: 6.w,
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color:
                      theme.reserveDarkScaffold, // Set your desired color here
                ),
            backgroundColor: theme.darkAndWhiteForAppBar,
            title: TextField(
              onSubmitted: (value) {
                context.read<SearchBloc>().add(
                      NewSearchEvents(
                        name: value,
                      ),
                    );
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)?.translate('Search') ?? "",
                hintStyle: StylesText.newTextStyleForAppBar.copyWith(
                  color: theme.greyWeak,
                  fontSize: 20,
                ),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: theme.reserveDarkScaffold,
                  ),
                  onPressed: () {
                    searchController.clear();
                    context.read<SearchBloc>().add(
                          SelectType(
                            type: null,
                            name: searchController.text,
                          ),
                        );
                  },
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 10.0,
              top: 10,
            ),
            child: BlocBuilder<SearchBloc, SearchState>(
              buildWhen: (previous, current) {
                if (current is SearchLoaded) return true;
                if (current is SearchLoading) return true;
                if (current is SearchError) return true;
                if (current is SearchError) return true;
                return false;
              },
              bloc: context.read<SearchBloc>(),
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const AllActivityLoadingWidget();
                }
                return context.read<SearchBloc>().listOfAllAds.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                    ?.translate('no data to show') ??
                                "",
                            style: StylesText.defaultTextStyle,
                          ),
                        ],
                      ))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return BlocBuilder<SearchBloc, SearchState>(
                            buildWhen: (previous, current) {
                              if (current is UpdateAdsInSearchCommentCount &&
                                  current.adsId ==
                                      context
                                          .read<SearchBloc>()
                                          .listOfAllAds[index]
                                          .id) {
                                return true;
                              } else if (current is AddToFavoriteLoaded &&
                                  current.id ==
                                      context
                                          .read<SearchBloc>()
                                          .listOfAllAds[index]
                                          .id) {
                                return true;
                              }
                              return false;
                            },
                            builder: (context, state) {
                              return ItemBuilder(
                                adsData: context
                                    .read<SearchBloc>()
                                    .listOfAllAds[index],
                              );
                            },
                          );
                        },
                        itemCount:
                            context.read<SearchBloc>().listOfAllAds.length,
                      );
              },
            ),
          ),
        );
      }),
    );
  }
}
