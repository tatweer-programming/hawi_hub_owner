import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawi_hub_owner/src/modules/chat/bloc/chat_bloc.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/chat.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/last_message.dart';
import 'package:hawi_hub_owner/src/modules/chat/view/screens/chat_screen.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';

class ChatsScreen extends StatelessWidget {
  final bool withPlayer;

  const ChatsScreen({super.key, required this.withPlayer});

  @override
  Widget build(BuildContext context) {
    ChatBloc chatBloc = context.read<ChatBloc>()
      ..add(GetAllChatsEvent(withPlayer: withPlayer));
    List<Chat> chats = [];
    return RefreshIndicator(
      onRefresh: () async {
        chatBloc.add(GetAllChatsEvent(withPlayer: withPlayer));
      },
      child: Scaffold(
        body: Column(
          children: [
            _appBar(context),
            Expanded(
              child: BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is GetAllChatsSuccessState) {
                    chats = state.chats;
                    Chat.sortChatsByDate(chats);
                  }
                },
                builder: (context, state) {
                  if (state is GetAllChatsSuccessState || chats.isNotEmpty) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => _chatWidget(
                                    lastMessage: chats[index].lastMessage,
                                    onTap: () {
                                      context.pushWithTransition(ChatScreen(
                                        chatBloc: chatBloc,
                                        chat: chats[index],
                                        withPlayer: withPlayer,
                                      ));
                                      chatBloc.add(GetChatMessagesEvent(
                                        conversationId:
                                            chats[index].conversationId,
                                        withPlayer: withPlayer,
                                      ));
                                    },
                                  ),
                              itemCount: chats.length),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    );
                  } else if (state is GetAllChatsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetAllChatsErrorState) {
                    return Center(
                        child: Text(
                      S.of(context).somethingWentWrong,
                      style: TextStyleManager.getSubTitleBoldStyle(),
                    ));
                  } else {
                    return Center(
                        child: Text(S.of(context).noChatsFound,
                            style: TextStyleManager.getSubTitleBoldStyle()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _appBar(
  BuildContext context,
) {
  return CustomAppBar(
    blendMode: BlendMode.exclusion,
    backgroundImage: "assets/images/app_bar_backgrounds/5.webp",
    height: 30.h,
    child: Padding(
      padding: EdgeInsetsDirectional.only(
        start: 5.w,
        end: 5.w,
        top: 5.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          backIcon(context: context),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Text(
              "Conversations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
                fontSize: 30.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _chatWidget(
    {required LastMessage lastMessage, required VoidCallback onTap}) {
  String formattedDate =
      DateFormat('hh:mm a').format(lastMessage.timestamp!) ?? "";
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 7.w,
      vertical: 2.h,
    ),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorManager.grey3,
            radius: 22.sp,
            backgroundImage: lastMessage.player == null ||
                    lastMessage.player!.profilePictureUrl == null
                ? null
                : NetworkImage(lastMessage.player!.profilePictureUrl!),
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage.player == null
                            ? ""
                            : lastMessage.player!.userName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyleManager.getCaptionStyle()
                          .copyWith(fontSize: 10.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  lastMessage.messageContent ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyleManager.getRegularStyle(),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
