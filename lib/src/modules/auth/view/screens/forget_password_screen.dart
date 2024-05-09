import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/reset_password_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final AuthBloc bloc;

  const ForgetPasswordScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    int timeToResendCode = 0;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ChangeTimeToResendCodeState) {
            timeToResendCode = state.time;
          }
          if (state is ResetCodeTimerState) {
            timeToResendCode = state.time;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  authBackGround(60.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
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
                        timeToResendCode > 0
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                       Text(
                                        S.of(context).sendCodeAfter,
                                        style: const TextStyle(
                                          color: ColorManager.black,
                                        ),
                                      ),
                                      Text(
                                        "$timeToResendCode ",
                                        style: const TextStyle(
                                          color: ColorManager.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        S.of(context).seconds,
                                        style: const TextStyle(
                                          color: ColorManager.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  defaultButton(
                                    onPressed: () {
                                      context.pushWithTransition(
                                          ResetPasswordScreen(
                                        bloc: bloc,
                                        email: emailController.text,
                                      ));
                                    },
                                    text: S.of(context).receivedCode,
                                    fontSize: 17.sp,
                                  ),
                                ],
                              )
                            : defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    bloc.add(
                                        ResetPasswordEvent(emailController.text));
                                  }
                                },
                                text: S.of(context).sendCode,
                                fontSize: 17.sp,
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
