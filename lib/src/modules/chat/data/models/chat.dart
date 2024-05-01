import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String name;
  final String lastMessage;
  final String imageProfile;
  final String dateOfLastSeen;
  final String userId;
  final int numberOfUnreadMessages;

  const Chat({
    required this.name,
    required this.lastMessage,
    required this.imageProfile,
    required this.dateOfLastSeen,
    required this.userId,
    required this.numberOfUnreadMessages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      name: json["name"],
      lastMessage: json["lastMessage"],
      imageProfile: json["imageProfile"],
      dateOfLastSeen: json["dateOfLastSeen"],
      userId: json["userId"],
      numberOfUnreadMessages: json["numberOfUnreadMessages"],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    name,
  ];
  // Map<String, dynamic> toJson() {
  //   return {
  //     "receiverName": receiverName,
  //     "receiverId": receiverId,
  //   };
  // }

}
