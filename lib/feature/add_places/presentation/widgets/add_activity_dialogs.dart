import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/add_places/presentation/blocs/activity_cubit/activity_cubit.dart';
import 'package:travel_guide/feature/add_places/presentation/blocs/upload_image_cubit/upload_image_cubit.dart';
import 'package:travel_guide/feature/add_places/presentation/widgets/create_place_attachment_widget.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';
import 'package:travel_guide/injection.dart';

class AddCityDialog extends StatefulWidget {
  const AddCityDialog({Key? key}) : super(key: key);
  @override
  State<AddCityDialog> createState() => _AddCityDialogState();
}

class _AddCityDialogState extends State<AddCityDialog> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
            size: 50.0,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.25,
            child: BlocListener(
              bloc: sl<ActivityCubit>(),
              listener: (context, state) {
                if (state is AddCityError) {
                  Utils.showCustomToast("error while adding city");
                  context.loaderOverlay.hide();
                } else if (state is AddCityLoading) {
                  context.loaderOverlay.show();
                } else if (state is AddCityLoaded) {
                  context.loaderOverlay.hide();
                  Navigator.pop(context);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Form(
                    key: formKey,
                    child: CustomAddTextField(
                      type: TextInputType.text,
                      color: Colors.black,
                      controllerName: controller,
                      label: "name",
                      valedate: (String val) {
                        if (val.isEmpty) {
                          return "field must not be empty";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        gradient: Constant.primaryBodyColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextButton(
                        child: Text(
                          "Add",
                          style: StylesText.newDefaultTextStyle
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            sl<ActivityCubit>().addCity(controller.text);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddRegionDialog extends StatefulWidget {
  const AddRegionDialog({Key? key, required this.cityId}) : super(key: key);
  final int cityId;
  @override
  State<AddRegionDialog> createState() => _AddRegionDialogState();
}

class _AddRegionDialogState extends State<AddRegionDialog> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var formKey = GlobalKey<FormState>();
  double lat = 0;
  double lang = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadImageCubit("region")..initState([]),
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: LoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: const Center(
              child: SpinKitSpinningLines(
                color: Colors.white,
                size: 50.0,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.9,
                child: BlocListener(
                  bloc: sl<ActivityCubit>(),
                  listener: (context, state) {
                    if (state is AddRegionError) {
                      Utils.showCustomToast("error while adding region");
                      context.loaderOverlay.hide();
                    } else if (state is AddRegionLoading) {
                      context.loaderOverlay.show();
                    } else if (state is AddRegionLoaded) {
                      context.loaderOverlay.hide();
                      Navigator.pop(context);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Form(
                        key: formKey,
                        child: CustomAddTextField(
                          type: TextInputType.text,
                          color: Colors.black,
                          controllerName: controller,
                          label: "name",
                          valedate: (String val) {
                            if (val.isEmpty) {
                              return "field must not be empty";
                            }
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CreateActivityAttachmentSection(smallSize: true),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        padding: const EdgeInsets.all(8),
                        child: AddMapScreen(
                          gesture: true,
                          onTap: (argument) {
                            lat = argument.target.latitude;
                            lang = argument.target.longitude;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            gradient: Constant.primaryBodyColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextButton(
                            child: Text(
                              "Add",
                              style: StylesText.newDefaultTextStyle
                                  .copyWith(color: Colors.white),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                sl<ActivityCubit>().addRegion(
                                  controller.text,
                                  widget.cityId,
                                  context
                                      .read<UploadImageCubit>()
                                      .attachments
                                      .map((e) => e.url ?? "")
                                      .toList(),
                                  lat,
                                  lang,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
