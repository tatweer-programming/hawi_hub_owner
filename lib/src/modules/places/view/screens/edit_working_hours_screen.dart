import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/font_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/add_working_hours_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../main/view/widgets/custom_app_bar.dart';

class EditWorkingHoursScreen extends StatelessWidget {
  const EditWorkingHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Day> workingHours = PlaceCubit.get().placeEditForm!.workingHours;
    TextEditingController sundayStartController = TextEditingController(
        text:
            "${workingHours[0].startTime.hour}:${workingHours[0].startTime.minute}");
    TextEditingController sundayEndController = TextEditingController(
        text:
            "${workingHours[0].endTime.hour}:${workingHours[0].endTime.minute}");

    TextEditingController mondayStartController = TextEditingController(
        text:
            "${workingHours[1].startTime.hour}:${workingHours[1].startTime.minute}");
    TextEditingController mondayEndController = TextEditingController(
        text:
            "${workingHours[1].endTime.hour}:${workingHours[1].endTime.minute}");

    TextEditingController tuesdayStartController = TextEditingController(
        text:
            "${workingHours[2].startTime.hour}:${workingHours[2].startTime.minute}");
    TextEditingController tuesdayEndController = TextEditingController(
        text:
            "${workingHours[2].endTime.hour}:${workingHours[2].endTime.minute}");

    TextEditingController wednesdayStartController = TextEditingController(
        text:
            "${workingHours[3].startTime.hour}:${workingHours[3].startTime.minute}");
    TextEditingController wednesdayEndController = TextEditingController(
        text:
            "${workingHours[3].endTime.hour}:${workingHours[3].endTime.minute}");

    TextEditingController thursdayStartController = TextEditingController(
        text:
            "${workingHours[4].startTime.hour}:${workingHours[4].startTime.minute}");
    TextEditingController thursdayEndController = TextEditingController(
        text:
            "${workingHours[4].endTime.hour}:${workingHours[4].endTime.minute}");

    TextEditingController fridayStartController = TextEditingController(
        text:
            "${workingHours[5].startTime.hour}:${workingHours[5].startTime.minute}");
    TextEditingController fridayEndController = TextEditingController(
        text:
            "${workingHours[5].endTime.hour}:${workingHours[5].endTime.minute}");

    TextEditingController saturdayStartController = TextEditingController(
        text:
            "${workingHours[6].startTime.hour}:${workingHours[6].startTime.minute}");
    TextEditingController saturdayEndController = TextEditingController(
        text:
            "${workingHours[6].endTime.hour}:${workingHours[6].endTime.minute}");

    List<List<TextEditingController>> daysControllers =
        <List<TextEditingController>>[
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
                        Expanded(
                            child: Text(
                          S.of(context).day,
                          style: const TextStyle(
                              fontWeight: FontWeightManager.bold),
                        )),
                        SizedBox(width: 2.w),
                        Expanded(
                            child: Text(
                          S.of(context).from,
                          style: const TextStyle(
                              fontWeight: FontWeightManager.bold),
                        )),
                        SizedBox(width: 2.w),
                        Expanded(
                            child: Text(
                          S.of(context).to,
                          style: const TextStyle(
                              fontWeight: FontWeightManager.bold),
                        )),
                        SizedBox(width: 2.w),
                        FittedBox(
                            child: Text(
                          S.of(context).weekend,
                          style: const TextStyle(
                              fontWeight: FontWeightManager.bold),
                        )),
                      ]),
                      Divider(
                        thickness: .3,
                        height: 3.h,
                      ),
                      ...LocalizationManager.getDays().map((e) => Column(
                            children: [
                              DayWidget(
                                  dayOfWeek:
                                      LocalizationManager.getDays().indexOf(e) +
                                          1,
                                  title: e,
                                  startController: daysControllers[
                                      LocalizationManager.getDays()
                                          .indexOf(e)][0],
                                  endController: daysControllers[
                                      LocalizationManager.getDays()
                                          .indexOf(e)][1]),
                              SizedBox(height: 2.h),
                            ],
                          ))
                    ])),
              ],
            )),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: DefaultButton(
                text: S.of(context).save,
                onPressed: () {
                  _saveWorkingHours(daysControllers);
                  context.pop();
                }),
          )
        ],
      ),
    );
  }

  void _saveWorkingHours(List<List<TextEditingController>> daysControllers) {
    PlaceCubit cubit = PlaceCubit.get();
    for (int i = 0; i < daysControllers.length; i++) {
      cubit.workingHours[i] = Day(
        dayOfWeek: cubit.workingHours[i].dayOfWeek,
        startTime: daysControllers[i][0].text.tryParseToTimeOfDay() ??
            const TimeOfDay(hour: 0, minute: 0),
        endTime: daysControllers[i][1].text.tryParseToTimeOfDay() ??
            const TimeOfDay(hour: 23, minute: 59),
      );
    }
  }
}
