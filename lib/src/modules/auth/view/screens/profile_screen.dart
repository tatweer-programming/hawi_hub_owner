import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/rates_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';
import '../widgets/widgets.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Owner owner;

  const ProfileScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = AuthBloc.get(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    _appBar(context: context, owner: owner),
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
                      height: 2.h,
                    ),
                    Text(
                      owner.userName,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _emailConfirmed(bloc: bloc, owner: owner, context: context, state: state),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget _walletWidget(VoidCallback onTap, String wallet) {
  return Container(
    height: 5.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xff757575),
      borderRadius: BorderRadius.circular(25.sp),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 4.w,
            top: 1.h,
            bottom: 1.h,
          ),
          child: Text(
            "$wallet \$",
            style: const TextStyle(
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _appBar({
  required BuildContext context,
  required Owner owner,
}) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              backIcon(context),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.white,
                  fontSize: 32.sp,
                ),
              ),
              const Spacer(),
              if (owner.emailConfirmed == 2)
                InkWell(
                    onTap: () {
                      context.pushWithTransition(EditProfileScreen(
                        owner: owner,
                      ));
                    },
                    child: _editIcon()),
            ],
          ),
        ),
      ),
      CircleAvatar(
        radius: 50.sp,
        backgroundColor: ColorManager.grey3,
        backgroundImage: NetworkImage(owner.profilePictureUrl),
      )
    ],
  );
}

Widget _editIcon() {
  return CircleAvatar(
    radius: 12.sp,
    backgroundColor: ColorManager.white,
    child: Image.asset(
      "assets/images/icons/edit.webp",
      height: 3.h,
      width: 4.w,
    ),
  );
}

Widget _seeAll(VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Text(
          "See all",
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.golden,
          ),
        ),
        Icon(
          Icons.arrow_forward_rounded,
          color: ColorManager.golden,
          size: 18.sp,
        ),
      ],
    ),
  );
}

Widget _peopleRateBuilder(AppFeedBack feedBack) {
  return Stack(
    children: [
      Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          Container(
            height: 12.h,
            width: double.infinity,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(25.sp), border: Border.all()),
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 3.w, vertical: 1.h),
              child: Row(children: [
                CircleAvatar(
                  radius: 20.sp,
                  backgroundColor: ColorManager.grey3,
                  backgroundImage: NetworkImage(feedBack.userImageUrl!),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Text(feedBack.comment ?? "No comment",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorManager.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ]),
            ),
          ),
        ],
      ),
      Positioned(
        left: 5.w,
        top: -1.h,
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 1.h,
            horizontal: 2.w,
          ),
          color: Colors.white,
          child: Row(
            children: [
              Text(
                feedBack.userName,
                style: TextStyle(fontSize: 12.sp, color: Colors.green, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 1.w),
              RatingBar.builder(
                initialRating: feedBack.rating,
                minRating: 1,
                itemSize: 10.sp,
                direction: Axis.horizontal,
                ignoreGestures: true,
                allowHalfRating: true,
                itemPadding: EdgeInsets.zero,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: ColorManager.golden,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _emailConfirmed({
  required Owner owner,
  required BuildContext context,
  required AuthState state,
  required AuthBloc bloc,
}) {
  if (owner.emailConfirmed == 0) {
    return _notVerified(bloc);
  } else if (owner.emailConfirmed == 1) {
    return _pending();
  }
  return _verified(
    owner: owner,
    context: context,
    state: state,
  );
}

Widget _notVerified(AuthBloc bloc) {
  File? imagePicked;
  return BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      if (state is AddImageSuccessState) {
        if (state.imagePicked != null) {
          imagePicked = state.imagePicked;
        }
      }
      if (state is DeleteImageState) {
        imagePicked = null;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            "You must verify your account first",
            style: TextStyleManager.getSecondarySubTitleStyle(),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Upload your national ID",
            style: TextStyleManager.getSubTitleStyle(),
          ),
          SizedBox(
            height: 3.h,
          ),
          if (imagePicked != null)
            Column(
              children: [
                Stack(
                  children: [
                    Image.file(
                      imagePicked!,
                      height: 25.h,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    InkWell(
                      onTap: () {
                        bloc.add(DeleteImageEvent());
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: ColorManager.white,
                            child: const Icon(
                              Icons.close,
                              color: ColorManager.primary,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                defaultButton(
                    onPressed: () {
                      if (imagePicked != null) {
                        bloc.add(UploadNationalIdEvent(imagePicked!));
                      }
                    },
                    text: "Upload",
                    fontSize: 17.sp)
              ],
            ),
          if (imagePicked == null)
            InkWell(
              onTap: () {
                bloc.add(AddImageEvent());
              },
              child: Container(
                  padding: EdgeInsetsDirectional.all(25.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: ColorManager.black),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: const Icon(Icons.file_copy_outlined)),
            ),
        ],
      );
    },
  );
}

Widget _pending() {
  return Column(
    children: [
      SizedBox(
        height: 10.h,
      ),
      Text(
        "The ID card is being verified now",
        style: TextStyleManager.getSecondarySubTitleStyle(),
      ),
    ],
  );
}

Widget _verified({
  required Owner owner,
  required BuildContext context,
  required AuthState state,
}) {
  return Column(children: [
    SizedBox(
      height: 2.h,
    ),
    Text(
      owner.rate!.remainder(1).toString(),
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    ),
    RatingBar.builder(
      initialRating: owner.rate!,
      minRating: 1,
      itemSize: 25.sp,
      direction: Axis.horizontal,
      ignoreGestures: true,
      allowHalfRating: true,
      itemPadding: EdgeInsets.zero,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: ColorManager.golden,
      ),
      onRatingUpdate: (rating) {},
    ),
    SizedBox(
      height: 2.h,
    ),
    owner.feedbacks.isEmpty
        ? Container()
        : Column(
            children: [
              Row(
                children: [
                  Text(
                    "People Rate",
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  _seeAll(() {
                    context.pushWithTransition(RatesScreen(
                      owner: owner,
                    ));
                  })
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              state is GetMyProfileLoadingState
                  ? ShimmerWidget(
                      height: 13.h,
                      width: double.infinity,
                      placeholder: ShimmerPlaceHolder(
                        borderRadius: 15.sp,
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _peopleRateBuilder(owner.feedbacks[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 2.h,
                          ),
                      itemCount: owner.feedbacks.take(2).length),
            ],
          ),
    SizedBox(
      height: 2.h,
    ),
    Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        "My Wallet",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
    ),
    SizedBox(
      height: 2.h,
    ),
    _walletWidget(() {}, owner.myWallet.toString()),
  ]);
}
