import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/notification_shimmers.dart';

import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/styles_manager.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get()..getNotifications();

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          CustomAppBar(
            //color:  ,
            opacity: .1,
            // blendMode: BlendMode.saturation,
            backgroundImage: "assets/images/app_bar_backgrounds/2.webp",
            height: 35.h,
            actions: const [
              //   Icon(Icons.notifications),
            ],
            child: Text(
              style: TextStyleManager.getAppBarTextStyle(),
              S.of(context).notifications,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: BlocBuilder<MainCubit, MainState>(
              bloc: cubit,
              builder: (context, state) {
                return state is GetNotificationsLoading
                    ? const Center(
                        child: VerticalNotificationsShimmer(),
                      )
                    : cubit.notifications.isEmpty
                        ? Center(
                            child: SubTitle(S.of(context).noAlerts),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                NotificationWidget(notification: cubit.notifications[index]),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 2.h,
                                ),
                            itemCount: cubit.notifications.length);
              },
            ),
          ),
        ],
      )),
    );
  }
}
