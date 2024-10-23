import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawi_hub_owner/src/modules/chat/view/screens/chats_screen.dart';
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            child: Column(children: [
              _appBar(context),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 3.w,
                  end: 3.w,
                  top: 5.h,
                  bottom: 3.h,
                ),
                child: InkWell(
                  onTap: () {
                    if (ConstantsManager.appUser != null) {
                      context.pushWithTransition(
                          MyWallet(owner: ConstantsManager.appUser!));
                    }
                  },
                  child: userInfoDisplay(
                      value:
                      "${(ConstantsManager.appUser == null
                          ? 0
                          : ConstantsManager.appUser!.myWallet)} ${S
                          .of(context)
                          .sar}",
                      key: S
                          .of(context)
                          .myWallet,
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: ColorManager.grey2,
                      )),
                ),
              ),
              _setupProfile(context),
              _newSettingWidget(
                onTap: () {
                  context.push(Routes.termsAndCondition);
                },
                icon: "assets/images/icons/privacy.webp",
                text: S
                    .of(context)
                    .preferenceAndPrivacy,
              ),

              _newSettingWidget(
                  onTap: () {
                    showDialogForLanguage(context, mainCubit);
                  },
                  icon: "assets/images/icons/lang.png",
                  text: S
                      .of(context)
                      .language,
                  trailing: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: ColorManager.grey2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            mainCubit.changeLanguage(0);
                          },
                          child: _languageText(
                              text: "عربي",
                              isEnglish: LocalizationManager
                                  .getCurrentLocale()
                                  .languageCode ==
                                  "ar"),
                        ),
                        InkWell(
                          onTap: () {
                            mainCubit.changeLanguage(1);
                          },
                          child: _languageText(
                              text: "English",
                              isEnglish:
                              !(LocalizationManager
                                  .getCurrentLocale()
                                  .languageCode ==
                                  "ar")),
                        ),
                      ],
                    ),
                  )),
              _newSettingWidget(
                onTap: () {
                  context.push(Routes.questions);
                },
                icon: "assets/images/icons/question.webp",
                text: S
                    .of(context)
                    .commonQuestions,
              ),
              _newSettingWidget(
                onTap: () {
                  context.pushWithTransition(const ChatsScreen(
                    withPlayer: false,
                  ));
                },
                icon: "assets/images/icons/chat.png",
                text: S
                    .of(context)
                    .technicalSupport,
              ),
              _newSettingWidget(
                onTap: () {
                  Share.share(
                    '${S
                        .of(context)
                        .shareApp}:https://play.google.com/store/apps/details?id=com.instagram.android',
                  );
                },
                icon: "assets/images/icons/share_2.webp",
                text: S
                    .of(context)
                    .share,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LogoutSuccessState) {
                    bloc.add(PlaySoundEvent("audios/end.wav"));
                    context.pushAndRemove(Routes.login);
                  }
                },
                builder: (context, state) {
                  return _newSettingWidget(
                    onTap: () {
                      showLogoutDialog(context, bloc);
                    },
                    icon: "assets/images/icons/logout.webp",
                    text: S
                        .of(context)
                        .logout,
                  );
                },
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              //   child: Column(
              //     children: [
              //       _settingWidget(
              //         onTap: () {
              //           if (ConstantsManager.appUser != null) {
              //             context.pushWithTransition(
              //                 MyWallet(owner: ConstantsManager.appUser!));
              //           }
              //         },
              //         icon: "assets/images/icons/money.webp",
              //         title: "My Wallet",
              //       ),
              //       _settingWidget(
              //         onTap: () {
              //           context.push(Routes.termsAndCondition);
              //         },
              //         icon: "assets/images/icons/privacy.webp",
              //         title: S.of(context).preferenceAndPrivacy,
              //       ),
              //       _settingWidget(
              //         onTap: () {
              //           showDialogForLanguage(context, mainCubit);
              //         },
              //         icon: "assets/images/icons/lang.png",
              //         title: S.of(context).language,
              //       ),
              //       Padding(
              //         padding: EdgeInsets.symmetric(vertical: 1.h),
              //         child: Container(
              //           width: double.infinity,
              //           height: 0.2.h,
              //           color: ColorManager.grey3,
              //         ),
              //       ),
              //       _settingWidget(
              //         onTap: () {
              //           context.push(Routes.questions);
              //         },
              //         color: ColorManager.grey1,
              //         icon: "assets/images/icons/question.webp",
              //         title: S.of(context).commonQuestions,
              //       ),
              //       _settingWidget(
              //         onTap: () {
              //           Share.share(
              //             '${S.of(context).shareApp}:https://play.google.com/store/apps/details?id=com.instagram.android',
              //           );
              //         },
              //         icon: "assets/images/icons/share_2.webp",
              //         title: S.of(context).share,
              //         color: ColorManager.grey1,
              //       ),
              //       BlocConsumer<AuthBloc, AuthState>(
              //         listener: (context, state) {
              //           if (state is LogoutSuccessState) {
              //             bloc.add(PlaySoundEvent("audios/end.wav"));
              //             mainCubit.currentIndex = 0;
              //             context.pushAndRemove(Routes.login);
              //           }
              //         },
              //         builder: (context, state) {
              //           return _settingWidget(
              //             onTap: () {
              //               showLogoutDialog(context, bloc);
              //             },
              //             icon: "assets/images/icons/logout.webp",
              //             title: S.of(context).logout,
              //             color: ColorManager.grey1,
              //           );
              //         },
              //       ),
              //     ],
              //   ),
              // ),
            ]),
          ),
        );
      },
    );
  }
}

