import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/chat/bloc/chat_bloc.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/chat.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/message.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../auth/view/widgets/widgets.dart';
import '../../data/models/message_details.dart';

class ChatScreen extends StatelessWidget {
  final ChatBloc chatBloc;
  final Chat? chat;

  const ChatScreen({
    super.key,
    required this.chat,
    required this.chatBloc,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    final ScrollController scrollController = ScrollController();
    chatBloc.add(GetConnectionEvent());
    Message? message;
    String? imagePath;
    List<MessageDetails> messages = [];
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is GetChatMessagesSuccessState) {
          message = state.messages;
          messages = message!.message;
          if (messages.isNotEmpty) {
            chatBloc.add(
                ScrollingDownEvent(listScrollController: scrollController));
          }
        }
        if (state is StreamMessagesSuccessState) {
          print("object");
          messages.add(state.streamMessage);
          chatBloc
              .add(ScrollingDownEvent(listScrollController: scrollController));
        }
        if (state is PickImageState) {
          imagePath = state.imagePath;
        } else if (state is RemovePickedImageState) {
          imagePath = null;
        }
        if (state is SendMessageSuccessState) {
          if (state.message.attachmentUrl != null) {
            state.message.attachmentUrl =
                ApiManager.handleImageUrl(state.message.attachmentUrl!);
          }
          messages.add(state.message);
          chatBloc
              .add(ScrollingDownEvent(listScrollController: scrollController));
          messageController.clear();
          imagePath = null;
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, res) async {
            chatBloc.add(CloseConnectionEvent());
          },
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appBar(
                  context: context,
                  receiverName: chat!.lastMessage.player.userName,
                  imageProfile: chat!.lastMessage.player.profilePictureUrl,
                  chatBloc: chatBloc,
                ),
                SizedBox(height: 1.h),
                Expanded(
                    child: ListView.separated(
                  padding: EdgeInsetsDirectional.zero,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    String formattedDate = '';
                    if (messages[index].timeStamp != null) {
                      formattedDate = DateFormat('hh:mm a')
                          .format(messages[index].timeStamp!);
                    }
                    bool? isOwner = messages[index].isOwner;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Column(
                        crossAxisAlignment: !isOwner!
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          _messageWidget(
                              message: messages[index], isSender: !isOwner),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            formattedDate,
                            style: TextStyleManager.getCaptionStyle().copyWith(
                                fontSize: 10.sp, color: ColorManager.black),
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
                    chatBloc.add(RemovePickedImageEvent());
                  }),
                if (message != null &&
                    message!.lastTimeToChat.compareTo(DateTime.now().add(const Duration(hours: 1))) >= 0)
                  _sendButton(
                    (String? value) async {
                      if (value == 'image') {
                        chatBloc.add(PickImageEvent());
                      }
                    },
                    () {
                      if (messageController.text.isNotEmpty ||
                          imagePath != null) {
                        chatBloc.add(SendMessageEvent(
                          message: MessageDetails(
                            message: messageController.text,
                            conversationId: chat!.conversationId,
                            attachmentUrl: imagePath,
                            isOwner: false,
                            timeStamp: DateTime.now(),
                          ),
                        ));
                      }
                    },
                    messageController,
                  ),
              ],
            ),
          ),
        );
      },
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
  required String? imageProfile,
  required ChatBloc chatBloc,
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
          backIcon(
              context: context,
              onTap: () {
                chatBloc.add(CloseConnectionEvent());
                context.pop();
              }),
          SizedBox(
            width: 5.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16.sp,
                backgroundColor: ColorManager.primary,
                backgroundImage:
                    imageProfile == null ? null : NetworkImage(imageProfile),
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

Widget _messageWidget(
    {required MessageDetails message, required bool isSender}) {
  if (message.message != null) {
    return _textWidget(isSender: isSender, message: message.message!);
  } else if (message.attachmentUrl != null) {
    return _imageWidget(isSender: isSender, image: message.attachmentUrl!);
  }
  return Container();
}

Widget _textWidget({required bool isSender, required String message}) {
  return Align(
    alignment:
        isSender ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
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
    alignment:
        isSender ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
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

// Widget _voiceWidget({
//   required bool isSender,
//   required String voice,
//   required bool isFile,
// }) {
//   print("voice" + voice);
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Align(
//         alignment: isSender
//             ? AlignmentDirectional.topEnd
//             : AlignmentDirectional.topStart,
//         child: Directionality(
//           textDirection: isSender ? ui.TextDirection.rtl : ui.TextDirection.ltr,
//           child: VoiceMessageView(
//             controller: VoiceController(
//               audioSrc: voice,
//               maxDuration: const Duration(seconds: 200),
//               isFile: true,
//               onComplete: () {
//                 /// do something on complete
//               },
//               onPause: () {
//                 /// do something on pause
//               },
//               onPlaying: () {
//                 /// do something on playing
//               },
//               onError: (err) {
//                 /// do somethin on error
//               },
//             ),
//             innerPadding: 10.sp,
//             cornerRadius: 15.sp,
//             circlesColor: ColorManager.primary,
//             backgroundColor: ColorManager.grey3.withOpacity(0.4),
//             activeSliderColor: ColorManager.primary,
//           ),
//         ),
//       ),
//     ],
//   );
// }

Widget _sendButton(ValueChanged<String?> onTap, VoidCallback onSend,
    TextEditingController messageController) {
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
            onChanged: onTap,
          ),
        ),
        SizedBox(
          width: 3.w,
        ),
        Expanded(
          child: SizedBox(
            height: 6.h,
            child: TextField(
              controller: messageController,
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
