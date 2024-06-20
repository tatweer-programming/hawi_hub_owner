import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/forget_password_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/register_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/color_manager.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthBloc bloc = AuthBloc.get(context);
    MainCubit mainCubit = MainCubit.get();
    bool visible = false;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ChangePasswordVisibilityState) {
          visible = state.visible;
        }
        if (state is LoginSuccessState && ConstantsManager.userId != null) {
          bloc.add(PlaySoundEvent("audios/start.wav"));
          defaultToast(msg: handleResponseTranslation(state.value, context));
          context.pushAndRemove(Routes.home);
        } else if (state is LoginErrorState) {
          errorToast(msg: handleResponseTranslation(state.error, context));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    authBackGround(50.h),
                    BlocConsumer<MainCubit, MainState>(
                      listener: (context, state) {
                        if (state is ShowDialogState) {
                          showDialogForLanguage(context, mainCubit);
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 3.5.h),
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: ColorManager.secondary,
                            onPressed: () {
                              mainCubit.showDialog();
                            },
                            child: Icon(
                              Icons.language,
                              color: ColorManager.white,
                              size: 23.sp,
                            ),
                          ),
                        );
                      },

                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  child: Column(
                    children: [
                      mainFormField(
                          controller: emailController,
                          label: S.of(context).email,
                          validator: (value) {
                            if (value.isEmpty) {
                              return S.of(context).enterEmail;
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      mainFormField(
                          controller: passwordController,
                          label: S.of(context).password,
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
                              return S.of(context).enterPassword;
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
                              text: S.of(context).login,
                              fontSize: 17.sp,
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).keepMeLoggedIn,
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushWithTransition(ForgetPasswordScreen(
                                  bloc: bloc,
                                ));
                              },
                              child: Text(
                                S.of(context).forgotPassword,
                                style:
                                    const TextStyle(color: ColorManager.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      orImageBuilder(),
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
                          Text(
                            S.of(context).noAccount,
                            style: const TextStyle(
                              color: ColorManager.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushWithTransition(RegisterScreen(
                                bloc: bloc,
                              ));
                            },
                            child: Text(
                              S.of(context).signUp,
                              style: const TextStyle(
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
