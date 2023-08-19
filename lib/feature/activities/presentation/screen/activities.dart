import 'package:flutter/material.dart';
import 'package:travel_guide/feature/details_page/presentation/widgets/components.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/themes.dart';
import '../../../../injection.dart';
import '../../../other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;

    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.mainAppColor,
      ),
      body: SizedBox(
        width: width,
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: 50,
          itemBuilder: (context, index) {
            return ActivitysOfRegion(
              width: width,
              height: height,
              theme: theme,
              image: ImagesApp.imagesSyria1,
            );
          },
        ),
      ),
    );
  }
}
