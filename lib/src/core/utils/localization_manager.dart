import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/local/shared_prefrences.dart';

import '../../../generated/l10n.dart';

class LocalizationManager {
  static List<Locale> supportedLocales = const [Locale("ar"), Locale("en")];
  static late int currentLocale;

  static Future<void> init() async {
    await CacheHelper.getData(key: "currentLocale").then((value) {
      if (value != null) {
        currentLocale = value;
      } else {
        currentLocale = 1;
      }
    });
  }

  static Future<void> setLocale(int localeIndex) async {
    if (currentLocale != localeIndex) {
      currentLocale = localeIndex;
      await S.load(getCurrentLocale());
      await saveChanges();
    }
  }

  static Future<void> saveChanges() async {
    await CacheHelper.saveData(key: "currentLocale", value: currentLocale);
  }

  static Locale getCurrentLocale() {
    return supportedLocales[currentLocale];
  }

  static String getAppTitle() {
    return currentLocale == 0 ? "هاوي هب" : "Hawihub";
  }
}
