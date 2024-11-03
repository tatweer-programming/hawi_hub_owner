import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/add_feedback_for_user.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/rates_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/error/remote_error.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/color_manager.dart';
import '../widgets/people_rate_builder.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final int id;

  const ProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = AuthBloc.get(context);
    Owner? owner;
    bloc.add(GetProfileEvent(id));
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is GetProfileSuccessState) {
        owner = state.owner;
      }
      if (state is UploadNationalIdSuccessState) {
        context.pop();
        bloc.add(GetProfileEvent(id));
        context.pop();
      } else if (state is UploadNationalIdErrorState) {
        context.pop();
        errorToast(msg: ExceptionManager(state.exception).translatedMessage());
      } else if (state is UploadNationalIdLoadingState) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          },
        );
      }
    }, builder: (context, state) {
      if (owner != null) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   width: double.infinity,
                //   child: Stack(
                //     children: [
                //       AuthAppBar(
                //         context: context,
                //         owner: owner!,
                //         title: S.of(context).profile,
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      userInfoDisplay(
                        value: owner != null ? owner!.userName : "",
                        key: S.of(context).userName,
                      ),
                      _accountVerified(
                          bloc: bloc,
                          id: id,
                          owner: owner!,
                          context: context,
                          state: state),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is GetProfileErrorState) {
        return Scaffold(
          body: Center(
              child: Text(
            S.of(context).somethingWentWrong,
            style: TextStyleManager.getTitleBoldStyle(),
          )),
        );
      }
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    });
  }
}

Widget _seeAll(VoidCallback onTap, BuildContext context) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Text(
          S.of(context).seeAll,
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

Widget _accountVerified({
  required BuildContext context,
  required AuthState state,
  required int id,
  required Owner owner,
  required AuthBloc bloc,
}) {
  if (!owner.isEmailConfirmed()) {
    return _emailNotConfirmed(context, bloc);
  } else if (owner.nationalIdPicture == null && !(owner.isVerified())) {
    return _notVerified(bloc);
  } else if (!owner.isVerified()) {
    return _pending(context, S.of(context).identificationPending);
  } else if (owner.isVerified()) {
    return _verified(
        owner: owner, context: context, state: state, id: id, authBloc: bloc);
  } else {
    return _rejectedAndTryAgain(context, S.of(context).rejectIdCard, bloc);
  }
}

Widget _notVerified(AuthBloc bloc) {
  File? imagePicked;
  return BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      if (state is AddImageSuccessState) {
        if (state.imagePicked != null) {
          imagePicked = state.imagePicked;
        }
      } else if (state is DeleteImageState) {
        imagePicked = null;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Text(
            S.of(context).mustVerifyAccount,
            style: TextStyleManager.getSecondarySubTitleStyle(),
          ),
          _viewRequiredDocuments(
            bloc: bloc,
            context: context,
            path: "assets/pdfs/Freelancers.pdf",
            text: S.of(context).addRequiredPdfForFreeLancers,
          ),
          _viewRequiredDocuments(
            bloc: bloc,
            context: context,
            path: "assets/pdfs/CompaniesInKSAForeign.pdf",
            text: S.of(context).addRequiredPdfForCompaniesInKSAForeign,
          ),
          _viewRequiredDocuments(
            bloc: bloc,
            context: context,
            path: "assets/pdfs/LegalInstitutions.pdf",
            text: S.of(context).addRequiredPdfForLegalInstitutions,
          ),
          _viewRequiredDocuments(
            bloc: bloc,
            context: context,
            path: "assets/pdfs/LegalOrganizations.pdf",
            text: S.of(context).addRequiredPdfForLegalOrganizations,
          ),
          SizedBox(
            height: 3.h,
          ),
          InkWell(
            onTap: () {
              bloc.add(AddImageEvent());
            },
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsetsDirectional.all(25.sp),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: ColorManager.black),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: imagePicked != null
                        ? Text(S.of(context).fileUploaded)
                        : const Icon(Icons.file_copy_outlined)),
                if (imagePicked != null)
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
                  ),
              ],
            ),
          ),
          if (imagePicked != null)
            Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                defaultButton(
                    onPressed: () {
                      if (imagePicked != null) {
                        bloc.add(UploadNationalIdEvent(imagePicked!));
                      }
                    },
                    text: S.of(context).upload,
                    fontSize: 17.sp),
              ],
            )
        ],
      );
    },
  );
}

