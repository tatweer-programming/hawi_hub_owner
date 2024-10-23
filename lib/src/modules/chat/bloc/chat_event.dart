part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final MessageDetails message;

  const SendMessageEvent({required this.message});
}

class PickImageEvent extends ChatEvent {}


class StreamMessagesEvent extends ChatEvent {
  final bool withOwner;

  const StreamMessagesEvent({required this.withOwner});
}
class RemovePickedImageEvent extends ChatEvent {}

class GetConnectionEvent extends ChatEvent {}

class CloseConnectionEvent extends ChatEvent {}

class GetAllChatsEvent extends ChatEvent {
  final bool withOwner;

  const GetAllChatsEvent({required this.withOwner});
}

class GetChatMessagesEvent extends ChatEvent {
  final int conversationId;
  final int index;
  final bool withOwner;

  GetChatMessagesEvent(
      {required this.withOwner,
        required this.conversationId,
        required this.index});
}

class ScrollingDownEvent extends ChatEvent {
  final ScrollController listScrollController;

  ScrollingDownEvent({required this.listScrollController});
}
