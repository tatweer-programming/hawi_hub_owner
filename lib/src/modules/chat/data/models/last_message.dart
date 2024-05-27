import 'package:equatable/equatable.dart';
import '../../../auth/data/models/player.dart';


class LastMessage extends Equatable {
  final int? messageId;
  final String? messageContent;
  final String? messageAttachmentUrl;
  final bool? playerToOwner;
  final String? timestamp;
  final Player player;

  const LastMessage({
    required this.messageId,
    required this.messageContent,
    required this.messageAttachmentUrl,
    required this.playerToOwner,
    required this.timestamp,
    required this.player,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      messageId: json["messageId"],
      messageContent: json["messageContent"],
      messageAttachmentUrl: json["messageAttachmentUrl"],
      playerToOwner: json["playerToOwner"],
      timestamp: json["timestamp"],
      player: Player.fromJson(json["player"]),
    );
  }

  @override
  List<Object?> get props => [
    messageId,
  ];
}
