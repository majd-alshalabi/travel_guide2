import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/presentation/login_page/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:travel_guide/feature/account/presentation/register_page/presentation/register_page.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/toggle_page.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //TODO this is the way to get Theme //make it in all pages
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    //TODO ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 50.0,
        ),
      ),
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: Builder(builder: (context) {
          return BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                Utils.showCustomToast("error while logging in");
                context.loaderOverlay.hide();
              } else if (state is LoginLoading) {
                context.loaderOverlay.show();
              } else if (state is LoginLoaded) {
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
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),

                        //TODO example To make Localization ...... when you Know it delete it .......
                        Text(
                          AppLocalizations.of(context)?.translate('welcome') ??
                              "",
                        ),

                        //TODO ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        Text("Welcome Back! 😍",
                            style: StylesText.textStyleForTitle),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Happy to see you again! Please enter your email and password to login to your account.",
                          style: StylesText.defaultTextStyle,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          type: TextInputType.text,
                          prefix: const Icon(Icons.email),
                          //TODO example To make theme color ...... when you Know it Edit it .......
                          color: theme.greyWeak,
                          //TODO ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                          controllerName: emailController,
                          label: "Email",
                          valedate: (val) {
                            if (val?.isEmpty ?? true) {
                              return "email must not be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          type: TextInputType.text,
                          prefix: const Icon(Icons.password_rounded),
                          color: Colors.black,
                          controllerName: passwordController,
                          label: "Password",
                          valedate: (val) {
                            if ((val?.length ?? 0) < 8) {
                              return "password must be at least 8 character";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomBottom(
                            text: "Login",
                            height: 60,
                            //TODO Please make it color in theme App and give it name primary color
                            buttonColor: const Color(0xffDE7254),
                            //TODO^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            onPress: () {
                              context.read<LoginCubit>().login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            },
                            borderColor: const Color(0xffDE7254),
                            textStyleForButton: StylesText.textStyleForButton),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account?",
                              style: StylesText.defaultTextStyle
                                  .copyWith(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign up",
                                  style: StylesText.defaultTextStyle,
                                ))
                          ],
                        )
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
