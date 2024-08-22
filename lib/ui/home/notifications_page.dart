import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/ui/home/widget/notification_alert_widget.dart';
import 'package:trendify/values/export.dart';
import 'package:trendify/values/extensions/widget_ext.dart';

import '../../generated/assets.dart';
import '../../router/app_router.dart';
import '../../values/colors.dart';

@RoutePage()
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: AppColor.black,
          ),
          onPressed: () => appRouter.pop(),
        ),
        title: Text("Notifications",style: textMedium.copyWith(color: AppColor.black,fontSize: 20.spMin),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.white,
      ),
      body: Column(
        children: [
        NotificationAlertWidget(
        imagePath: Assets.imageNotifactiontwo,
        title: "Nitu Desia ",
        time: authStore.getCurrentTime(),
        backgroundColor: AppColor.white, // Optional: set a different color if needed
          type: 1,
          subtitle: " Followed",
      ),
          NotificationAlertWidget(
            imagePath: Assets.imageNotifactionone,
            title: "Trevor Buntain",
            time: authStore.getCurrentTime(),
            backgroundColor: AppColor.mercury, // Optional: set a different color if needed
            type: 2,
            subtitle: " liked your post",
          ),
          NotificationAlertWidget(
            imagePath: Assets.imageNotifactionthree,
            title: "Trevor Buntain ",
            time: authStore.getCurrentTime(),
            backgroundColor: AppColor.mercury, // Optional: set a different color if needed
            type: 3,
            subtitle: " commented your post",
            comment: "It is a long established fact that a reader will be distracted by the readable",
            commentImage: Assets.imageComment,
          ),
        ],
      ),
    );
  }
}


