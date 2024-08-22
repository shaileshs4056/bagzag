import 'package:auto_route/annotations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/export.dart';
import 'package:trendify/values/extensions/widget_ext.dart';
import 'package:trendify/widget/app_image.dart';

@RoutePage()
class RateReviewsPage extends StatefulWidget {
  const RateReviewsPage({super.key});

  @override
  State<RateReviewsPage> createState() => _RateReviewsPageState();
}

class _RateReviewsPageState extends State<RateReviewsPage> {
  @override
  void initState() {
    super.initState();
    // Set the status bar color when the screen is created
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black, // Set the status bar color here
        statusBarIconBrightness:
            Brightness.light, // Set the status bar icon brightness
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColor.black,
              leading: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
              ),
              expandedHeight: 125.0,
              pinned: false,
              excludeHeaderSemantics: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text(
                                "4.5",
                                style: textBold.copyWith(
                                  color: AppColor.white,
                                  fontSize: 30
                                ),
                              ),
                              5.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) => SvgPicture.asset(Assets.assetsImageStar,color: index==4?AppColor.white:AppColor.brightYellow,).wrapPaddingOnly(right: 5.w),),
                              ),
                              10.verticalSpace,
                              Text(
                                "23 reviews",
                                style: textMedium.copyWith(
                                    color: AppColor.white,
                                    fontSize: 12.spMin,
                                ),
                              ),
                            ],
                          ).wrapPaddingOnly(top: 15.h),
                        ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(5, (index) => SvgPicture.asset(Assets.assetsImageStar,color: index==4?AppColor.grey:AppColor.brightYellow,).wrapPaddingOnly(right: 5.w),),
                        ),
                        10.verticalSpace,
                        Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et",
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.start,
                          style: textRegular.copyWith(fontSize:  13.spMin),),
                        10.verticalSpace,
                        Row(
                          children: [
                      AppImage(
                        assets: Assets.imageRatingUserimage,
                        height: 20.h,
                          width: 20.w,
                        radius: 3.r,
                      ),

                            SizedBox(width: 5.w),

                            RichText(
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: "John Doe ",
                                style: textMedium.copyWith(
                                    fontSize: 14.spMin,
                                    color: AppColor.neonPink,
                                    ),
                                children: [
                                  TextSpan(
                                    text: " |  17 Jan 2021 | 03:00 Pm",
                                    style: textRegular.copyWith(
                                        fontSize: 14.spMin,
                                        color: AppColor.grey,
                                   ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).wrapPaddingOnly(top: 10.h,left: 15.w,right: 15.w),
                    Divider(
                        color: Colors.grey
                    )
                  ],
                ),
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
