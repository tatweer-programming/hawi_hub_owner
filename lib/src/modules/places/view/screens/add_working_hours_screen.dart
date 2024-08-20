import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/font_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:sizer/sizer.dart';

import '../../../main/view/widgets/custom_app_bar.dart';

class AddWorkingHours extends StatelessWidget {
  const AddWorkingHours({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PlaceCubit placeCubit = PlaceCubit.get();
    TextEditingController sundayStartController = TextEditingController(
        text: placeCubit.workingHours[0].startTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));
    TextEditingController sundayEndController = TextEditingController(
        text: placeCubit.workingHours[0].endTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));
    TextEditingController mondayStartController = TextEditingController(
        text: placeCubit.workingHours[1].startTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));
    TextEditingController mondayEndController = TextEditingController(
        text: placeCubit.workingHours[1].endTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));

    TextEditingController tuesdayStartController = TextEditingController(
        text: placeCubit.workingHours[2].startTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));
    TextEditingController tuesdayEndController = TextEditingController(
        text: placeCubit.workingHours[2].endTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));

    TextEditingController wednesdayStartController = TextEditingController(
        text: placeCubit.workingHours[3].startTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));
    TextEditingController wednesdayEndController = TextEditingController(
        text: placeCubit.workingHours[3].endTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));

    TextEditingController thursdayStartController = TextEditingController(
        text: placeCubit.workingHours[4].startTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));
    TextEditingController thursdayEndController = TextEditingController(
        text: placeCubit.workingHours[4].endTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));

    TextEditingController fridayStartController = TextEditingController(
        text: placeCubit.workingHours[5].startTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));
    TextEditingController fridayEndController = TextEditingController(
        text: placeCubit.workingHours[5].endTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));

    TextEditingController saturdayStartController = TextEditingController(
        text: placeCubit.workingHours[6].startTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));
    TextEditingController saturdayEndController = TextEditingController(
        text: placeCubit.workingHours[6].endTime
            .toStr()
            .split(":")
            .sublist(0, 2)
            .join(":"));

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
    // print("working hours : ${placeCubit.workingHours}");
    for (int i = 0; i < daysControllers.length; i++) {
      for (int j = 0; j < daysControllers[i].length; j++) {
        print(daysControllers[i][j].text);
      }
    }
    GlobalKey<FormState> key = GlobalKey();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Form(
              key: key,
              autovalidateMode: AutovalidateMode.always,
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
                                    dayOfWeek: LocalizationManager.getDays()
                                            .indexOf(e) +
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
              ),
            )),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: DefaultButton(
                text: S.of(context).save,
                onPressed: () {
                  if (key.currentState!.validate()) {
                    _saveWorkingHours(daysControllers);
                    defaultToast(msg: S.of(context).workingHoursSaved);
                    context.pop();
                  }
                }),
          )
        ],
      ),
    );
  }

  // Widget _buildDaysInput({
  //   required String title,
  //   required TextEditingController startController,
  //   required TextEditingController endController,
  // }) {
  //   bool isWeekend = false;
  //   return Row(children: [
  //     Expanded(child: SubTitle(title)),
  //     SizedBox(width: 2.w),
  //     Expanded(
  //       child: TextField(
  //         keyboardType: TextInputType.datetime,
  //         controller: startController,
  //       ),
  //     ),
  //     SizedBox(width: 2.w),
  //     Expanded(
  //         child: TextField(
  //       keyboardType: TextInputType.datetime,
  //       controller: endController,
  //     ))
  //   ]);
  // }

  void _saveWorkingHours(List<List<TextEditingController>> daysControllers) {
    List<Day> days = [];
    for (int i = 0; i < daysControllers.length; i++) {
      for (int j = 0; j < daysControllers[i].length; j++) {
        print(daysControllers[i][j].text);
      }
    }
    PlaceCubit cubit = PlaceCubit.get();
    for (int i = 0; i < daysControllers.length; i++) {
     days.add( Day(
        dayOfWeek: i,
        startTime: daysControllers[i][0].text.tryParseToTimeOfDay() ??
            const TimeOfDay(hour: 0, minute: 0),
        endTime: daysControllers[i][1].text.tryParseToTimeOfDay() ??
            const TimeOfDay(hour: 23, minute: 59),
      ));
    }
    cubit.saveWorkingHours(days);
  }
}

class DayWidget extends StatefulWidget {
  final TextEditingController startController;
  final TextEditingController endController;
  final String title;
  final int dayOfWeek;
  const DayWidget(
      {super.key,
      required this.title,
      required this.dayOfWeek,
      required this.startController,
      required this.endController});

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  bool isWeekend = false;

  @override
  void initState() {
    isWeekend = PlaceCubit.get().workingHours[widget.dayOfWeek - 1].isWeekend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeightManager.bold),
      )),
      SizedBox(width: 2.w),
      Expanded(
        child: TextFormField(
          validator: (value) {
            if (value!.split(":").length != 2 ||
                value.contains(".") ||
                value.contains("/")) {
              return "";
            }
            return null;
          },
          enabled: !isWeekend,
          keyboardType: TextInputType.datetime,
          controller: widget.startController,
        ),
      ),
      SizedBox(width: 2.w),
      Expanded(
          child: TextFormField(
        enabled: !isWeekend,
        keyboardType: TextInputType.datetime,
        controller: widget.endController,
      )),
      SizedBox(
        width: 2.w,
      ),
      Checkbox(
          value: isWeekend,
          onChanged: (value) {
            setState(() {
              if (isWeekend) {
                widget.startController.text = "00:00";
                widget.endController.text = "23:59";
              } else {
                widget.startController.text = "00:00";
                widget.endController.text = "00:00";
              }
              isWeekend = !isWeekend;
            });
          })
    ]);
  }
}
