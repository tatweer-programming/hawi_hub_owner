import 'package:equatable/equatable.dart';
import '../../../auth/data/models/player.dart';

class LastMessage extends Equatable {
  final int? messageId;
  final String? messageContent;
  final String? messageAttachmentUrl;
  final bool? playerToOwner;
  final DateTime? timestamp;
  final Player? player;

  const LastMessage({
    required this.messageId,
    required this.messageContent,
    required this.messageAttachmentUrl,
    required this.playerToOwner,
    required this.timestamp,
    required this.player,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json, bool withPlayer) {
    return LastMessage(
      messageId: json["messageId"],
      messageContent: json["messageContent"],
      messageAttachmentUrl: json["messageAttachmentUrl"],
      playerToOwner: withPlayer ? json["playerToOwner"] : json["adminToOwner"],
      timestamp: DateTime.parse(json["timestamp"]??DateTime.now().toLocal().toString()),
      player: withPlayer ? Player.fromJson(json["player"]) : null,
    );
  }

  @override
  List<Object?> get props => [
        messageId,
      ];
}
