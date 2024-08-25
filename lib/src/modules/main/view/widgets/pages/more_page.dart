import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/payment/presentation/screens/my_wallet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../generated/l10n.dart';
import '../custom_app_bar.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = AuthBloc.get(context);
    MainCubit mainCubit = MainCubit.get();
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is ShowDialogState) {
          showDialogForLanguage(context, mainCubit);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  _appBar(
                    context,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Column(
                children: [
                  _settingWidget(
                    onTap: () {
                      if (ConstantsManager.appUser != null) {
                        context.pushWithTransition(
                            MyWallet(owner: ConstantsManager.appUser!));
                      }
                    },
                    icon: "assets/images/icons/money.webp",
                    title: "My Wallet",
                  ),
                  _settingWidget(
                    onTap: () {
                      context.push(Routes.termsAndCondition);
                    },
                    icon: "assets/images/icons/privacy.webp",
                    title: S.of(context).preferenceAndPrivacy,
                  ),
                  _settingWidget(
                    onTap: () {
                      showDialogForLanguage(context, mainCubit);
                    },
                    icon: "assets/images/icons/lang.png",
                    title: S.of(context).language,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Container(
                      width: double.infinity,
                      height: 0.2.h,
                      color: ColorManager.grey3,
                    ),
                  ),
                  _settingWidget(
                    onTap: () {
                      context.push(Routes.questions);
                    },
                    color: ColorManager.grey1,
                    icon: "assets/images/icons/question.webp",
                    title: S.of(context).commonQuestions,
                  ),
                  _settingWidget(
                    onTap: () {
                      Share.share(
                        '${S.of(context).shareApp}:https://play.google.com/store/apps/details?id=com.instagram.android',
                      );
                    },
                    icon: "assets/images/icons/share_2.webp",
                    title: S.of(context).share,
                    color: ColorManager.grey1,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is LogoutSuccessState) {
                        bloc.add(PlaySoundEvent("audios/end.wav"));
                        mainCubit.currentIndex = 0;
                        context.pushAndRemove(Routes.login);
                      }
                    },
                    builder: (context, state) {
                      return _settingWidget(
                        onTap: () {
                          showLogoutDialog(context, bloc);
                        },
                        icon: "assets/images/icons/logout.webp",
                        title: S.of(context).logout,
                        color: ColorManager.grey1,
                      );
                    },
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}

Widget _settingWidget({
  required VoidCallback onTap,
  required String icon,
  required String title,
  Color? color,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: color ?? ColorManager.third.withOpacity(0.4),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Row(
            children: [
              Image.asset(
                height: 3.h,
                width: 8.w,
                icon,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                title,
                style: TextStyleManager.getCaptionStyle()
                    .copyWith(color: ColorManager.black),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorManager.black.withOpacity(0.5),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _appBar(
  BuildContext context,
) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Align(
        alignment: AlignmentDirectional.topCenter,
        heightFactor: 0.85,
        child: CustomAppBar(
          blendMode: BlendMode.exclusion,
          backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
          height: 32.h,
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: (42.sp) * 2,
                    width: (42.sp) * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorManager.white,
                        width: 0.5.w,
                      ),
                    ),
                  ),
                  navToProfile(context: context, radius: 30.sp)
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

showLogoutDialog(BuildContext context, AuthBloc bloc) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              S.of(context).cancel,
            ),
          ),
          TextButton(
            onPressed: () {
              bloc.add(LogoutEvent());
            },
            child: Text(
              S.of(context).logout,
            ),
          )
        ],
        title: Text(
          S.of(context).doYouWantToLogout,
          style: TextStyleManager.getRegularStyle(),
        ),
      );
    },
  );
}
