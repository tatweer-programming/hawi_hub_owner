import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';

import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/styles_manager.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => NotificationWidget(
                    notification: AppNotification(
                        image:
                            "https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg",
                        DateTime.now(),
                        title: "title ${index + 1}",
                        body: "body ${index + 1} body body body  body body body  body body body ")),
                separatorBuilder: (context, index) => SizedBox(
                      height: 2.h,
                    ),
                itemCount: 10),
          ),
        ],
      )),
    );
  }
}
