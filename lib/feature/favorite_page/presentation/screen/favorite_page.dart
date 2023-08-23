import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/details_page/presentation/cubits/book_mark_cubit/book_mark_cubit.dart';
import 'package:travel_guide/feature/favorite_page/presentation/widgets/components.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<BookMarkCubit>().getBookMark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;

    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: theme.darkThemeForScafold,
      appBar: CustomAppBar(title: AppLocalizations.of(context)?.translate('favorite')??""),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              AppLocalizations.of(context)?.translate("favorite") ?? '',
              style: StylesText.textStyleForTitle.copyWith(color: theme.reserveDarkScaffold),
            ),
          ),
          BlocBuilder<BookMarkCubit, BookMarkState>(
            buildWhen: (previous, current) {
              if (current is GetBookMarkedLoaded) {
                return true;
              } else if (current is GetBookMarkedError)
                return true;
              else if (current is GetBookMarkedLoading) return true;

              return false;
            },
            builder: (context, state) {
              if (state is GetBookMarkedLoading)
                return Center(child: CircularProgressIndicator());
              if (context.read<BookMarkCubit>().bookmarked.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)?.translate('no_data_to_show')??"",
                        style: StylesText.newDefaultTextStyle
                            .copyWith(color: theme.accent2),
                      ),
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)?.translate('try_again')??"",
                          style: StylesText.newDefaultTextStyle
                              .copyWith(color: theme.accent2),
                        ),
                        onPressed: () {
                          context.read<BookMarkCubit>().getBookMark();
                        },
                      ),
                    ],
                  ),
                );
              }
              return ListOfFavorite(
                list: context.read<BookMarkCubit>().bookmarked,
                height: height,
                width: width,
                theme: theme,
              );
            },
          ),
        ],
      ),
    );
  }
}
