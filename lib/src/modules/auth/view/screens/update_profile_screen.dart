import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';
import '../widgets/widgets.dart';

class EditProfileScreen extends StatelessWidget {
  final Owner owner;

  const EditProfileScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    AuthBloc bloc = AuthBloc.get(context);
    nameController.text = owner.userName;
    emailController.text = owner.email;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          defaultToast(msg: handleResponseTranslation(state.value, context));
        } else if (state is ChangePasswordErrorState) {
          errorToast(
              msg: ExceptionManager(state.exception).translatedMessage());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      _appBar(context: context, owner: owner, bloc: bloc),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      mainFormField(
                        controller: nameController,
                        label: S.of(context).userName,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      mainFormField(
                        controller: emailController,
                        label: S.of(context).email,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      defaultButton(
                        onPressed: () {},
                        text: "Update",
                        fontSize: 17.sp,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Container(
                          width: double.infinity,
                          height: 0.2.h,
                          color: ColorManager.grey3,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      defaultButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return changePassWidget(bloc);
                            },
                          );
                        },
                        text: S.of(context).changePassword,
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
    );
  }
}

Widget _appBar(
    {required BuildContext context,
    required Owner owner,
    required AuthBloc bloc}) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      CustomAppBar(
        blendMode: BlendMode.exclusion,
        backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
        height: 32.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              backIcon(context: context),
              SizedBox(
                width: 8.w,
              ),
              Text(
                S.of(context).updateProfile,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.white,
                  fontSize: 32.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return CircleAvatar(
            radius: 50.sp,
            backgroundColor: ColorManager.grey3,
            backgroundImage: NetworkImage(owner.profilePictureUrl!),
            child: Align(
              alignment: AlignmentDirectional.bottomStart,
              child: IconButton(
                  onPressed: () {
                    bloc.add(AddImageEvent());
                  },
                  icon: CircleAvatar(
                    backgroundColor: ColorManager.white,
                    child: state is UpdateProfileLoadingState
                        ? Padding(
                            padding: EdgeInsets.all(3.0.sp),
                            child: const CircularProgressIndicator(),
                          )
                        : const Icon(
                            Icons.edit,
                            color: ColorManager.black,
                          ),
                  )),
            ),
          );
        },
      )
    ],
  );
}

Widget changePassWidget(
  AuthBloc bloc,
) {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool visible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is ChangePasswordVisibilityState) {
        visible = state.visible;
      }
    },
    builder: (context, state) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                mainFormField(
                    controller: oldPasswordController,
                    label: S.of(context).password,
                    obscureText: visible,
                    suffix: IconButton(
                        onPressed: () {
                          bloc.add(ChangePasswordVisibilityEvent(visible));
                        },
                        icon: Icon(
                            visible ? Icons.visibility_off : Icons.visibility)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return S.of(context).enterPassword;
                      }
                      return null;
                    }),
                SizedBox(
                  height: 2.h,
                ),
                mainFormField(
                    controller: newPasswordController,
                    label: S.of(context).newPassword,
                    validator: (value) {
                      return validPassword(value, context);
                    }),
                SizedBox(
                  height: 2.h,
                ),
                mainFormField(
                    controller: confirmPasswordController,
                    label: S.of(context).confirmPassword,
                    validator: (value) {
                      if (value.isEmpty) {
                        return S.of(context).enterConfirmPassword;
                      } else if (value != newPasswordController.text) {
                        return S.of(context).passwordDoesNotMatch;
                      }
                      return null;
                    }),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 40.w,
                  height: 5.h,
                  child: defaultButton(
                    onPressed: () {
                      bloc.add(ChangePasswordEvent(
                          oldPassword: oldPasswordController.text,
                          newPassword: newPasswordController.text));
                    },
                    text: S.of(context).change,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}
