import '../utils/localization_manager.dart';

class ExceptionManager implements Exception {
  dynamic error;

  ExceptionManager(this.error);

  String translatedMessage() {
    if (LocalizationManager.getCurrentLocale().languageCode == "en") {
      return error.message;
    }
    switch (error.code) {
      case 400:
        return "الطلب غير صالح";
      case 401:
        return "لا يُسمح بالدخول";
      case 403:
        return "الوصول غير مسموح";
      case 404:
        return "المورد غير موجود";
      case 405:
        return "الطريقة غير مسموحة";
      case 406:
        return "المحتوى غير مقبول";
      case 407:
        return "المصادقة بالوكيل مطلوبة";
      case 408:
        return "انتهت مهلة الطلب";
      case 409:
        return "تعارض بيانات";
      case 410:
        return "المورد غير متوفر";
      case 411:
        return "الطول المطلوب مفقود";
      case 412:
        return "فشلت الشروط الأولية للطلب";
      case 413:
        return "البيانات المرسلة كبيرة جدًا";
      case 414:
        return "رابط الطلب طويل جدًا";
      case 415:
        return "نوع الوسائط غير مدعوم";
      case 416:
        return "نطاق الطلب غير مرضي";
      case 417:
        return "فشلت التوقعات";
      case 418:
        return "أنا إبريق - طلب غير مفهوم";
      case 421:
        return "الطلب مُنسّق بشكل خاطئ";
      case 422:
        return "المحتوى غير قابل للمعالجة";
      case 423:
        return "المورد مُغلق";
      case 424:
        return "فشل التبعية";
      case 425:
        return "الطلب مبكر جدًا";
      case 426:
        return "الترقية مطلوبة";
      case 428:
        return "شرط مسبق مطلوب";
      case 429:
        return "الكثير من الطلبات";
      case 431:
        return "حقول رأس الطلب كبيرة جدًا";
      case 451:
        return "المورد غير متوفر لأسباب قانونية";
      default:
        return "حدث خطأ غير متوقع";
    }
  }
}
