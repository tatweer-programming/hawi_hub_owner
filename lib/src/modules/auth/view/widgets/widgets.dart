import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/styles_manager.dart';

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
  double? height,
  Color? buttonColor,
  Color? textColor,
  double? fontSize,
}) =>
    MaterialButton(
        height: height ?? 7.h,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(25.sp),
        ),
        minWidth: 80.w,
        color: buttonColor ?? ColorManager.primary,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? ColorManager.white,
            fontSize: fontSize,
          ),
        ));

Widget authBackGround(double height) => Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Align(
          alignment: AlignmentDirectional.topCenter,
          heightFactor: 0.9,
          child: ClipPath(
            clipper: HalfCircleCurve(height / 4),
            child: Container(
              height: height,
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: ColorManager.grey1,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/auth_background.png",
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: 4.h,
          ),
          child: Image.asset(
            "assets/images/logo2.png",
            height: 7.h,
            width: 35.w,
          ),
        ),
      ],
    );

mainFormField(
        {String? label,
        Icon? prefix,
        String? hint,
        String? helper,
        IconButton? suffix,
        bool? enabled = true,
        Color? fillColor,
        Color? borderColor,
        String? validatorText,
        TextInputType? type,
        bool border = true,
        void Function()? suffixFunction,
        FormFieldValidator? validator,
        bool obscureText = false,
        double? width,
        TextStyle? labelStyle,
        TextStyle? hintStyle,
        int? maxLines,
        int? minLines,
        TextAlign? textAlign,
        required TextEditingController controller}) =>
    SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.start,
        controller: controller,
        keyboardType: type,
        enabled: enabled,
        obscureText: obscureText,
        maxLines: maxLines ?? 1,
        minLines: minLines,
        style: const TextStyle(color: ColorManager.black),
        decoration: InputDecoration(
            prefixIcon: prefix,
            disabledBorder: OutlineInputBorder(
              borderSide: !border
                  ? BorderSide.none
                  : BorderSide(color: borderColor ?? ColorManager.grey3),
              borderRadius: BorderRadius.circular(25.sp),
            ),
            contentPadding:
                EdgeInsetsDirectional.symmetric(horizontal: 5.w, vertical: 2.h),
            focusedBorder: OutlineInputBorder(
              borderSide: !border
                  ? BorderSide.none
                  : BorderSide(color: borderColor ?? ColorManager.grey3),
              borderRadius: BorderRadius.circular(25.sp),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: !border
                  ? BorderSide.none
                  : BorderSide(color: borderColor ?? ColorManager.grey3),
              borderRadius: BorderRadius.circular(25.sp),
            ),
            errorStyle: TextStyle(color: borderColor ?? ColorManager.error),
            fillColor: fillColor ?? ColorManager.white,
            filled: true,
            suffixIcon: suffix,
            labelText: label,
            hintText: hint,
            hintStyle: hintStyle ?? TextStyle(color: ColorManager.grey3),
            helperText: helper,
            labelStyle: labelStyle ??
                TextStyle(color: ColorManager.grey3, fontSize: 12.sp)),
        validator: validator,
      ),
    );

class HalfCircleCurve extends CustomClipper<Path> {
  final double height;

  HalfCircleCurve(this.height);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path
      ..lineTo(0, size.height - height)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

Widget backIcon({required BuildContext context, Function()? onTap}) {
  return InkWell(
    onTap: onTap ??
        () {
          context.pop();
        },
    child: CircleAvatar(
      radius: 12.sp,
      backgroundColor: ColorManager.white,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 2.w),
        child: Icon(
          Icons.arrow_back_ios,
          size: 15.sp,
          color: ColorManager.primary,
        ),
      ),
    ),
  );
}

Widget orImageBuilder() => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 60.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(10.sp),
                            topStart: Radius.circular(10.sp),
                          ),
                          border: const Border(
                            left: BorderSide(
                              color: ColorManager.black,
                            ),
                            right: BorderSide(
                              color: ColorManager.black,
                            ),
                            top: BorderSide(
                              color: ColorManager.black,
                            ),
                          )),
                    ),
                  ],
                ),
                Positioned(
                  left: 25.w,
                  top: 0.h,
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: 1.h,
                      horizontal: 2.w,
                    ),
                    color: Colors.white,
                    child: Text(
                      "OR",
                      style: TextStyleManager.getRegularStyle(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.2.h,
            ),
          ],
        ),
        Container(
          width: 58.w,
          height: 5.h,
          color: ColorManager.white,
        ),
      ],
    );

String handleResponseTranslation(String state, BuildContext context) {
  if (state == "Account Created Successfully") {
    return S.of(context).accountCreatedSuccessfully;
  }
  if (state == "Email confirmed successfully") {
    return S.of(context).emailConfirmedSuccessfully;
  }
  if (state.contains("Confirmation code sent successfully to")) {
    RegExp emailPattern = RegExp(r'\S+@\S+\.\S+');
    var email = emailPattern.firstMatch(state)?.group(0);
    return S.of(context).confirmationCodeSentSuccessfully + email!;
  }
  if (state == "Invalid reset code.") {
    return S.of(context).invalidResetCode;
  }
  if (state.contains("No owner was found with ID :")) {
    return S.of(context).noOwnerFound;
  }
  if (state == "Email is not exists.") return S.of(context).emailNotExists;
  if (state == "Email is already exists.") {
    return S.of(context).emailAlreadyExist;
  }
  if (state == "Username is already exists.") {
    return S.of(context).usernameAlreadyExist;
  }
  if (state == "Password reset successfully") {
    return S.of(context).passwordResetSuccessfully;
  }
  if (state == "Invalid email or password.") {
    return S.of(context).invalidEmailOrPassword;
  }
  if (state == "Account LogedIn Successfully") {
    return S.of(context).loginSuccessfully;
  }
  if (state == "Something went wrong") return S.of(context).somethingWentWrong;
  if (state == "Wrong password !") return S.of(context).wrongPassword;
  if (state == "CHECK YOUR NETWORK") return S.of(context).checkYourNetwork;
  if (state == "Password has been changed successfully") {
    return S.of(context).passwordChangedSuccessfully;
  }
  if (state == "Proof of identity has been added successfully") {
    return S.of(context).proofOfIdentityAddedSuccessfully;
  }
  return state;
}

String? validPassword(String value, BuildContext context) {
  if (value.isEmpty) {
    return S.of(context).enterPassword;
  } else if (value.length < 6) {
    return S.of(context).shortPassword;
  } else if (!RegExp(r'[a-z]').hasMatch(value)) {
    return S.of(context).passMustContainLowerCase;
  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return S.of(context).passMustContainUpperCase;
  } else if (!RegExp(r'[0-9]').hasMatch(value)) {
    return S.of(context).passMustContainNumber;
  } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return S.of(context).passMustContainSpecialChar;
  }
  return null;
}


Widget divider() => Container(
  height: 0.2.h,
  width: double.infinity,
  color: ColorManager.grey2,
);

Widget userInfoDisplay(
    {required String value, required String key, Widget? trailing}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$key ",
          style: TextStyleManager.getTitleBoldStyle(),
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyleManager.getGreyTextStyle(),
              ),
            ),
            trailing ?? Container()
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        divider(),
      ],
    );