import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:ui' as ui;
import '../../../../core/utils/styles_manager.dart';
import '../../../auth/view/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String imageProfile;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.imageProfile,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  IOWebSocketChannel? channel;

  TextEditingController messageController = TextEditingController();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    connect();
  }

  Future<void> connect() async {
    channel = IOWebSocketChannel.connect(
      ApiManager.webSocket + ConstantsManager.connectionToken!,
      headers: {"Authorization": ApiManager.authToken},
    );

    const String messageWithTrailingChars = '{"protocol":"json","version":1}';
    channel!.sink.add(messageWithTrailingChars);

    channel!.stream.listen((message) {
      //print("message is $message");
    });
  }

  sendMessage(Message message) {
    messages.add(message);
    setState(() {
      messages;
    });
    const String messagee =
        '{"type":1, "target":"PlayerSendMessageToOwner", "arguments":[{"PlayerId":1,"OwnerId":1,"Message":"Hi"}]}';
    channel!.sink.add(messagee);
    // socket!.emit('SendMessage', message.toJson());
    messageController.clear();
    imagePath = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appBar(
              context: context,
              receiverName: widget.receiverName,
              imageProfile: widget.imageProfile),
          Expanded(
              child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _messageWidget(message: messages[index], isSender: true),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      messages[index].dateOfMessage,
                      style: TextStyleManager.getCaptionStyle().copyWith(fontSize: 10.sp),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            itemCount: messages.length,
          )),
          if (imagePath != null)
            _messageInput(imagePath, () {
              setState(() {
                imagePath = null;
              });
            }),
          _sendButton((String? value) async {
            if (value == 'image') {
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  imagePath = pickedFile.path;
                });
              }
            } else if (value == 'voice') {
              // Add code to record and send voice note
            }
          }, () {
            setState(() {
              sendMessage(Message(
                  message: messageController.text,
                  senderId: ConstantsManager.userId!,
                  receiverId: 2,
                  dateOfMessage: DateFormat('hh:mm a').format(DateTime.now()),
                  imageUrl: null,
                  voiceNoteUrl: null));
            });
          }),
        ],
      ),
    );
  }
}

Widget _messageInput(String? image, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Image.file(
          File(image!),
          fit: BoxFit.cover,
        ),
        IconButton(
            onPressed: onTap,
            icon: const CircleAvatar(
                foregroundColor: ColorManager.white,
                child: Icon(
                  Icons.close,
                  color: ColorManager.primary,
                )))
      ],
    ),
  );
}

Widget _appBar({
  required BuildContext context,
  required String receiverName,
  required String imageProfile,
}) {
  return Container(
    height: 18.h,
    width: double.infinity,
    color: ColorManager.grey3.withOpacity(0.6),
    child: Padding(
      padding: EdgeInsetsDirectional.only(
        start: 5.w,
        end: 5.w,
        bottom: 3.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          backIcon(context),
          SizedBox(
            width: 5.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16.sp,
                backgroundColor: ColorManager.primary,
                backgroundImage: NetworkImage(imageProfile),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                receiverName,
                style: TextStyleManager.getSubTitleBoldStyle()
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _messageWidget({required Message message, required bool isSender}) {
  if (message.message != null) {
    return _textWidget(isSender: isSender, message: message.message!);
  }
  if (message.imageUrl != null) {
    return _imageWidget(isSender: isSender, image: message.imageUrl!);
  }
  if (message.voiceNoteUrl != null) {
    return _voiceWidget(isSender: isSender, voice: message.voiceNoteUrl!);
  }
  return Container();
}

Widget _textWidget({required bool isSender, required String message}) {
  return Align(
    alignment: isSender ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
    child: Container(
      decoration: BoxDecoration(
        color: ColorManager.grey3.withOpacity(0.4),
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(15.sp),
          topEnd: Radius.circular(15.sp),
          bottomEnd: isSender ? Radius.zero : Radius.circular(15.sp),
          bottomStart: isSender ? Radius.circular(15.sp) : Radius.zero,
        ),
      ),
      padding: EdgeInsetsDirectional.only(
        start: 5.w,
        end: 10.w,
        top: 2.h,
        bottom: 2.h,
      ),
      child: Text(
        message,
        style: TextStyleManager.getRegularStyle().copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

Widget _imageWidget({required bool isSender, required String image}) {
  return Align(
    alignment: isSender ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
    child: Container(
      height: 20.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: ColorManager.grey3.withOpacity(0.4),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(15.sp),
          topEnd: Radius.circular(15.sp),
          bottomEnd: isSender ? Radius.zero : Radius.circular(15.sp),
          bottomStart: isSender ? Radius.circular(15.sp) : Radius.zero,
        ),
      ),
    ),
  );
}

Widget _voiceWidget({
  required bool isSender,
  required String voice,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Align(
        alignment: isSender ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
        child: Directionality(
          textDirection: isSender ? ui.TextDirection.rtl : ui.TextDirection.ltr,
          child: VoiceMessageView(
            controller: VoiceController(
              audioSrc: voice,
              maxDuration: const Duration(seconds: 200),
              isFile: true,
              onComplete: () {
                /// do something on complete
              },
              onPause: () {
                /// do something on pause
              },
              onPlaying: () {
                /// do something on playing
              },
              onError: (err) {
                /// do somethin on error
              },
            ),
            innerPadding: 10.sp,
            cornerRadius: 15.sp,
            circlesColor: ColorManager.primary,
            backgroundColor: ColorManager.grey3.withOpacity(0.4),
            activeSliderColor: ColorManager.primary,
          ),
        ),
      ),
    ],
  );
}

Widget _sendButton(ValueChanged<String?> onTap, VoidCallback onSend) {
  return Padding(
    padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 1.h),
    child: Row(
      children: [
        SizedBox(
          height: 8.h,
          child: DropdownButton<String>(
              items: const [
                DropdownMenuItem<String>(
                  value: 'image',
                  child: Icon(Icons.image),
                ),
                DropdownMenuItem<String>(
                  value: 'voice',
                  child: Icon(Icons.mic),
                ),
              ],
              underline: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    backgroundColor: ColorManager.third,
                    radius: 19.sp,
                  ),
                  CircleAvatar(
                    backgroundColor: ColorManager.white,
                    radius: 15.sp,
                    child: Icon(
                      Icons.add,
                      size: 20.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
              onChanged: onTap),
        ),
        SizedBox(
          width: 3.w,
        ),
        Expanded(
          child: SizedBox(
            height: 6.h,
            child: TextField(
              decoration: InputDecoration(
                fillColor: ColorManager.grey3.withOpacity(0.3),
                filled: true,
                contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: 5.w,
                ),
                hintText: "Write a message ....",
                hintStyle: TextStyleManager.getCaptionStyle().copyWith(
                  fontSize: 10.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: onSend,
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
