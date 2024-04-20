import 'localization_manager.dart';

class ConstantsManager {
  // static Player? appUser;

  static bool? registrationSkipped;
  static int? userId;
  static String? userToken;
  static String? userType;
  static bool? isNotificationsOn;
  static const String baseUrlNotification = "https://fcm.googleapis.com/fcm/send";
  static const String successUrl =
      "https://firebasestorage.googleapis.com/v0/b/masheed-d942d.appspot.com/o/payment%2Fsuccess%20(2).HTML?alt=media&token=2d979a52-9247-4abd-a264-fba2d5f0ae2e";
  static const String errorUrl =
      "https://firebasestorage.googleapis.com/v0/b/masheed-d942d.appspot.com/o/payment%2Ffailed.HTML?alt=media&token=01fddc6e-e292-4080-bddb-0e3fa4f54993";
  static const String firebaseMessagingAPI =
      "AAAAg2F4b1U:APA91bEp1nenkuZMlwu3PmiNRJTWOiG4zncmBF_23UiLcdtm42HZ1lDaoR-sRP21PFquem76ZHVKj5wGXI76Mx6WvqgUS2xxFAjuvM0hBMMd8cNvDcLEH6XKc65wBk_3C4IRr5znOi1M";

  static final List<String> saudiCitiesArabic = [
    'الرياض',
    'جدة',
    'مكة المكرمة',
    'الدمام',
    'الخبر',
    'الطائف',
    'المدينة المنورة',
    'بريدة',
    'تبوك',
    'خميس مشيط',
    'حائل',
    'الجبيل',
    'الخرج',
    'أبها',
    'نجران',
    'ينبع',
    'القصيم',
    'الظهران',
    'الباحة',
    'الأحساء',
    'النماص',
    'عرعر',
    'سكاكا',
    'جازان',
    'عنيزة',
    'القريات',
    'الرس',
    'صفوى',
    'الخفجي',
    'الدوادمي',
    'الزلفي',
    'رفحاء',
    'شقراء',
    'الدرعية',
    'الرميلة',
    'بيشة',
    'الطائف',
    'الظهران',
    'الفرسان',
    'المظيلف',
    'المزاحمية',
    'المويه',
  ];
  static final List<String> saudiCitiesEnglish = [
    'Riyadh',
    'Jeddah',
    'Mecca',
    'Dammam',
    'Khobar',
    'Taif',
    'Medina',
    'Buraydah',
    'Tabuk',
    'Khamis Mushait',
    'Hail',
    'Jubail',
    'Kharg',
    'Abha',
    'Najran',
    'Yanbu',
    'Qassim',
    'Dhahran',
    'Baha',
    'Al Ahsa',
    'Namas',
    'Arar',
    'Sakakah',
    'Jazan',
    'Unaizah',
    'Qurayyat',
    'Ar Rass',
    'Safwa',
    'Khafji',
    'Ad Dawadimi',
    'Zulfi',
    'Rafha',
    'Shaqraa',
    'Ad Diriyah',
    'Ar Rumaylah',
    'Bisha',
    'Taif',
    'Dhahran',
    'Farasan',
    'Muzahmiyya',
    'Al Muwayh',
  ];

  static List<String> get getSaudiCities {
    if (LocalizationManager.getCurrentLocale().languageCode == "ar") {
      return saudiCitiesArabic;
    } else {
      return saudiCitiesEnglish;
    }
  }
}
