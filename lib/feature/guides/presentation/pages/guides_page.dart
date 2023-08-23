import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/guides/presentation/cubits/guides_cubit/guides_cubit.dart';
import 'package:travel_guide/feature/guides/presentation/widget/components.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class GuidesPage extends StatelessWidget {
  const GuidesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => GuidesCubit()..getAllGuide(),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: theme.darkThemeForScafold,
            appBar: CustomAppBar(
              title: AppLocalizations.of(context)?.translate('guides') ?? "",
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<GuidesCubit>().getAllGuide();
              },
              child: BlocBuilder<GuidesCubit, GuidesState>(
                buildWhen: (previous, current) {
                  if (current is GuidesError) return true;
                  if (current is GuidesLoading) return true;
                  if (current is GuidesLoaded) return true;
                  return false;
                },
                builder: (context, state) {
                  if (state is GuidesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GuidesError) {
                    return Center(
                      child: Text(
                        "error while loading",
                        style: StylesText.newDefaultTextStyle
                            .copyWith(color: theme.reserveDarkScaffold),
                      ),
                    );
                  } else if (context.read<GuidesCubit>().guides.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "there is not guide currently",
                          style: StylesText.newDefaultTextStyle
                              .copyWith(color: theme.reserveDarkScaffold),
                        ),
                        InkWell(
                          onTap: () =>
                              context.read<GuidesCubit>().getAllGuide(),
                          child: Text(
                            "try again",
                            style: StylesText.newDefaultTextStyle
                                .copyWith(color: theme.reserveDarkScaffold),
                          ),
                        ),
                      ],
                    ));
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) => GuideItem(
                      guide: context.read<GuidesCubit>().guides[index],
                    ),
                    itemCount: context.read<GuidesCubit>().guides.length,
                  );
                },
              ),
            ));
      }),
    );
  }
}
