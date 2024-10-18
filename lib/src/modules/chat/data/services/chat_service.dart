import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/chat.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/connection.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/message.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/message_details.dart';

class ChatService {
  WebSocket? socket;

  Future<Either<String, Unit>> connection() async {
    try {
      Response response = await DioHelper.postData(
        path: EndPoints.getConnection,
        data: {},
      );
      if (response.statusCode == 200) {
        Connection connection = Connection.fromJson(response.data);
        ConstantsManager.connectionToken = connection.token;
        ConstantsManager.connectionId = connection.id;
        await _startConnection();
        await _addConnectionId();
        return const Right(unit);
      }
      return Left(response.data.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> _addConnectionId() async {
    try {
      Response response = await DioHelper.postData(
        path: EndPoints.addConnectionId + ConstantsManager.userId.toString(),
        data: {
          "ownerConnectionId": ConstantsManager.connectionId.toString(),
        },
      );
      if (response.statusCode == 200) {
        return response.data['message'];
      }
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Chat>>> getAllChats() async {
    try {
      Response response = await DioHelper.getData(
        path: EndPoints.getOwnerConversations +
            ConstantsManager.userId.toString(),
      );
      if (response.statusCode == 200) {
        List<Chat> chats = [];
        for (var item in response.data) {
          chats.add(Chat.fromJson(item));
        }
        return Right(chats);
      }
      return Left(response.data.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> sendMessage({required MessageDetails message}) async {
    try {
      if (message.attachmentUrl != null) {
        message.attachmentUrl =
            await uploadFile(message.attachmentUrl!, message.conversationId!);
        message.message = null;
      }
      socket!.add(message.jsonBody());
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Stream<MessageDetails> streamMessage() {
    try {
      StreamController<MessageDetails> messageStreamController =
          StreamController<MessageDetails>.broadcast();
      socket!.listen((data) {
        print("data from owner  $data");
        if (data != '{"type":6}' && data != '{}') {
          String message =
              data.toString().replaceAll(RegExp(r'[\x00-\x1F]+'), '');
          final Map<String, dynamic> jsonData = jsonDecode(message);
          messageStreamController.add(MessageDetails(
            message: jsonData["arguments"][0]["playerMessage"],
            attachmentUrl: jsonData["arguments"][0]["playerAttachmentUrl"],
            isOwner: true,
            timeStamp: DateTime.now().add(Duration(hours: 3)),
          ));
        }
      });
      return messageStreamController.stream;
    } catch (e) {
      return const Stream.empty();
    }
  }

  Future<Either<String, Message>> getChatMessages(
      int conversationId) async {
    try {
      Response response = await DioHelper.getData(
        path: EndPoints.getConversation + conversationId.toString(),
      );
      if (response.statusCode == 200) {
        Message messages = Message.fromJson(response.data);
        return Right(messages);
      }
      return Left(response.data.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> uploadFile(String filePath, int conversationId) async {
    try {
      FormData formData = FormData.fromMap({
        "ConversationId": conversationId.toString(),
        "ConversationAttachment": MultipartFile.fromFileSync(filePath),
      });
      Response response = await DioHelper.postFormData(
          EndPoints.uploadConversationAttachment, formData);
      if (response.statusCode == 200) {
        return response.data['conversationImageUrl'];
      }
      return response.data.toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> _startConnection() async {
    await closeConnection();
    const String messageWithTrailingChars = '{"protocol":"json","version":1}';
    socket = await WebSocket.connect(
        "${ApiManager.webSocket}?id=${ConstantsManager.connectionToken!}");
    socket!.add(messageWithTrailingChars);
  }

  Future<void> closeConnection() async {
    if (socket != null) {
      await socket!
          .close(WebSocketStatus.normalClosure, 'Disconnected by client');
      socket = null;
    }
  }
}
