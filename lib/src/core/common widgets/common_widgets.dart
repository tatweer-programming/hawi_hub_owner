import 'package:fluttertoast/fluttertoast.dart';

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
