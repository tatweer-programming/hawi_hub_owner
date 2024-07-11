import 'package:hawi_hub_owner/src/core/utils/images_manager.dart';

class BookingPlayer {
  final int id;
  final String name;
  final String image;

  BookingPlayer({
    required this.id,
    required this.name,
    required this.image,
  });

  factory BookingPlayer.fromJson(Map<String, dynamic> json) {
    return BookingPlayer(
      id: json['playerId'],
      name: json['userName'],
      image: json['profilePictureUrl'] ?? ImagesManager.defaultProfile,
    );
  }
}
