import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/presentation/register_page/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/toggle_page.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppTheme theme  = sl<ThemeCubit>().globalAppTheme;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget:  Center(
        child: SpinKitSpinningLines(
          color: theme.darkThemeForScafold,
          size: 50.0,
        ),
      ),
      child: BlocProvider(
        create: (context) => RegisterCubit(),
        child: Builder(builder: (context) {
          return BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterError) {
                Utils.showCustomToast("error while loading");
                context.loaderOverlay.hide();
              } else if (state is RegisterLoading) {
                context.loaderOverlay.show();
              } else if (state is RegisterLoaded) {
                context.loaderOverlay.hide();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TogglePage(),
                  ),
                  (route) => false,
                );
              }
            },
            child: Scaffold(
              backgroundColor:  theme.darkThemeForScafold,
              body: Padding(
                padding: const EdgeInsets.all(13.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sign up",
                            style: StylesText.textStyleForTitle,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Welcome pleas enter your Name , email and password  to create your account ",
                          style: StylesText.newDefaultTextStyle
                              .copyWith(color: theme.greyWeak),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          type: TextInputType.text,
                          prefix: const Icon(Icons.person),
                          color: theme.reserveDarkScaffold,
                          controllerName: usernameController,
                          label: "name",
                          valedate: (val) {
                            if ((val?.length ?? 0) < 3) {
                              return "user name must be at least three character";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          type: TextInputType.text,
                          prefix: const Icon(Icons.email),
                          color: theme.reserveDarkScaffold,
                          controllerName: emailController,
                          label: "email",
                          valedate: (val) {
                            if (val?.isEmpty ?? true) {
                              return "email must not be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          type: TextInputType.text,
                          prefix: const Icon(Icons.password_rounded),
                          color: theme.reserveDarkScaffold,
                          controllerName: passwordController,
                          label: "password",
                          valedate: (val) {
                            if ((val?.length ?? 0) < 8) {
                              return "password length must be 8 at least";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomBottom(
                          text: "Register",
                          height: 50,
                          buttonColor: Constant.primaryBodyColor,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              context.read<RegisterCubit>().register(
                                    name: usernameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            }
                          },
                          borderColor: theme.darkThemeForScafold,
                          textStyleForButton: StylesText.textStyleForButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