Widget _pending(BuildContext context, String text) {
  return Column(
    children: [
      SizedBox(
        height: 10.h,
      ),
      Text(
        text,
        style: TextStyleManager.getSecondarySubTitleStyle(),
      ),
    ],
  );
}

Widget _emailNotConfirmed(
  BuildContext context,
  AuthBloc bloc,
) {
  return Column(
    children: [
      SizedBox(
        height: 10.h,
      ),
      defaultButton(
          onPressed: () {
            bloc.add(ConfirmEmailEvent());
            context.push(Routes.confirmEmail, arguments: {'bloc': bloc});
          },
          text: S.of(context).verifyEmail,
          fontSize: 17.sp),
    ],
  );
}

Widget _rejectedAndTryAgain(BuildContext context, String text, AuthBloc bloc) {
  return Column(
    children: [
      SizedBox(
        height: 10.h,
      ),
      Text(
        text,
        style: TextStyleManager.getSecondarySubTitleStyle(),
      ),
      _notVerified(bloc)
    ],
  );
}

Widget _verified({
  required Owner owner,
  required BuildContext context,
  required AuthState state,
  required AuthBloc authBloc,
  required int id,
}) {
  return Column(children: [
    SizedBox(
      height: 2.h,
    ),
    userInfoDisplay(
      key: S.of(context).email,
      value: owner.email,
    ),
    SizedBox(
      height: 2.h,
    ),
    userInfoDisplay(
      key: S.of(context).rate,
      value: owner.rate.toStringAsFixed(1),
      trailing: Expanded(
        child: RatingBar.builder(
          initialRating: owner.rate,
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
      ),
    ),
    SizedBox(
      height: 3.h,
    ),
    owner.feedbacks.isEmpty
        ? Container()
        : Column(
            children: [
              Row(
                children: [
                  Text(
                    S.of(context).peopleRate,
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  _seeAll(() {
                    context.pushWithTransition(RatesScreen(
                      owner: owner,
                    ));
                  }, context)
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => PeopleRateBuilder(
                  context: context,
                  feedBack: owner.feedbacks[index],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 2.h,
                ),
                itemCount: owner.feedbacks.take(2).length,
              ),
            ],
          ),
    SizedBox(
      height: 2.h,
    ),
    if (ConstantsManager.appUser!.playerReservation.contains(owner.id))
      _addFeedback(context, onPressed: () {
        context.pushWithTransition(
            AddFeedbackForUser(owner: owner, authBloc: authBloc));
      })
  ]);
}

Widget _viewRequiredDocuments(
    {required AuthBloc bloc,
    required String path,
    required String text,
    required BuildContext context}) {
  return Column(
    children: [
      SizedBox(
        height: 2.h,
      ),
      Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyleManager.getRegularStyle(),
            ),
          ),
          TextButton(
            onPressed: () {
              bloc.add(OpenPdfEvent(path));
            },
            child: Text(
              S.of(context).viewRequirements,
              style: TextStyleManager.getBlackCaptionTextStyle(),
            ),
          )
        ],
      ),
    ],
  );
}

_addFeedback(BuildContext context, {required Function() onPressed}) {
  return Column(
    children: [
      defaultButton(
          onPressed: onPressed,
          text: S.of(context).addFeedback,
          fontSize: 17.sp),
      SizedBox(
        height: 2.h,
      ),
    ],
  );
}
