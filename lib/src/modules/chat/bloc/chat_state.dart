part of 'chat_bloc.dart';

abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {}

class GetMessagesSuccessState extends ChatState {
  final Stream<List<MessageDetails>> messages;

  const GetMessagesSuccessState(this.messages);
}

class SendMessageLoadingState extends ChatState {}

class SendMessageErrorState extends ChatState {
  final String error;

  SendMessageErrorState(this.error);
}

class SendMessageSuccessState extends ChatState {
  final MessageDetails message;

  SendMessageSuccessState(this.message);
}

class GetConnectionSuccessState extends ChatState {}

class CloseConnectionSuccessState extends ChatState {}

//GetAllChats
class GetAllChatsSuccessState extends ChatState {
  final List<Chat> chats;

  GetAllChatsSuccessState(this.chats);
}

class GetAllChatsLoadingState extends ChatState {}

class GetAllChatsErrorState extends ChatState {
  final String error;

  GetAllChatsErrorState(this.error);
}

//GetChatMessages
class GetChatMessagesSuccessState extends ChatState {
  final Message messages;
  final int index;

  GetChatMessagesSuccessState({required this.messages, required this.index});
}

class GetChatMessagesLoadingState extends ChatState {}

class GetChatMessagesErrorState extends ChatState {
  final String error;

  GetChatMessagesErrorState(this.error);
}

//stream messages
class StreamMessagesSuccessState extends ChatState {
  MessageDetails streamMessage;

  StreamMessagesSuccessState(this.streamMessage);
}

class ScrollingDownState extends ChatState {}

class EndChatErrorState extends ChatState {
  final String error;

  const EndChatErrorState(this.error);
}

class PickImageState extends ChatState {
  final String imagePath;

  PickImageState({required this.imagePath});
}

class RemovePickedImageState extends ChatState {}

class GetChatSuccessfullyState extends ChatState {}

class GetChatErrorState extends ChatState {}
