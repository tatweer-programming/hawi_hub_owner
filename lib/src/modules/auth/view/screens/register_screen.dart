import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/auth_owner.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/routing/routes.dart';
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
    AuthOwner? authOwner;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AcceptConfirmTermsState) {
          acceptTerms = state.accept;
        }
        if (state is ChangePasswordVisibilityState) {
          visible = state.visible;
        }
        if (state is RegisterSuccessState) {
          bloc.add(ConfirmEmailEvent());
          context.push(Routes.confirmEmail, arguments: {"bloc": bloc});
        } else if (state is ConfirmEmailSuccessState) {
          defaultToast(msg: handleResponseTranslation(state.value, context));
        } else if (state is RegisterErrorState) {
          errorToast(msg: handleResponseTranslation(state.error, context));
        }
        if (state is SignupWithGoogleSuccessState) {
          authOwner = state.authOwner;
          userNameController.text = authOwner!.userName;
          emailController.text = authOwner!.email;
        } else if (state is SignupWithFacebookSuccessState) {
          authOwner = state.authOwner;
          userNameController.text = authOwner!.userName;
          emailController.text = authOwner!.email;
        } else if (state is SignupWithGoogleErrorState ||
            state is SignupWithFacebookErrorState) {
          errorToast(
              msg: handleResponseTranslation("Something went wrong", context));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  authBackGround(50.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        mainFormField(
                            controller: userNameController,
                            type: TextInputType.name,
                            label: S.of(context).userName,
                            validator: (value) {
                              if (value.isEmpty) {
                                return S.of(context).enterUsername;
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                            controller: emailController,
                            label: S.of(context).email,
                            type: TextInputType.emailAddress,
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
                            return validPassword(value, context);
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                            controller: confirmPasswordController,
                            label: S.of(context).confirmPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return S.of(context).enterConfirmPassword;
                              } else if (value != passwordController.text) {
                                return S.of(context).passwordDoesNotMatch;
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: orImageBuilder(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  bloc.add(SignupWithFacebookEvent());
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
                                  bloc.add(SignupWithGoogleEvent());
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
                        _confirmTerms(
                            context: context,
                            onTap: () {
                              bloc.add(AcceptConfirmTermsEvent(acceptTerms));
                            },
                            acceptTerms: acceptTerms),
                        SizedBox(
                          height: 2.h,
                        ),
                        state is RegisterLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      acceptTerms) {
                                    bloc.add(
                                      RegisterPlayerEvent(
                                        authOwner: AuthOwner(
                                            password: passwordController.text,
                                            userName: userNameController.text,
                                            email: emailController.text,
                                            profilePictureUrl:
                                                authOwner?.profilePictureUrl),
                                      ),
                                    );
                                  } else if (!acceptTerms) {
                                    errorToast(
                                        msg: S.of(context).shouldAgreeTerns);
                                  }
                                },
                                fontSize: 17.sp,
                                text: S.of(context).signUp,
                              ),
                        SizedBox(
                          height: 2.h,
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
        {required VoidCallback onTap,
        required BuildContext context,
        required bool acceptTerms}) =>
    Row(
      children: [
        IconButton(
            onPressed: onTap,
            icon: Icon(
                acceptTerms ? Icons.check_box : Icons.check_box_outline_blank)),
        Expanded(
            child: InkWell(
          onTap: () {
            context.push(Routes.termsAndCondition);
          },
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(vertical: 1.5.h),
            child: Text(
              S.of(context).agreeTerms,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ))
      ],
    );
