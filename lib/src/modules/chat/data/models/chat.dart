import 'package:equatable/equatable.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/last_message.dart';

class Chat extends Equatable {
  final int ownerId;
  final int conversationId;
  final LastMessage lastMessage;

  const Chat({
    required this.ownerId,
    required this.conversationId,
    required this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json,bool withPlayer) {
    return Chat(
      conversationId: json["conversationId"],
      ownerId: json["ownerId"],
      lastMessage: LastMessage.fromJson(json["lastMessage"],withPlayer),
    );
  }
  static void sortChatsByDate(List<Chat> chats) {
    chats.sort((a, b) => b.lastMessage.timestamp!.compareTo(a.lastMessage.timestamp!));
  }
  @override
  List<Object?> get props => [];
}
