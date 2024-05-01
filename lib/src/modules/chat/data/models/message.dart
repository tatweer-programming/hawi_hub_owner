import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Message extends Equatable {
  String? messageId;
  String? imageUrl;
  String? message;
  String? imageFilePath;
  final int senderId;
  final String dateOfMessage;
  final int receiverId;
  String? voiceNoteUrl;
  String? voiceNoteFilePath;

  Message({
    this.voiceNoteFilePath,
    this.voiceNoteUrl,
    this.imageUrl,
    this.message,
    this.messageId,
    this.imageFilePath,
    required this.dateOfMessage,
    required this.senderId,
    required this.receiverId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      imageUrl: json["imageUrl"],
      dateOfMessage: json["dateOfMessage"],
      message: json["message"],
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      voiceNoteUrl: json["voiceNoteUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "senderId": senderId,
      // "voice": voiceNoteFilePath,
      // "image": imageFilePath,
      // "dateOfMessage": dateOfMessage,
      "message": message,
      "name": senderId,
      // "receiverId": receiverId,
    };
  }

  @override
  List<Object?> get props => [senderId, message, receiverId];
}
