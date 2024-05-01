import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final AuthBloc bloc;

  const ResetPasswordScreen(
      {super.key, required this.email, required this.bloc});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController codeController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    emailController.text = email;
    bool visible = false;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
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
                        enabled: false,
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
                        controller: codeController,
                        label: 'Code',
                        type: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Code';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is ChangePasswordVisibilityState) {
                          visible = state.visible;
                        }
                      },
                      builder: (context, state) {
                        return mainFormField(
                          controller: passwordController,
                          label: 'New Password',
                          obscureText: visible,
                          suffix: IconButton(
                              onPressed: () {
                                bloc.add(
                                    ChangePasswordVisibilityEvent(visible));
                              },
                              icon: Icon(
                                visible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              )),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter new password';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is ResetPasswordSuccessState) {
                          context.pushAndRemove(Routes.home);
                        } else if (state is ResetPasswordErrorState) {
                          // context.pushAndRemove(Routes.home);
                        }
                      },
                      builder: (context, state) {
                        return state is ResetPasswordLoadingState ? const CircularProgressIndicator() : defaultButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              bloc.add(
                                ResetPasswordEvent(
                                  email: emailController.text,
                                  code: codeController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                          text: "Reset Password",
                          fontSize: 17.sp,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
