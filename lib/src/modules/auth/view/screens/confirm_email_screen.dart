import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawi_hub_owner/src/modules/chat/bloc/chat_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/color_manager.dart';

class ConfirmEmailScreen extends StatelessWidget {
  final AuthBloc bloc;

  const ConfirmEmailScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    int timeToResendCode = 0;
    bloc.add(ConfirmEmailEvent());
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              authBackGround(50.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is VerifyConfirmEmailSuccessState) {
                    bloc.add(PlaySoundEvent("audios/start.wav"));
                    defaultToast(
                        msg: handleResponseTranslation(state.value, context));
                    context.pushAndRemove(Routes.home);
                    ChatBloc chatBloc = ChatBloc.get(context);
                    chatBloc.add(GetConnectionEvent());
                    chatBloc.add(CloseConnectionEvent());
                  } else if (state is VerifyConfirmEmailErrorState) {
                    errorToast(
                        msg: handleResponseTranslation(state.error, context));
                  } else if (state is ConfirmEmailErrorState) {
                    errorToast(
                        msg: handleResponseTranslation(state.error, context));
                  } else if (state is ConfirmEmailSuccessState) {
                    defaultToast(
                        msg: handleResponseTranslation(state.value, context));
                  }
                  if (state is ChangeTimeToResendCodeState) {
                    timeToResendCode = state.time;
                  } else if (state is ResetCodeTimerState) {
                    timeToResendCode = state.time;
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Column(
                      children: [
                        mainFormField(
                            controller: codeController,
                            label: S.of(context).code,
                            type: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return S.of(context).enterCode;
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        timeToResendCode <= 0
                            ? state is ConfirmEmailLoadingState
                                ? const CircularProgressIndicator()
                                : defaultButton(
                                    onPressed: () {
                                      bloc.add(ConfirmEmailEvent());
                                    },
                                    text: S.of(context).reSendCode,
                                    fontSize: 17.sp,
                                  )
                            : Column(
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
                                    height: 1.h,
                                  ),
                                  state is VerifyConfirmEmailLoadingState
                                      ? const CircularProgressIndicator()
                                      : defaultButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              bloc.add(
                                                VerifyConfirmEmailEvent(
                                                  codeController.text,
                                                ),
                                              );
                                            }
                                          },
                                          text: S.of(context).confirm,
                                          fontSize: 17.sp,
                                        )
                                ],
                              ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
