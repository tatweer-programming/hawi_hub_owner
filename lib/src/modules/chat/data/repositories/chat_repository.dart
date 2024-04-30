// import 'package:dartz/dartz.dart';
//
// import '../models/chat.dart';
// import '../models/message.dart';
// import '../services/chat_service.dart';
//
// class ChatRepository {
//   ChatService service = ChatService();
//
//   Either<FirebaseException, Stream<List<Message>>> getMessage({
//     required String receiverId,
//   }) {
//     return service.getMessage(receiverId: receiverId);
//   }
//
//   Future<Either<FirebaseException, Unit>> endChat(String receiverId) {
//     return service.endChat(receiverId);
//   }
//
//   Future<Either<FirebaseException, Unit>> sendMessage(
//       {required Message message}) async {
//     return await service.sendMessage(message: message);
//   }
//
//   Future<Either<FirebaseException, List<Chat>>> getChats() async {
//     return await service.getChats();
//   }
// }
