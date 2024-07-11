import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';

import '../utils/color_manager.dart';
void defaultToast({
  required String msg,
}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: ColorManager.primary,
    textColor: ColorManager.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

void errorToast({
  required String msg,
}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: ColorManager.error,
    textColor: ColorManager.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

showDialogForLanguage(BuildContext context, MainCubit mainCubit) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          mainCubit.changeLanguage(0);
                          context.pop();
                        },
                        child: const Text("العربية"))),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          mainCubit.changeLanguage(1);
                          context.pop();
                        },
                        child: const Text("English"))),
              ],
            ));
      });
}
