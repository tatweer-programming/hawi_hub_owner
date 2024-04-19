
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/common widgets/common_widgets.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  final AuthBloc bloc;

  const RegisterScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool acceptTerms = false;
    bool visible = false;
    TextEditingController confirmPasswordController = TextEditingController();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AcceptConfirmTermsState) {
          acceptTerms = state.accept;
        }
        if (state is ChangePasswordVisibilityState) {
          visible = state.visible;
        }
        if (state is RegisterSuccessState) {
          bloc.add(PlaySoundEvent("audios/start.wav"));
          // context.pushAndRemove();
        }else if (state is RegisterErrorState){
          errorToast(msg: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  authBackGround(40.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        mainFormField(
                            controller: userNameController,
                            type: TextInputType.name,
                            label: 'Username',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                            controller: emailController,
                            label: 'Email',
                            type: TextInputType.emailAddress,
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
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                            controller: confirmPasswordController,
                            label: 'Confirm Password',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter confirm password';
                              } else if (value != passwordController.text) {
                                return 'Password does not match';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        _confirmTerms(
                            onTap: () {
                              bloc.add(AcceptConfirmTermsEvent(acceptTerms));
                            },
                            acceptTerms: acceptTerms),
                        SizedBox(
                          height: 2.h,
                        ),
                        state is RegisterLoadingState
                            ? const CircularProgressIndicator()
                            : defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      acceptTerms) {
                                    bloc.add(
                                      RegisterPlayerEvent(
                                        userName: userNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  } else if (!acceptTerms) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "You should agree to terms of service and privacy policy")),
                                    );
                                  }
                                },
                                fontSize: 17.sp,
                                text: "REGISTER",
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _confirmTerms(
        {required VoidCallback onTap, required bool acceptTerms}) =>
    Row(
      children: [
        IconButton(
            onPressed: onTap,
            icon: Icon(
                acceptTerms ? Icons.check_box : Icons.check_box_outline_blank)),
        Expanded(
            child: Text(
          "I agree to the Terms of Service and Privacy Policy.",
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ))
      ],
    );
