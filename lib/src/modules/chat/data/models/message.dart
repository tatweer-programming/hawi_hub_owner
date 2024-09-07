
import 'package:equatable/equatable.dart';

import 'message_details.dart';

class Message extends Equatable {
  final DateTime lastTimeToChat;
  final List<MessageDetails> message;

  const Message({
    required this.lastTimeToChat,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      lastTimeToChat: DateTime.parse(json["lastTimeToChat"]).toLocal().add(Duration(hours: 3)),
      message: List<MessageDetails>.from(
        json["messages"]
            .map((message) => MessageDetails.fromJson(message))
            .toList(),
      ),
    );
  }

  @override
  List<Object?> get props => [lastTimeToChat, message];
}
