import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/register_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/common widgets/common_widgets.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthBloc bloc = AuthBloc.get(context);
    bool visible = false;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ChangePasswordVisibilityState) {
          visible = state.visible;
        }
        if (state is LoginSuccessState) {
          bloc.add(PlaySoundEvent("audios/start.wav"));
          // context.pushAndRemove();
        } else if (state is LoginErrorState) {
          errorToast(msg: state.error);
        }
        // if (state is LogoutSuccessState) {
        //   bloc.add(PlaySoundEvent("assets/audios/end.wav"));
        //   context.pushAndRemove(Routes.login);
        // }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                authBackGround(50.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  child: Column(
                    children: [
                      mainFormField(
                          controller: emailController,
                          label: 'Email',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      mainFormField(
                          controller: passwordController,
                          label: 'Password',
                          obscureText: visible,
                          suffix: IconButton(
                              onPressed: () {
                                bloc.add(
                                    ChangePasswordVisibilityEvent(visible));
                              },
                              icon: Icon(visible
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      state is LoginLoadingState
                          ? const CircularProgressIndicator()
                          : defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  bloc.add(LoginPlayerEvent(
                                      email: emailController.text,
                                      password: passwordController.text));
                                }
                              },
                              text: "LOGIN",
                              fontSize: 17.sp,
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Keep me logged in",
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushWithTransition(RegisterScreen(
                                  bloc: bloc,
                                ));
                              },
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(color: ColorManager.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _orImageBuilder(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                bloc.add(LoginWithFacebookEvent());
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/icons/facebook.webp",
                                    height: 5.h,
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    "Facebook",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                bloc.add(LoginWithGoogleEvent());
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/icons/google.webp",
                                    height: 5.h,
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    "Google",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account?",
                            style: TextStyle(
                              color: ColorManager.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushWithTransition(RegisterScreen(
                                bloc: bloc,),);
                            },
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.green,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}

Widget _orImageBuilder() => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 60.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(10.sp),
                            topStart: Radius.circular(10.sp),
                          ),
                          border: const Border(
                            left: BorderSide(
                              color: ColorManager.black,
                            ),
                            right: BorderSide(
                              color: ColorManager.black,
                            ),
                            top: BorderSide(
                              color: ColorManager.black,
                            ),
                          )),
                    ),
                  ],
                ),
                Positioned(
                  left: 25.w,
                  top: 0.h,
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: 1.h,
                      horizontal: 2.w,
                    ),
                    color: Colors.white,
                    child: Text(
                      "OR",
                      style: TextStyleManager.getRegularStyle(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.2.h,
            ),
          ],
        ),
        Container(
          width: 58.w,
          height: 5.h,
          color: ColorManager.white,
        ),
      ],
    );
