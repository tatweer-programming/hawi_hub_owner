part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final MessageDetails message;
  final bool withPlayer;

  const SendMessageEvent({required this.message,required this.withPlayer});
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
  final bool withPlayer;

  const GetAllChatsEvent({required this.withPlayer});
}

class GetChatMessagesEvent extends ChatEvent {
  final int conversationId;
  final bool withPlayer;

  GetChatMessagesEvent(
      {required this.withPlayer,
        required this.conversationId,});
}

class ScrollingDownEvent extends ChatEvent {
  final ScrollController listScrollController;

  ScrollingDownEvent({required this.listScrollController});
}
