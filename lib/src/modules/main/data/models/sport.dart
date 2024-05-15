import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';

class Sport {
  final int id;
  final String arabicName;
  final String englishName;
  final String image;
  const Sport(
      {required this.id, required this.arabicName, required this.image, required this.englishName});

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      id: json['categoryId'],
      arabicName: json['categoryNameAr'],
      englishName: json['categoryNameEn'],
      image: " json['image']",
    );
  }

  String get name {
    if (LocalizationManager.currentLocale == 0) {
      return arabicName;
    }
    return englishName;
  }

  static Sport unKnown() =>
      const Sport(id: 0, arabicName: "غير معروفة", englishName: "Unknown", image: "");
}
