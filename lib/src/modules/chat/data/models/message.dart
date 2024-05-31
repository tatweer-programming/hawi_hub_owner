import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';

//ignore: must_be_immutable
class Message extends Equatable {
  final int? conversationId;
  final String? connectionId;
  final bool? isOwner;
  final String? message;
  final String? attachmentUrl;
  final String? timeStamp;
  String? voiceNoteUrl;

  Message({
    this.voiceNoteUrl,
    this.connectionId,
    this.conversationId,
    this.message,
    this.timeStamp,
    this.isOwner,
    this.attachmentUrl,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json["messageContent"],
      attachmentUrl: json["messageAttachmentUrl"] != null
          ? ApiManager.handleImageUrl(json["messageAttachmentUrl"])
          : null,
      timeStamp: json["timestamp"],
      isOwner: json["playerToOwner"],
    );
  }

  String jsonBody() {
    String argumentsJson = jsonEncode([toJson()]);
    return '{"type":1, "target":"SendMessageToPlayer", "arguments":$argumentsJson}';
  }

  Map<String, dynamic> toJson() {
    return {
      "ConversationId": conversationId,
      "Message": message,
      "AttachmentUrl": attachmentUrl
    };
  }

  @override
  List<Object?> get props => [message, attachmentUrl];
}
