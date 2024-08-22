import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendify/ui/home/widget/product_list_widget.dart';
import 'package:trendify/values/export.dart';
import 'package:trendify/values/extensions/widget_ext.dart';
import 'package:trendify/widget/app_image.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../../values/colors.dart';
import '../auth/store/auth_store.dart';
import 'home_page.dart';


@RoutePage()
class StoreDetailsPage extends StatefulWidget {
  const StoreDetailsPage({super.key});

  @override
  State<StoreDetailsPage> createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildStoreDetails(),
          getTabBar(),
          Expanded(
            child: TabBarView(
            controller: tabController,children: [
              _buildAboutStore(),
              ProductListWidget(),
            ]),
          ),

        ],
      ),
    );
  }
  Widget getTabBar() {
    return TabBar(
      padding: EdgeInsets.only(right: 150),
      indicatorWeight: 3.w,
      indicatorColor: AppColor.black,
      unselectedLabelColor: AppColor.grey,
      labelColor: AppColor.black,
      labelStyle: textRegular.copyWith(),
      controller: tabController,
      tabs: const [
        Tab(text: "About Store"),
        Tab(text: "Products"),
      ],
    );
  }
}



///app bar custom
AppBar _buildAppBar() {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 20,
        color: AppColor.black,
      ),
      onPressed: () => appRouter.pop(),
    ),
    title: Text(S.current.storeDetails),
    titleTextStyle: textMedium.copyWith(color: AppColor.black,fontSize: 20.spMin),
    centerTitle: true,
    elevation: 0,
    backgroundColor: AppColor.white,
    actions: [
      InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: Image.asset(
            Assets.imageCart,
            height: 24.h,
            width: 24.w,
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: Image.asset(
            Assets.imageFavourite,
            height: 24.h,
            width: 24.w,
          ),
        ),
      ),
    ],
  );
}

///HEADER STORE DETAILS
 Widget _buildStoreDetails(){
  return Container(
    margin: EdgeInsets.zero,
    height: 340.h,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        AppImage(
          assets: Assets.imageFavoritiesStoreImageone,
          height: 202.h,
          width: 1.sw,
          boxFit: BoxFit.contain,
          radius: 5.r,
          placeHolder: buildShimmerEffect(
            radius: 5.r,
            height: 202.h,
            width: 1.sw,
          ),
        ),
        Positioned(
          top: 132.h,
          right: 15,
          left: 15,

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: AppColor.white,
              boxShadow: [
                BoxShadow(color: AppColor.grey,
                blurRadius: 13)
              ]
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
            width: 1.sw,

            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // appRouter.push(StoreDetailsRoute());
                          },
                          child: Text(
                            "The New Store",
                            style: textSemiBold,
                          ),
                        ),
                        5.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage(Assets.imageStar),
                              height: 12.h,
                              width: 12.w,
                              fit: BoxFit.contain,
                            ),
                            5.horizontalSpace,
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '4.5  ',
                                    style: textMedium.copyWith(
                                      color: AppColor.black,
                                      fontSize: 12.spMin,
                                    ),),
                                  TextSpan(
                                      text: '(',
                                    style: textRegular.copyWith(
                                      color: AppColor.grey,
                                      fontSize: 12.spMin,
                                    ),),
                                  TextSpan(
                                      text: '23 ',
                                 style: textMedium.copyWith(
                                    color: AppColor.black,
                                    fontSize: 12.spMin,
                                  ),),
                                  TextSpan(
                                      text: 'Reviews)',
                                    style: textRegular.copyWith(
                                      color: AppColor.grey,
                                      fontSize: 12.spMin,
                                    ),),

                                ],
                              ),
                            ),
                          ],
                        ),
                        10.verticalSpace,
                      ],
                    ),
                    Spacer(),      // Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 8.r),
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        "Follow",
                        style: textMedium.copyWith(
                          fontSize: 16.spMin,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.imageLocation),
                    Text('3038 Godfrey Street Tigard, OR 97223',
                        style: textRegular.copyWith(
                            color: AppColor.grey, fontSize: 14.spMin))
                        .wrapPaddingOnly(left: 12.w),
                  ],
                ).wrapPaddingSymmetric(vertical: 6.h),
                Row(
                  children: [
                    SvgPicture.asset(Assets.imageCalendar),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Member Since ',
                              style: textRegular.copyWith(
                                  color: AppColor.grey, fontSize: 14.spMin)),
                          TextSpan(
                              text: 'may 2015',
                              style: textRegular.copyWith(
                                  color: AppColor.black, fontSize: 14.spMin)),

                        ],
                      ),
                    ).wrapPaddingOnly(left: 12.w),
                  ],
                ).wrapPaddingSymmetric(vertical: 6.h),
                Row(
                  children: [
                    SvgPicture.asset(Assets.imageTimeCircle),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Last Active ',
                              style: textRegular.copyWith(
                                  color: AppColor.grey, fontSize: 14.spMin)),
                          TextSpan(
                              text: '5 hours ago',
                              style: textRegular.copyWith(
                                  color: AppColor.black, fontSize: 14.spMin)),

                        ],
                      ),
                    ).wrapPaddingOnly(left: 12.w),
                  ],
                ).wrapPaddingSymmetric(vertical: 6.h),

                Divider(
                  color: AppColor.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                   Text("458",style: textMedium.copyWith(color: AppColor.black,fontSize: 14.spMin),),
                        5.verticalSpace,
                        Text("Followers",style: textMedium.copyWith(color: AppColor.grey,fontSize: 14.spMin),)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("800",style: textMedium.copyWith(color: AppColor.black,fontSize: 14.spMin),),
                        5.verticalSpace,
                        Text("Followings",style: textMedium.copyWith(color: AppColor.grey,fontSize: 14.spMin),)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("500",style: textMedium.copyWith(color: AppColor.black,fontSize: 14.spMin),),
                        5.verticalSpace,
                        Text("Share",style: textMedium.copyWith(color: AppColor.grey,fontSize: 14.spMin),)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("100",style: textMedium.copyWith(color: AppColor.black,fontSize: 14.spMin),),
                        5.verticalSpace,
                        Text("Sold",style: textMedium.copyWith(color: AppColor.grey,fontSize: 14.spMin),)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("50",style: textMedium.copyWith(color: AppColor.black,fontSize: 14.spMin),),
                        5.verticalSpace,
                        Text("List",style: textMedium.copyWith(color: AppColor.grey,fontSize: 14.spMin),)
                      ],
                    ),
                  ],
                ).wrapPaddingSymmetric(vertical: 8.h),

              ],
            ),
          ),
        ),

      ],
    ),
  );
 }

 ///about store
Widget _buildAboutStore() {
  return Column(
    children: [
      10.verticalSpace,
      Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English",overflow: TextOverflow.clip,
      style: textRegular.copyWith(color: AppColor.grey,textBaseline: TextBaseline.ideographic),).wrapPaddingSymmetric(horizontal: 15.w),
      Spacer(),
      Container(
        margin: EdgeInsets.only(bottom: 35.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
        color: Colors.grey.shade300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Seller",style: textRegular.copyWith(color: AppColor.grey),),
                5.verticalSpace,
                Text("John Doe",style: textSemiBold.copyWith(color: AppColor.black),),

              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 15.r),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                "Send a message",
                style: textMedium.copyWith(
                  fontSize: 12.spMin,
                  color: AppColor.white,
                ),
              ),
            ),

          ],
        ),
      )
    ],
  );
}