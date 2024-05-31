
import 'package:equatable/equatable.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';

//ignore: must_be_immutable
class StreamMessage extends Equatable {
  final int? conversationId;
  final String? message;
  final String? attachmentUrl;
  final String? timeStamp;
  String? voiceNoteUrl;

  StreamMessage({
    this.voiceNoteUrl,
    this.conversationId,
    this.message,
    this.timeStamp,
    this.attachmentUrl,
  });

  factory StreamMessage.fromJson(Map<String, dynamic> json) {
    return StreamMessage(
      message: json["ownerMessage"],
      attachmentUrl: json["playerAttachmentUrl"] != null
          ? ApiManager.handleImageUrl(json["playerAttachmentUrl"])
          : null,
    );
  }

  @override
  List<Object?> get props => [message, attachmentUrl];
}
