part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final Message message;

  const SendMessageEvent({required this.message});
}

class PickImageEvent extends ChatEvent {}

class StreamMessagesEvent extends ChatEvent {}

class RemovePickedImageEvent extends ChatEvent {}

class GetConnectionEvent extends ChatEvent {}

class CloseConnectionEvent extends ChatEvent {}

class GetAllChatsEvent extends ChatEvent {}

class GetChatMessagesEvent extends ChatEvent {
  final int conversationId;
  final int index;

  GetChatMessagesEvent({required this.conversationId, required this.index});
}

class ScrollingDownEvent extends ChatEvent {
  final ScrollController listScrollController;

  ScrollingDownEvent({required this.listScrollController});
}
