import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/login_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/profile_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/connectivity.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../../payment/presentation/screens/my_wallet.dart';
import '../custom_app_bar.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = AuthBloc.get(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          bloc.add(PlaySoundEvent("audios/end.wav"));
          context.pushAndRemove(Routes.login);
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
                  // _settingWidget(
                  //   onTap: () {
                  //     // context.pushWithTransition(
                  //     //   MyWallet(
                  //     //     player: Player(
                  //     //       id: 1,
                  //     //       userName: "Mohamed",
                  //     //       bookings: 8,
                  //     //       games: 5,
                  //     //       email: "",
                  //     //       profilePictureUrl:
                  //     //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyXXkiqJLhMZE69a4dTnH4Qd6GyzyFmqcmHu8EAhx8DQ&s",
                  //     //       myWallet: 900,
                  //     //       feedbacks: [],
                  //     //       rate: 5,
                  //     //     ),
                  //     //   ),
                  //     // );
                  //   },
                  //   icon: "assets/images/icons/money.webp",
                  //   title: "My Wallet",
                  // ),
                  _settingWidget(
                    onTap: () {},
                    icon: "assets/images/icons/privacy.webp",
                    title: "Preference and Privacy",
                  ),
                  _settingWidget(
                    onTap: () {},
                    icon: "assets/images/icons/history.webp",
                    title: "History",
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
                    onTap: () {},
                    color: ColorManager.grey1,
                    icon: "assets/images/icons/question.webp",
                    title: "Common Questions",
                  ),
                  _settingWidget(
                    onTap: () {
                      Share.share(
                          'hey! to share our app visit :https://play.google.com/store/apps/details?id=com.instagram.android',
                          subject: 'Look what I made!');
                    },
                    icon: "assets/images/icons/share_2.webp",
                    title: "Share",
                    color: ColorManager.grey1,
                  ),
                  _settingWidget(
                    onTap: () {
                      showLogoutDialog(context, bloc);
                    },
                    icon: "assets/images/icons/logout.webp",
                    title: "Logout",
                    color: ColorManager.grey1,
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
                  if (ConstantsManager.appUser != null &&
                      ConstantsManager.appUser!.profilePictureUrl != null)
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundColor: ColorManager.grey3,
                      backgroundImage: NetworkImage(
                          ConstantsManager.appUser!.profilePictureUrl!),
                    ),
                  if (ConstantsManager.appUser == null || ConstantsManager.appUser!.profilePictureUrl == null)
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundColor: ColorManager.grey3,
                      backgroundImage:
                          const AssetImage("assets/images/icons/user.png"),
                    ),
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
            child: const Text(
              "Cancel",
            ),
          ),
          TextButton(
            onPressed: () {
              bloc.add(LogoutEvent());
            },
            child: const Text(
              "Logout",
            ),
          )
        ],
        title: Text(
          "Do you want to logout ?",
          style: TextStyleManager.getRegularStyle(),
        ),
      );
    },
  );
}
