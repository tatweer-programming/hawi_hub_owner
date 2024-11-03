import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../../core/apis/api.dart';

//ignore: must_be_immutable
class MessageDetails extends Equatable {
  final int? conversationId;
  final String? connectionId;
  final bool? isOwner;
  String? message;
  String? attachmentUrl;
  final DateTime? timeStamp;
  String? voiceNoteUrl;

  MessageDetails({
    this.voiceNoteUrl,
    this.connectionId,
    this.conversationId,
    this.message,
    this.timeStamp,
    this.isOwner,
    this.attachmentUrl,
  });

  factory MessageDetails.fromJson(Map<String, dynamic> json,bool withPlayer) {
    return MessageDetails(
      message: json["messageContent"],
      attachmentUrl: json["messageAttachmentUrl"] != null
          ? ApiManager.handleImageUrl(json["messageAttachmentUrl"])
          : null,
      timeStamp: DateTime.parse(json["timestamp"]).toLocal(),
      isOwner: withPlayer ?json["playerToOwner"]:json["adminToOwner"],
    );
  }

  String jsonBody(bool withPlayer) {
    print(toJson());
    String argumentsJson = jsonEncode([toJson()]);
    if(withPlayer){
      return '{"type":1, "target":"SendMessageFromOwnerToPlayer", "arguments":$argumentsJson}';
    }
    return '{"type":1, "target":"SendMessageFromOwnerToAdmin", "arguments":$argumentsJson}';
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
