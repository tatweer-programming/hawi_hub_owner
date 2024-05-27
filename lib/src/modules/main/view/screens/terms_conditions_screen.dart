import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/font_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              height: 33.h,
              opacity: .15,
              child: Column(
                children: [
                  SizedBox(height: 4.h,),
                  Text(S.of(context).preferenceAndPrivacy,
                  style: TextStyleManager.getTitleBoldStyle().copyWith(color: ColorManager.white),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(10.sp),
              child: SingleChildScrollView(
                child: Center(
                  child: SelectableText(
                      style:
                      const TextStyle(fontWeight: FontWeightManager.bold),
                      textAlign: TextAlign.start,
                      S.of(context).termsAndConditions),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
