import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/lite_rolling_switch.dart';
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
  bool guide = false;
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = sl<ThemeCubit>().globalAppTheme;
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Welcome Back! 😍",
                              style: StylesText.textStyleForTitle),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Happy to see you again!!! please enter your email and password to login to your account.",
                          style: StylesText.newDefaultTextStyle
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          type: TextInputType.text,
                          prefix: const Icon(Icons.email),
                          color: theme.greyWeak,
                          controllerName: emailController,
                          label: "email",
                          valedate: (val) {
                            if (val?.isEmpty ?? true) {
                              return "email must not be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          type: TextInputType.text,
                          prefix: const Icon(Icons.password_rounded),
                          color: Colors.black,
                          controllerName: passwordController,
                          label: "password",
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
                        LiteRollingSwitch(
                          value: guide,
                          textOn: 'guide',
                          textOff: 'user',
                          colorOn: const Color(0xffDE7254),
                          colorOff: Colors.grey,
                          iconOn: Icons.done,
                          iconOff: Icons.remove_circle_outline,
                          textSize: 16.0,
                          width: 25.w,
                          onChanged: (bool state) {
                            guide = state;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomBottom(
                            text: "Login",
                            height: 50,
                            buttonColor: const Color(0xffDE7254),
                            onPress: () {
                              context.read<LoginCubit>().login(
                                    guide: guide,
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
                              style: StylesText.newDefaultTextStyle
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
                                style: StylesText.newDefaultTextStyle
                                    .copyWith(color: Colors.grey),
                              ),
                            )
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
