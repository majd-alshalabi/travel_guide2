import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/constants/enums.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/add_places/presentation/blocs/activity_cubit/activity_cubit.dart';
import 'package:travel_guide/feature/add_places/presentation/blocs/upload_image_cubit/upload_image_cubit.dart';
import 'package:travel_guide/feature/add_places/presentation/widgets/add_activity_dialogs.dart';
import 'package:travel_guide/feature/add_places/presentation/widgets/add_place_widgets.dart';
import 'package:travel_guide/feature/add_places/presentation/widgets/create_place_attachment_widget.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';
import 'package:travel_guide/injection.dart';

class AddPlaces extends StatefulWidget {
  const AddPlaces({Key? key}) : super(key: key);

  @override
  State<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    sl<ActivityCubit>().initState();
    super.initState();
  }

  List<CityModel> citiesList = [];
  List<RegionModel> regionsList = [];
  String? selectedCity;
  String? selectedType;
  String? selectedRegion;
  var formKey = GlobalKey<FormState>();
  double lat = 33.510414;
  double lang = 36.278336;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add place"),
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
            size: 50.0,
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    UploadImageCubit("activity")..initState([]),
              ),
            ],
            child: Builder(builder: (context) {
              return BlocListener(
                bloc: sl<ActivityCubit>(),
                listener: (context, state) {
                  if (state is AddActivityLoaded) {
                    nameController.clear();
                    descriptionController.clear();
                    priceController.clear();
                    context.read<UploadImageCubit>().clearList();
                    context.loaderOverlay.hide();
                  } else if (state is AddActivityError) {
                    Utils.showCustomToast("error while adding");
                    context.loaderOverlay.hide();
                  } else if (state is AddActivityLoading) {
                    context.loaderOverlay.show();
                  }
                },
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomAddTextField(
                            type: TextInputType.text,
                            color: Colors.black,
                            controllerName: nameController,
                            label: "name",
                            valedate: (String val) {
                              if (val.isEmpty) {
                                return "name must be not Empty";
                              }
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              CreateActivityAttachmentSection(smallSize: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropDownTextField(
                            selectedOption: selectedType,
                            hintText: "type",
                            options: Constant.type,
                            onChanged: (value) {
                              selectedType = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomDescriptionTextField(
                            type: TextInputType.text,
                            color: Colors.black,
                            controllerName: descriptionController,
                            label: "description",
                            valedate: (String val) {
                              if (val.isEmpty) {
                                return "description must be not Empty";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomAddTextField(
                            type: TextInputType.text,
                            color: Colors.black,
                            controllerName: priceController,
                            label: "price",
                            valedate: (String val) {
                              if (val.isEmpty) {
                                return "price must be not Empty";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: BlocBuilder(
                                  bloc: sl<ActivityCubit>(),
                                  buildWhen: (previous, current) {
                                    if (current is GetAllCityLoaded) {
                                      citiesList = current.cities;
                                      return true;
                                    } else if (current is AddCityLoaded) {
                                      if (current.model != null) {
                                        citiesList.add(current.model!);
                                        return true;
                                      }
                                    }
                                    return false;
                                  },
                                  builder: (context, state) {
                                    return DropDownTextField(
                                      withAdd: true,
                                      addClicked: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AddCityDialog();
                                          },
                                        );
                                      },
                                      selectedOption: selectedCity,
                                      hintText: "city",
                                      options: citiesList
                                          .map((e) => e.name ?? "")
                                          .toList(),
                                      onChanged: (value) {
                                        int index = citiesList.indexWhere(
                                            (element) => element.name == value);
                                        if (index != -1) {
                                          sl<ActivityCubit>().getRegionById(
                                            citiesList[index].id ?? -1,
                                          );
                                        }
                                        selectedCity = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: BlocBuilder(
                                  bloc: sl<ActivityCubit>(),
                                  buildWhen: (previous, current) {
                                    if (current is GetAllCityLoaded) {
                                      selectedRegion = null;
                                      return true;
                                    } else if (current is AddRegionLoaded) {
                                      int index = citiesList.indexWhere(
                                          (element) =>
                                              element.name == selectedCity);
                                      if (index != -1) {
                                        if (current.model?.id ==
                                            current.cityId) {
                                          if (current.model != null) {
                                            regionsList.add(current.model!);
                                            return true;
                                          }
                                        }
                                      }
                                    }
                                    if (current is GetAllRegionLoaded) {
                                      regionsList.clear();
                                      selectedRegion = null;
                                      regionsList = current.regions;
                                      return true;
                                    }
                                    return false;
                                  },
                                  builder: (context, state) {
                                    return DropDownTextField(
                                      addClicked: () {
                                        if (selectedCity != null) {
                                          int index = citiesList.indexWhere(
                                              (element) =>
                                                  element.name == selectedCity);
                                          if (index != -1) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AddRegionDialog(
                                                  cityId:
                                                      citiesList[index].id ??
                                                          -1,
                                                );
                                              },
                                            );
                                          }
                                        }
                                      },
                                      withAdd: true,
                                      selectedOption: selectedRegion,
                                      hintText: "region",
                                      options: regionsList
                                          .map((e) => e.name ?? "")
                                          .toList(),
                                      onChanged: (value) {
                                        selectedRegion = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
                                  if (selectedRegion == null) {
                                    Utils.showCustomToast("select region");
                                  } else if (selectedType == null) {
                                    Utils.showCustomToast("select type");
                                  } else if (context
                                          .read<UploadImageCubit>()
                                          .attachments
                                          .indexWhere((element) =>
                                              element.attachmentState !=
                                              AttachmentState.completed) !=
                                      -1) {
                                    Utils.showCustomToast(
                                      "all images must be uploaded",
                                    );
                                  } else if (formKey.currentState!.validate()) {
                                    int index = regionsList.indexWhere(
                                        (element) =>
                                            element.name == selectedRegion);
                                    if (index != -1) {
                                      sl<ActivityCubit>().addActivity(
                                        AddActivityParamsModel(
                                          name: nameController.text,
                                          regionId: regionsList[index].id ?? -1,
                                          type: selectedType!,
                                          price: priceController.text,
                                          description:
                                              descriptionController.text,
                                          latitude: lat,
                                          longitude: lang,
                                          images: context
                                              .read<UploadImageCubit>()
                                              .attachments
                                              .map((e) => e.url ?? "")
                                              .toList(),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
