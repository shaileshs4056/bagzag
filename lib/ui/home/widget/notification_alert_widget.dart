import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/extensions/widget_ext.dart';
import 'package:trendify/values/style.dart';
import 'package:trendify/widget/app_image.dart';

import '../../../router/app_router.dart';
import '../../auth/store/auth_store.dart';
import '../home_page.dart'; // Make sure this is the correct import for the shimmer effect

/// A custom widget for displaying a notification alert.
class NotificationAlertWidget extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? subtitle;
  final String? time;
  final Color? backgroundColor;
  final int type;
  final String? comment;
  final String? commentImage;

  // Constructor for NotificationAlertWidget
  NotificationAlertWidget({
     this.imagePath,
     this.title,
     this.subtitle,
     this.time,
    this.backgroundColor = AppColor.mercury, // Default background color
    required this.type,
    this.comment,
    this.commentImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: backgroundColor?.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImage(
            assets: imagePath,
            height: 36.h,
            width: 36.w,
            boxFit: BoxFit.fill,
            radius: 5.r,
            placeHolder: buildShimmerEffect(
              radius: 5.r,
              width: 54.w,
              height: 54.h,
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    appRouter.push(StoreDetailsRoute());
                  },
                  child: RichText(
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: title,
                      style: textMedium.copyWith(
                        fontSize: 15.spMin,
                        color: AppColor.black,
                      ),
                      children: [
                        TextSpan(
                          text: subtitle,
                          style: textRegular.copyWith(
                            fontSize: 15.spMin,
                            color: AppColor.grey,
                          ),
                        ),
                        type==1?
                        TextSpan(
                          text: " You.",
                          style: textMedium.copyWith(
                            fontSize: 15.spMin,
                            color: AppColor.black,
                          ),
                        ):TextSpan(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                type==3?

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(comment!,
                        overflow: TextOverflow.clip,
                        maxLines: 3,
                        style: textRegular.copyWith(color: AppColor.black,fontSize: 14.spMin),),
                    ),
                    3.horizontalSpace,
                    AppImage(
                      assets: commentImage,
                      height: 56.h,
                      width: 56.w,
                      boxFit: BoxFit.fill,
                      radius: 3.r,
                      placeHolder: buildShimmerEffect(
                        radius: 5.r,
                        width: 54.w,
                        height: 54.h,
                      ),
                    ),
                  ],
                ):SizedBox.shrink(),
                Observer(
                  builder: (context) {
                    return Text(
                      time??authStore.getCurrentTime(),
                      style: textRegular.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.grey,
                      ),
                    );
                  },
                ),
              ],
            ).wrapPaddingSymmetric(horizontal: 10.w),
          ),
        ],
      ),
    );
  }
}
