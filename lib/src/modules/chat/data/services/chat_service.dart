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
        print("updated");
        print(response.data['message']);
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

  Future<Either<String, Unit>> sendMessage({required Message message}) async {
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

  Stream<Message> streamMessage() {
    try {
      StreamController<Message> messageStreamController =
          StreamController<Message>.broadcast();
      socket!.listen((data) {
        print("data  $data");
        if (data != '{"type":6}' && data != '{}') {
          String message =
              data.toString().replaceAll(RegExp(r'[\x00-\x1F]+'), '');
          final Map<String, dynamic> jsonData = jsonDecode(message);
          print("jsonData         ");
          print(jsonData);
          messageStreamController.add(Message(
            message: jsonData["arguments"][0]["playerMessage"],
            attachmentUrl: jsonData["arguments"][0]["playerAttachmentUrl"],
            isOwner: true,
            timeStamp: DateTime.now(),
          ));
        }
      });
      return messageStreamController.stream;
    } catch (e) {
      print("e         $e");
      return const Stream.empty();
    }
  }

  Future<Either<String, List<Message>>> getChatMessages(
      int conversationId) async {
    try {
      Response response = await DioHelper.getData(
        path: EndPoints.getConversation + conversationId.toString(),
      );
      if (response.statusCode == 200) {
        List<Message> messages = [];
        for (var item in response.data["messages"]) {
          messages.add(Message.fromJson(item));
        }
        return Right(messages);
      }
      return Left(response.data.toString());
    } catch (e) {
      print(e);
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
    const String messageWithTrailingChars = '{"protocol":"json","version":1}';
    try{

      socket = await WebSocket.connect(
          "${ApiManager.webSocket}?id=${ConstantsManager.connectionToken!}");
      socket!.add(messageWithTrailingChars);
      print("Connected");
    }catch (e){
      print("Error in connection $e");
    }
  }

  Future<void> closeConnection() async {
    if (socket != null) {
      await socket!
          .close(WebSocketStatus.normalClosure, 'Disconnected by client');
      socket = null;
    }
  }
}
