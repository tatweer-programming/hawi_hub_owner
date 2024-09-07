import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/chat.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/message.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/services/chat_service.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/message_details.dart';

part 'chat_state.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  static ChatBloc get(BuildContext context) =>
      BlocProvider.of<ChatBloc>(context);

  final ChatService _service = ChatService();

  ChatBloc(ChatInitial chatInitial) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is ScrollingDownEvent) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom(event.listScrollController);
        });
        emit(ScrollingDownState());
      } else if (event is PickImageEvent) {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(PickImageState(imagePath: pickedFile.path));
        }
      } else if (event is RemovePickedImageEvent) {
        emit(RemovePickedImageState());
      } else if (event is GetConnectionEvent) {
        var response = await _service.connection();
        response.fold((l) {}, (r) {
          emit(GetConnectionSuccessState());
          add(StreamMessagesEvent());
        });
      }else if (event is CloseConnectionEvent) {
        await _service.closeConnection();
        emit(CloseConnectionSuccessState());
      }  else if (event is GetAllChatsEvent) {
        emit(GetAllChatsLoadingState());
        var response = await _service.getAllChats();
        response.fold((l) {
          print(l);
          emit(GetAllChatsErrorState(l));
        }, (chats) {
          emit(GetAllChatsSuccessState(chats));
        });
      } else if (event is GetChatMessagesEvent) {
        emit(GetChatMessagesLoadingState());
        var response = await _service.getChatMessages(event.conversationId);
        response.fold((l) {
          emit(GetChatMessagesErrorState(l));
        }, (messages) {
          emit(GetChatMessagesSuccessState(
            messages: messages,
            index: event.index,
          ));
        });
      } else if (event is SendMessageEvent) {
        emit(GetChatMessagesLoadingState());
        var response = await _service.sendMessage(
          message: event.message,
        );
        response.fold((l) {
          emit(SendMessageErrorState(l));
        }, (r) {
          emit(SendMessageSuccessState(event.message));
        });
      } else if (event is StreamMessagesEvent) {
        var stream = _service.streamMessage();
        await for (MessageDetails message in stream) {
          emit(StreamMessagesSuccessState(message));
        }
      }
    });
  }

  void _scrollToBottom(ScrollController scrollController) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
}
