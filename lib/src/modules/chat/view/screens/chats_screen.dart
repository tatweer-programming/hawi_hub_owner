import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawi_hub_owner/src/modules/chat/bloc/chat_bloc.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/chat.dart';
import 'package:hawi_hub_owner/src/modules/chat/view/screens/chat_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatBloc chatBloc = ChatBloc.get(context)..add(GetConnectionEvent());
    Chat chat = const Chat(
      dateOfLastSeen: "05:00 PM",
      imageProfile:
          "https://static.wikia.nocookie.net/hunterxhunter/images/3/3e/HxH2011_EP147_Gon_Portrait.png/revision/latest?cb=20230904181801",
      lastMessage: "Bye",
      name: "John",
      numberOfUnreadMessages: 1,
      userId: '',
    );
    List<Chat> chats = [
      chat,
      chat,
      chat,
      chat,
      chat,
    ];
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {},
      child: RefreshIndicator(
        onRefresh: () async {
          // chatBloc.add(GetChatsEvent());
        },
        child: Scaffold(
          body: Column(
            children: [
              _appBar(context),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _chatWidget(
                          chat: chats[index],
                          onTap: () {
                            context.pushWithTransition(ChatScreen(
                                receiverId: chats[index].userId,
                                receiverName: chats[index].name,
                                imageProfile: chats[index].imageProfile));
                          },
                        ),
                    itemCount: 2),
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
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
          backIcon(context),
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

Widget _chatWidget({required Chat chat, required VoidCallback onTap}) =>
    Padding(
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
              backgroundImage: NetworkImage(chat.imageProfile),
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
                          chat.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        chat.dateOfLastSeen,
                        style: TextStyleManager.getCaptionStyle()
                            .copyWith(fontSize: 10.sp),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyleManager.getRegularStyle(),
                        ),
                      ),
                      if (chat.numberOfUnreadMessages > 0)
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 0.4.h,
                            horizontal: 1.5.w,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.golden,
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                          child: Text(
                            chat.numberOfUnreadMessages.toString(),
                            style: TextStyleManager.getRegularStyle().copyWith(
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