Widget _appBar(BuildContext context) {
  return InkWell(
    onTap: () {
      context.push(
        Routes.profile,
        arguments: {
          'id': ConstantsManager.userId,
        },
      );
    },
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.grey2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/icons/user.png",
            height: 8.h,
            width: 10.h,
          ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ConstantsManager.appUser == null
                    ? "New User"
                    : ConstantsManager.appUser!.userName,
                style: TextStyleManager.getTitleBoldStyle(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S
                        .of(context)
                        .profile,
                    style: TextStyleManager.getRegularStyle(),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.black,
                    size: 12.sp,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _newSettingWidget({
  required VoidCallback onTap,
  required String icon,
  required String text,
  Widget? trailing,
}) {
  return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 2.w),
        child: Row(
          children: [
            Image.asset(
              height: 3.h,
              width: 8.w,
              icon,
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyleManager.getCaptionStyle()
                    .copyWith(color: ColorManager.black),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.grey2,
                ),
            SizedBox(
              width: 1.w,
            ),
          ],
        ),
      ));
}

Widget _checkProfile(bool isCheck, String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            isCheck ? Icons.check_circle : Icons.check_circle_outline,
            size: 25.sp,
            color: ColorManager.primary,
          ),
          Expanded(
              child: Container(
                color: ColorManager.grey2,
                width: double.infinity,
                height: 0.2.h,
              ))
        ],
      ),
      Text(
        text,
        style: TextStyleManager.getCaptionStyle().copyWith(fontSize: 7.sp),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
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

// Widget _appBar(
//   BuildContext context,
// ) {
//   return Align(
//     alignment: AlignmentDirectional.topCenter,
//     heightFactor: 0.85,
//     child: CustomAppBar(
//       blendMode: BlendMode.exclusion,
//       backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
//       height: 32.h,
//       child: Column(
//         children: [
//           SizedBox(
//             height: 3.h,
//           ),
//           Stack(
//             alignment: AlignmentDirectional.center,
//             children: [
//               Container(
//                 height: (42.sp) * 2,
//                 width: (42.sp) * 2,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: ColorManager.white,
//                     width: 0.5.w,
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   context.push(
//                     Routes.profile,
//                     arguments: {
//                       'id': ConstantsManager.userId,
//                       "userType": "Player"
//                     },
//                   );
//                 },
//                 child: CircleAvatar(
//                   backgroundImage: ConstantsManager.appUser != null &&
//                           ConstantsManager.appUser!.profilePictureUrl != null
//                       ? NetworkImage(
//                           ConstantsManager.appUser!.profilePictureUrl!)
//                       : const AssetImage("assets/images/icons/user.png")
//                           as ImageProvider<Object>,
//                   backgroundColor: ColorManager.golden,
//                   radius: 30.sp,
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

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
              S
                  .of(context)
                  .cancel,
            ),
          ),
          TextButton(
            onPressed: () {
              bloc.add(LogoutEvent());
            },
            child: Text(
              S
                  .of(context)
                  .logout,
            ),
          )
        ],
        title: Text(
          S
              .of(context)
              .doYouWantToLogout,
          style: TextStyleManager.getRegularStyle(),
        ),
      );
    },
  );
}

