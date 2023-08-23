import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';

import '../../../../core/utils/themes.dart';
import '../../../other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class EditNameWidget extends StatefulWidget {
  const EditNameWidget({Key? key}) : super(key: key);

  @override
  State<EditNameWidget> createState() => _EditNameWidgetState();
}

class _EditNameWidgetState extends State<EditNameWidget> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController editNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, bottom: 10, left: 16, right: 16),
      child: Form(
        key: formKey,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomAddTextField(
                      type: TextInputType.text,
                      color: Colors.black12,
                      controllerName: editNameController,
                      label: AppLocalizations.of(context)
                              ?.translate('Edit_Your_Name') ?? "",
                      valedate: (String val) {
                        if (val.isEmpty) {
                          return AppLocalizations.of(context)
                                  ?.translate('Username_must_be_not_Empty') ??
                              "";
                        }
                        return null;
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        NewCustomBottom(
                          text: AppLocalizations.of(context)
                                  ?.translate('Submit') ??
                              "",
                          height: 40,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              // sl<UpdateProfileCubit>()
                              //     .updateName(editNameController.text);
                              Navigator.pop(context);
                            }
                          },
                          borderColor: theme.greyWeak,
                          width: MediaQuery.of(context).size.width * 0.4,
                          textStyleForButton: StylesText.textStyleForButton,
                        ),
                        const Spacer(),
                        NewCustomBottom(
                          text: AppLocalizations.of(context)
                                  ?.translate('cancel') ??
                              "",
                          height: 40,
                          onPress: () {
                            Navigator.pop(context);
                          },
                          borderColor: theme.greyWeak,
                          width: MediaQuery.of(context).size.width * 0.4,
                          textStyleForButton: StylesText.textStyleForButton,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
