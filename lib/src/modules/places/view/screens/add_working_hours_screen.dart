import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:sizer/sizer.dart';

import '../../../main/view/widgets/custom_app_bar.dart';

class AddWorkingHours extends StatelessWidget {
  const AddWorkingHours({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController sundayStartController = TextEditingController();
    TextEditingController sundayEndController = TextEditingController();

    TextEditingController mondayStartController = TextEditingController();
    TextEditingController mondayEndController = TextEditingController();

    TextEditingController tuesdayStartController = TextEditingController();
    TextEditingController tuesdayEndController = TextEditingController();

    TextEditingController wednesdayStartController = TextEditingController();
    TextEditingController wednesdayEndController = TextEditingController();

    TextEditingController thursdayStartController = TextEditingController();
    TextEditingController thursdayEndController = TextEditingController();

    TextEditingController fridayStartController = TextEditingController();
    TextEditingController fridayEndController = TextEditingController();

    TextEditingController saturdayStartController = TextEditingController();
    TextEditingController saturdayEndController = TextEditingController();

    List<List<TextEditingController>> daysControllers = <List<TextEditingController>>[
      [sundayStartController, sundayEndController],
      [mondayStartController, mondayEndController],
      [tuesdayStartController, tuesdayEndController],
      [wednesdayStartController, wednesdayEndController],
      [thursdayStartController, thursdayEndController],
      [fridayStartController, fridayEndController],
      [saturdayStartController, saturdayEndController],
    ];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                CustomAppBar(
                  actions: [
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                  height: 33.h,
                  opacity: .15,
                  backgroundImage: "assets/images/app_bar_backgrounds/5.webp",
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: SizedBox(
                      height: 7.h,
                      child: Text(
                        S.of(context).workingHours,
                        style: TextStyleManager.getAppBarTextStyle(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(children: [
                      Row(children: [
                        Expanded(child: SubTitle(S.of(context).day)),
                        SizedBox(width: 2.w),
                        Expanded(child: SubTitle(S.of(context).from)),
                        SizedBox(width: 2.w),
                        Expanded(child: SubTitle(S.of(context).to)),
                      ]),
                      Divider(
                        thickness: .3,
                        height: 3.h,
                      ),
                      ...LocalizationManager.getDays()
                          .map((e) => Column(
                                children: [
                                  _buildDaysInput(
                                      title: e,
                                      startController:
                                          daysControllers[LocalizationManager.getDays().indexOf(e)]
                                              [0],
                                      endController:
                                          daysControllers[LocalizationManager.getDays().indexOf(e)]
                                              [1]),
                                  SizedBox(height: 2.h),
                                ],
                              ))
                          .toList()
                    ])),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildDaysInput({
    required String title,
    required TextEditingController startController,
    required TextEditingController endController,
  }) {
    return Row(children: [
      Expanded(child: SubTitle(title)),
      SizedBox(width: 2.w),
      Expanded(
        child: TextField(
          controller: startController,
        ),
      ),
      SizedBox(width: 2.w),
      Expanded(
          child: TextField(
        controller: endController,
      ))
    ]);
  }
}
