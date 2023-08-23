import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/home_page/presentation/blocs/rate_cubit/rate_cubit.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class RatingApp extends StatefulWidget {
  const RatingApp({Key? key, required this.activityId}) : super(key: key);
  final int activityId;
  @override
  State<RatingApp> createState() => _RatingAppState();
}

class _RatingAppState extends State<RatingApp> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => RateCubit(),
      child: Builder(builder: (context) {
        return LoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: Center(
            child: SpinKitSpinningLines(
              color: theme.reserveDarkScaffold,
              size: 50.0,
            ),
          ),
          child: BlocListener<RateCubit, RateState>(
            listener: (context, state) {
              if (state is AddRateLoading) {
                context.loaderOverlay.show();
              } else if (state is AddRateLoaded) {
                context.loaderOverlay.hide();
                Utils.showCustomToast("add Rate done");
                Navigator.pop(context);
              } else if (state is AddRateError) {
                context.loaderOverlay.hide();
                Utils.showCustomToast("add Rate error");
              }
            },
            child: Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: theme.darkThemeForScafold,
                appBar: CustomAppBar(
                    title: AppLocalizations.of(context)?.translate('Rate_Us') ??
                        ""),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,

                        child: Lottie.asset(
                            'asset/images/json/FT2K8lxPsQ.json'),
                      ),
                    ),
                    Center(
                      child: PannableRatingBar(
                        rate: rating,
                        items: List.generate(
                            5,
                            (index) => RatingWidget(
                                  selectedColor: Colors.yellowAccent,
                                  unSelectedColor: theme.greyWeak,
                                  child: FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    size: 48,
                                    color: theme.greyWeak,
                                  ),
                                )),
                        onChanged: (value) {
                          setState(() {
                            rating = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Center(
                      child: CustomBottom(
                          text: AppLocalizations.of(context)
                                  ?.translate('Submit') ??
                              "",
                          height: 50,
                          buttonColor: Constant.primaryBodyColor,
                          onPress: () {
                            context
                                .read<RateCubit>()
                                .addRate(rating.floor(), widget.activityId);
                          },
                          borderColor: theme.darkThemeForScafold,
                          textStyleForButton: StylesText.textStyleForButton),
                    ),
                  ],
                )),
          ),
        );
      }),
    );
  }
}