Widget _languageText({
  required bool isEnglish,
  required String text,
}) {
  return Container(
    height: 5.h,
    width: 20.w,
    decoration: BoxDecoration(
      color: isEnglish ? ColorManager.primary : ColorManager.grey2,
      borderRadius: isEnglish
          ? BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(
          10,
        ),
      )
          : BorderRadius.only(
        bottomRight: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 0.9.h,
      ),      child: Center(
        child: Text(
          text,
          style: TextStyleManager.getRegularStyle()
              .copyWith(color: ColorManager.white),
        ),
      ),
    ),
  );
}

//
// Widget _settingWidget({
//   required VoidCallback onTap,
//   required String icon,
//   required String title,
//   Color? color,
// }) {
//   return InkWell(
//     onTap: onTap,
//     child: Padding(
//       padding: EdgeInsets.symmetric(vertical: 1.h),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.sp),
//           color: color ?? ColorManager.third.withOpacity(0.4),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 5.w,
//             vertical: 2.h,
//           ),
//           child: Row(
//             children: [
//               Image.asset(
//                 height: 3.h,
//                 width: 8.w,
//                 icon,
//               ),
//               SizedBox(
//                 width: 4.w,
//               ),
//               Text(
//                 title,
//                 style: TextStyleManager.getCaptionStyle()
//                     .copyWith(color: ColorManager.black),
//               ),
//               const Spacer(),
//               Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 color: ColorManager.black.withOpacity(0.5),
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// Widget _appBar(
//   BuildContext context,
// ) {
//   return Stack(
//     alignment: AlignmentDirectional.bottomCenter,
//     children: [
//       Align(
//         alignment: AlignmentDirectional.topCenter,
//         heightFactor: 0.85,
//         child: CustomAppBar(
//           blendMode: BlendMode.exclusion,
//           backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
//           height: 32.h,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 3.h,
//               ),
//               Stack(
//                 alignment: AlignmentDirectional.center,
//                 children: [
//                   Container(
//                     height: (42.sp) * 2,
//                     width: (42.sp) * 2,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: ColorManager.white,
//                         width: 0.5.w,
//                       ),
//                     ),
//                   ),
//                   navToProfile(context: context, radius: 30.sp)
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }
//
// showLogoutDialog(BuildContext context, AuthBloc bloc) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         actions: [
//           TextButton(
//             onPressed: () {
//               context.pop();
//             },
//             child: Text(
//               S.of(context).cancel,
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               bloc.add(LogoutEvent());
//             },
//             child: Text(
//               S.of(context).logout,
//             ),
//           )
//         ],
//         title: Text(
//           S.of(context).doYouWantToLogout,
//           style: TextStyleManager.getRegularStyle(),
//         ),
//       );-
//     },
//   );
// }
_setupProfile(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: 4.w,
      vertical: 4.h,
    ),
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.circular(10.sp),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S
              .of(context)
              .profileSetup,
          style: TextStyleManager.getTitleBoldStyle(),
        ),
        SizedBox(
          height: 3.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _checkProfile(
                ConstantsManager.appUser != null,
                S
                    .of(context)
                    .createAccount,
              ),
            ),
            Expanded(
              child: _checkProfile(
                (ConstantsManager.appUser == null
                    ? false
                    : (ConstantsManager.appUser)!.isEmailConfirmed()),
                S
                    .of(context)
                    .confirmEmail,
              ),
            ),
            Expanded(
              child: _checkProfile(
                (ConstantsManager.appUser == null
                    ? false
                    : (ConstantsManager.appUser)!.isVerified()),
                S
                    .of(context)
                    .verifyAccount,
              ),
            ),
            Icon(
              Icons.star,
              size: 25.sp,
              color: ColorManager.primary,
            )
          ],
        ),
      ],
    ),
  );
}
