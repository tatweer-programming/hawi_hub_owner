import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/chat.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/message.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/services/chat_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:web_socket_channel/io.dart';

part 'chat_state.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  static ChatBloc get(BuildContext context) =>
      BlocProvider.of<ChatBloc>(context);

  // ChatRepository chatRepository = ChatRepository();
  final ChatService _service = ChatService();
  AudioPlayer audioPlayer = AudioPlayer();
  String statusText = "Message";
  String? voiceNoteFilePath;
  double voiceDuration = 0;
  bool isComplete = false;
  bool isPlaying = false;
  Record record = Record();
  int voiceNoteDuration = 0;

  ChatBloc(ChatInitial chatInitial) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is StartRecordingEvent) {
        await startRecord();
        emit(StartRecordState());
      } else if (event is EndRecordingEvent) {
        await stopRecord();
        emit(EndRecordState());
      } else if (event is ScrollingDownEvent) {
        // if (event.listScrollController.hasClients) {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          final position = event.listScrollController.position.maxScrollExtent;
          event.listScrollController.jumpTo(position);
          //print("object");
        });
        emit(ScrollingDownState());
        // }
      } else if (event is TurnOnRecordUrlEvent) {
        if (!event.isPlaying) {
          await audioPlayer.play(UrlSource(event.voiceNoteUrl));
          event.isPlaying = true;
        } else {
          await audioPlayer.stop();
          event.isPlaying = false;
        }
        emit(PlayRecordUrlState(
            voiceNoteUrl: event.voiceNoteUrl, isPlaying: event.isPlaying));
        audioPlayer.onPlayerComplete.listen((_) {
          add(CompleteRecordEvent(
              isFile: false,
              voiceNote: event.voiceNoteUrl,
              isPlaying: event.isPlaying));
        });
      } else if (event is TurnOnRecordFileEvent) {
        await audioPlayer.play(DeviceFileSource(voiceNoteFilePath!));
        isPlaying = true;
        emit(PlayRecordFileState());
        audioPlayer.onPlayerComplete.listen((_) {
          add(CompleteRecordEvent(
              isFile: true,
              voiceNote: voiceNoteFilePath!,
              isPlaying: isPlaying));
        });
      } else if (event is CompleteRecordEvent) {
        if (event.isFile) {
          isPlaying = false;
          emit(CompleteRecordFileState());
        } else {
          event.isPlaying = false;
          emit(CompleteRecordUrlState(
              voiceNoteUrl: event.voiceNote, isPlaying: event.isPlaying));
        }
      } else if (event is PickImageEvent) {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(PickImageState(imagePath: pickedFile.path));
        }
      } else if (event is RemovePickedImageEvent) {
        emit(RemovePickedImageState());
      } else if (event is RemoveRecordEvent) {
        voiceNoteFilePath = null;
        emit(RemoveRecordState());
      } else if (event is GetConnectionEvent) {
        var response = await _service.connection();
        response.fold((l) {}, (r) {
          emit(GetConnectionSuccessState());
        });
      } else if (event is GetAllChatsEvent) {
        emit(GetAllChatsLoadingState());
        var response = await _service.getAllChats();
        response.fold((l) {
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
      }
    });
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = "${storageDirectory.path}/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/${DateTime.now().millisecondsSinceEpoch.toString()}.mp3";
  }

  Future<void> startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer
          .play(AssetSource("audios/notiication_start_recording.wav"));
      statusText = "Recording...";
      audioPlayer.onPlayerComplete.listen((_) async {
        voiceNoteFilePath = await getFilePath();
        statusText = "Message";
        isComplete = false;
        if (await record.hasPermission()) {
          record.start();
        }
      });
    } else {
      statusText = "No microphone permission";
    }
  }

  Future<void> stopRecord() async {
    AudioPlayer audioPlayer = AudioPlayer();
    voiceNoteFilePath = await record.stop();
    double seconds = 0;
    await audioPlayer.setSource(DeviceFileSource(voiceNoteFilePath!));
    await audioPlayer.getDuration().then((value) {
      if (value != null) {
        seconds = value.inSeconds.toDouble();
      }
    });
    voiceNoteDuration = seconds.round();
    AudioPlayer audioPlayerAsset = AudioPlayer();
    await audioPlayerAsset
        .play(AssetSource("audios/notiication_end_recording.wav"));
    audioPlayerAsset.onPlayerComplete.listen((_) {
      if (voiceNoteFilePath != null) {
        statusText = "Message";
        isComplete = true;
      }
    });
  }
}
