import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int playerId;
  final String userName;
  final String? profilePictureUrl;

  const Player({
    required this.playerId,
    required this.userName,
    required this.profilePictureUrl,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerId: json["playerId"],
      userName: json["userName"],
      profilePictureUrl: json["profilePictureUrl"],
    );
  }

  @override
  List<Object?> get props => [
        playerId,
      ];
}
