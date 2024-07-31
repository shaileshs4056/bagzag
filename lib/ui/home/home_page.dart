import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/values/extensions/widget_ext.dart';
import 'package:trendify/widget/app_image.dart';

import '../../core/db/app_db.dart';
import '../../data/model/response/categories.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../../util/media_picker.dart';
import '../../util/permission_utils.dart';
import '../../values/colors.dart';
import '../../values/style.dart';
import '../../widget/media_picker_bottomsheet.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> recentlyViewImageUrls = [
  Assets.imageRecentlyviewimagone,
  Assets.imageRecentlyviewimagtwo,
  Assets.imageRecentlyviewimagthree,
  Assets.imageRecentlyviewimagfour,
];

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late ValueNotifier showLoading;
  int bottomNavigationIndex = 0;

  List<dynamic> image = [
    CategoryItem(imagePath: Assets.imageMen, name: 'Men'),
    CategoryItem(imagePath: Assets.imageWomen, name: 'Women'),
    CategoryItem(imagePath: Assets.imageKids, name: 'Kids'),
    CategoryItem(imagePath: Assets.imageBeauty, name: 'Beauty')
  ];
  List<String> bestSellerImageUrls = [
    Assets.imageBestsellerimageone,
    Assets.imageBestsellerimagetwo,
    Assets.imageBestsellerimageone,
  ];

  @override
  void initState() {
    super.initState();
    showLoading = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    showLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage(
            Assets.imageLogo,
          ),
          height: 24.h,
          width: 24.w,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.white,
        actions: [
          InkWell(
            onTap: () {},
            child: Image(
              image: AssetImage(
                Assets.imageSearch,
              ),
              height: 24.h,
              width: 24.w,
            ),
          ),
          10.horizontalSpace,
          InkWell(
            onTap: () {
              appRouter.push(FavoritesRoute());
            },
            child: Image(
              image: AssetImage(
                Assets.imageFavourite,
              ),
              height: 24.h,
              width: 24.w,
            ),
          ),
          10.horizontalSpace,
          InkWell(
            onTap: () {},
            child: Image(
              image: AssetImage(Assets.imageNotification),
              height: 24.h,
              width: 24.w,
            ),
          ),
          10.horizontalSpace,
          InkWell(
            onTap: () {},
            child: Image(
              image: AssetImage(
                Assets.imageCart,
              ),
              height: 24.h,
              width: 24.w,
            ),
          ),
          10.horizontalSpace,
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.verticalSpace,
              RichText(
                text: TextSpan(
                  text: S.current.hi,
                  style: textLight.copyWith(
                    color: AppColor.grey,
                    fontSize: 18.spMin,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: " David",
                      style: textSemiBold.copyWith(
                          fontSize: 18.spMin, color: AppColor.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(S.current.tNc)),
                          );
                        },
                    ),
                  ],
                ),
              ),
              Text(
                "New Collection from BagZag.",
                style: textRegular.copyWith(
                    fontSize: 16.spMin, color: AppColor.grey),
              ),
              15.verticalSpace,
              Row(
                children: [
                  Text(
                    "Categories",
                    style: textMedium.copyWith(
                        fontSize: 16.spMin, color: AppColor.black),
                  ),
                  Spacer(),
                  Text(
                    "View More",
                    style: textRegular.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 8.h,
                    color: AppColor.grey,
                  )
                ],
              ),
              20.verticalSpace,
              SizedBox(
                height: 117.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15.r),
                  scrollDirection: Axis.horizontal,
                  itemCount: image.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                        width: 10
                            .w); // Adjust the width of the separator as needed
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return categoriesCustomStack(
                        imagePath: image[index].imagePath,
                        title: image[index].name);
                  },
                ),
              ),
              15.verticalSpace,
              Row(
                children: [
                  Text(
                    "Bestseller Product ",
                    style: textMedium.copyWith(
                        fontSize: 16.spMin, color: AppColor.black),
                  ),
                  Spacer(),
                  Text(
                    "View More",
                    style: textRegular.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 8.h,
                    color: AppColor.grey,
                  )
                ],
              ),
              10.verticalSpace,
              SizedBox(
                height: 262.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15.r),
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSellerImageUrls.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                        width: 15
                            .w); // Adjust the width of the separator as needed
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return bestsellerCustomStack(
                        imagePath:
                            'https://s3-alpha-sig.figma.com/img/b572/2438/27d69e0740d46a92db1ff2dc75094fd4?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iQEJspcCthVNh9rQMfQV0S1hJhNBfcnKNHjfp0HmhIEhvVojwCTIuNaHmngzjKFl3nYCrBUj-rlQbpc9QplvIpdq42It0eUIOb6yawIWnkRTJBuN80yUru9D-YZ4kME~YznF8pY4vuGHo2x-SKHl4wKBIMnqFg5jSffVUE81OlSlIyuSueC~Wr5OsLSzEqS16PRKilu~wLLhSe4GgVLrvwG46i~x~YVXKAgyU5eGb3avI2WtR72cTLaE4IbKPEoOEuqyix6LOyTqworZR9YhojF~-iVKSLJINDQDXTMB2tU0Vw2mi7t-gDDn5TAzz1WFmV0DI4BZajB8wxQA0xWeVA__',
                        title: '');
                  },
                ),
              ),
              20.verticalSpace,
              recentlyViewedCustomStack(
                  imagePath:
                      'https://s3-alpha-sig.figma.com/img/dae5/43ff/c2e02cd946307a89c97f14cab6e9a962?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=JmA7tNupEaKD9LWl32Ej6NSBraheMwRpiktHuyU3BFgFS9G2EGR~7lrj4Mjxw-NN4QMioTplvP52ayd2Vdf8mwNtfwE2KdG2P5AH7vFcIt8rnOgqXOiDL4bItdRmqBx8XlihtFhGHq2WlABqybzXlPca6JoHIlWZp8llufFGUQUTFS5yFUBWt2WEKQ43IYNC4P8osM9GpV6FNch0DJeuiMuD~abOiFF2i886GE0L6s0VWcVHmHVVjuxEn8DoLZ13wRgDREwzKVCrJykCBZfBLp4J6TEKHNtUnPE411idXKbUn5VFz1Rv6PxnvmFGZwVr5Bx6La9E10O1M0Rr5FJMtw__',
                  title: ''),
              Row(
                children: [
                  Text(
                    "Buyer’s Most Loved",
                    style: textMedium.copyWith(
                        fontSize: 16.spMin, color: AppColor.black),
                  ),
                  Spacer(),
                  Text(
                    "View More",
                    style: textRegular.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 8.h,
                    color: AppColor.grey,
                  )
                ],
              ).wrapPaddingOnly(
                  top: 16.h, bottom: 11.h, left: 15.r, right: 15.r),
              SizedBox(
                height: 112.h,
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 15.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return buyersMostLoved(
                          imageUrl:
                              'https://s3-alpha-sig.figma.com/img/b572/2438/27d69e0740d46a92db1ff2dc75094fd4?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iQEJspcCthVNh9rQMfQV0S1hJhNBfcnKNHjfp0HmhIEhvVojwCTIuNaHmngzjKFl3nYCrBUj-rlQbpc9QplvIpdq42It0eUIOb6yawIWnkRTJBuN80yUru9D-YZ4kME~YznF8pY4vuGHo2x-SKHl4wKBIMnqFg5jSffVUE81OlSlIyuSueC~Wr5OsLSzEqS16PRKilu~wLLhSe4GgVLrvwG46i~x~YVXKAgyU5eGb3avI2WtR72cTLaE4IbKPEoOEuqyix6LOyTqworZR9YhojF~-iVKSLJINDQDXTMB2tU0Vw2mi7t-gDDn5TAzz1WFmV0DI4BZajB8wxQA0xWeVA__');
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 12.w,
                      );
                    }),
              ),
              Row(
                children: [
                  Text(
                    "Find Things You’ll Love",
                    style: textMedium.copyWith(
                        fontSize: 16.spMin, color: AppColor.black),
                  ),
                  Spacer(),
                  Text(
                    "View More",
                    style: textRegular.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 8.h,
                    color: AppColor.grey,
                  )
                ],
              ).wrapPaddingOnly(
                  top: 16.h, bottom: 11.h, left: 15.r, right: 15.r),
              SizedBox(
                height: 262.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15.r),
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSellerImageUrls.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                        width: 15
                            .w); // Adjust the width of the separator as needed
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return bestsellerCustomStack(
                        imagePath:
                            'https://s3-alpha-sig.figma.com/img/b572/2438/27d69e0740d46a92db1ff2dc75094fd4?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iQEJspcCthVNh9rQMfQV0S1hJhNBfcnKNHjfp0HmhIEhvVojwCTIuNaHmngzjKFl3nYCrBUj-rlQbpc9QplvIpdq42It0eUIOb6yawIWnkRTJBuN80yUru9D-YZ4kME~YznF8pY4vuGHo2x-SKHl4wKBIMnqFg5jSffVUE81OlSlIyuSueC~Wr5OsLSzEqS16PRKilu~wLLhSe4GgVLrvwG46i~x~YVXKAgyU5eGb3avI2WtR72cTLaE4IbKPEoOEuqyix6LOyTqworZR9YhojF~-iVKSLJINDQDXTMB2tU0Vw2mi7t-gDDn5TAzz1WFmV0DI4BZajB8wxQA0xWeVA__',
                        title: '');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          bottomNavigationIndex = value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.neonPink,
        currentIndex: bottomNavigationIndex,
        unselectedItemColor: AppColor.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 20.h,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Image(
                  image: AssetImage(
                Assets.imageHome,
              )),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(Assets.imageStudio),
              ),
              label: "Studio"),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(Assets.imageSell),
              ),
              label: "Sell"),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(Assets.imageFeed),
              ),
              label: "Feed"),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(Assets.imageMe),
              ),
              label: "Me"),
        ],
      ),
    );
  }
}

Widget categoriesCustomStack(
    {required String imagePath, required String title}) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Positioned(
        child: Container(
            width: 82.w,
            height: 98.h,
            padding: EdgeInsets.only(bottom: 7.r),
            decoration: BoxDecoration(
              color: AppColor.mercury,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: textRegular.copyWith(
                    color: AppColor.black, fontSize: 12.spMin),
              ),
            )),
      ),
      Positioned(
        top: 15,
        child: Container(
          height: 60.h,
          width: 75.w,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
      ),
      Positioned(
        top: -5,
        left: -10,
        right: 0,
        child: Container(
          alignment: Alignment.center,
          height: 82.h,
          width: 87.w,
          decoration: BoxDecoration(
              color: AppColor.transparent,
              borderRadius: BorderRadius.circular(5.r),
              image: DecorationImage(
                image: AssetImage(imagePath),
              )),
        ),
      ),
    ],
  );
}

Widget bestsellerCustomStack(
    {required String imagePath, required String title}) {
  return Observer(builder: (context) {
    return SizedBox(
      width: 140.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AppImage(
                  url: imagePath,
                  height: 180.h,
                  width: 140.w,
                  radius: 5.r,
                  boxFit: BoxFit.cover,
                  placeHolder: buildShimmerEffect(
                      radius: 5.r, width: 134.w, height: 180.h)),
              Positioned(
                top: 10,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.r, vertical: 3.r),
                  decoration: BoxDecoration(
                      color: AppColor.neonPink,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(2.r),
                          bottomRight: Radius.circular(2.r))),
                  child: Text(
                    "30% Off",
                    style: textMedium.copyWith(
                        fontSize: 8.spMin, color: AppColor.white),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 5,
                child: InkWell(
                  onTap: () {
                    authStore.setIsFavorite();
                  },
                  child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                          color: AppColor.white, shape: BoxShape.circle),
                      child: authStore.isFavorite
                          ? Image(image: AssetImage(Assets.imageBlackHeart))
                          : Image(
                              image: AssetImage(Assets.imagePinkHeart),
                              height: 12.h,
                              width: 12.w,
                              fit: BoxFit.contain,
                            )),
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Text("Loose Textured T-Shirt"),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(Assets.imageStar),
                height: 12.h,
                width: 12.w,
                fit: BoxFit.contain,
              ),
              5.horizontalSpace,
              Text(
                "4.5",
                style: textMedium.copyWith(
                    color: AppColor.black, fontSize: 12.spMin),
              ),
              Text(
                " | 256",
                style: textRegular.copyWith(
                  color: AppColor.grey,
                  fontSize: 12.spMin,
                ),
              ),
            ],
          ),
          5.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
            decoration: BoxDecoration(
                color: AppColor.mercury.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2.r)),
            child: Text(
              "Free Shipping",
              style:
                  textMedium.copyWith(fontSize: 10.spMin, color: AppColor.grey),
            ),
          ),
          5.verticalSpace,
          Row(
            children: [
              Text(
                "\$119.99",
                style: textMedium.copyWith(
                  color: AppColor.black,
                  fontSize: 12.spMin,
                ),
              ),
              5.horizontalSpace,
              Text(
                "\$159.99",
                style: textRegular.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColor.grey,
                    fontSize: 12.spMin),
              ),
              Spacer(),
              SvgPicture.asset(
                Assets.imageAddTocart,
              ),
            ],
          )
        ],
      ),
    );
  });
}

Widget recentlyViewedCustomStack(
    {required String imagePath, required String title}) {
  return Observer(builder: (context) {
    return Container(
      height: 545.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: 450.h,
            width: 1.sw,
            color: AppColor.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recently viewed By You",
                  style: textMedium.copyWith(
                      fontSize: 16.spMin, color: AppColor.white),
                ).wrapPaddingTop(9.h),
                TextButton.icon(
                  onPressed: () {},
                  label: Text(
                    "View More",
                    style: textRegular.copyWith(
                      color: AppColor.white,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 8.h,
                    color: AppColor.white,
                  ),
                ),
              ],
            ).wrapPaddingSymmetric(horizontal: 15.w, vertical: 15.h),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 486.h,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  boxShadow: [
                    BoxShadow(color: AppColor.mercury, blurRadius: 2)
                  ]),
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 242.h,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 0.5,
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                clipBehavior: Clip.none,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    clipBehavior: Clip.none,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topLeft,
                          children: [
                            AppImage(
                                url: imagePath,
                                height: 139.h,
                                width: 169.w,
                                radius: 5.r,
                                placeHolder: buildShimmerEffect(
                                    radius: 5.r, width: 134.w, height: 169.h)),
                            Positioned(
                              top: 10,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.r, vertical: 3.r),
                                decoration: BoxDecoration(
                                    color: AppColor.neonPink,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(2.r),
                                        bottomRight: Radius.circular(2.r))),
                                child: Text(
                                  "30% Off",
                                  style: textMedium.copyWith(
                                      fontSize: 8.spMin, color: AppColor.white),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  authStore.setIsFavorite();
                                },
                                child: Container(
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                            color: AppColor.mercury,
                                            shape: BoxShape.circle),
                                        child: authStore.isFavorite
                                            ? Image(
                                                image: AssetImage(
                                                    Assets.imageBlackHeart))
                                            : Image(
                                                image: AssetImage(
                                                    Assets.imagePinkHeart),
                                                height: 12.h,
                                                width: 12.w,
                                                fit: BoxFit.contain,
                                              ))
                                    .wrapPaddingRight(11.w),
                              ),
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Loose Textured T-Shirt"),
                              5.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: AssetImage(Assets.imageStar),
                                    height: 12.h,
                                    width: 12.w,
                                    fit: BoxFit.contain,
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    "4.5",
                                    style: textMedium.copyWith(
                                        color: AppColor.black,
                                        fontSize: 12.spMin),
                                  ),
                                  Text(
                                    " | 256",
                                    style: textRegular.copyWith(
                                      color: AppColor.grey,
                                      fontSize: 12.spMin,
                                    ),
                                  ),
                                ],
                              ),
                              8.verticalSpace,
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.r, vertical: 6.r),
                                decoration: BoxDecoration(
                                    color: AppColor.mercury.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(2.r)),
                                child: Text(
                                  "Free Shipping",
                                  style: textMedium.copyWith(
                                      fontSize: 10.spMin, color: AppColor.grey),
                                ),
                              ),
                              7.verticalSpace,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$119.99",
                                    style: textMedium.copyWith(
                                      color: AppColor.black,
                                      fontSize: 12.spMin,
                                    ),
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    "\$159.99",
                                    style: textRegular.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColor.grey,
                                        fontSize: 12.spMin),
                                  ),
                                  Spacer(),
                                  SvgPicture.asset(
                                    Assets.imageAddTocart,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ).wrapPaddingBottom(0);
  });
}

///buyer's most love

Widget buyersMostLoved({required String imageUrl}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.mercury,
      borderRadius: BorderRadius.circular(5.r),
    ),
    width: 276.w,
    child: Row(
      children: [
        AppImage(
          url: imageUrl,
          height: 109.h,
          width: 101.w,
          boxFit: BoxFit.cover,
          placeHolder: buildShimmerEffect(
            radius: 5.r,
            width: 134.w,
            height: 169.h,
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 7.w, right: 13.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Loose Textured T-Shirt"),
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
                    Text(
                      "4.5",
                      style: textMedium.copyWith(
                        color: AppColor.black,
                        fontSize: 12.spMin,
                      ),
                    ),
                    Text(
                      " | 256",
                      style: textRegular.copyWith(
                        color: AppColor.grey,
                        fontSize: 12.spMin,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 7.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
                  decoration: BoxDecoration(
                    color: AppColor.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: Text(
                    "Free Shipping",
                    style: textMedium.copyWith(
                      fontSize: 10.spMin,
                      color: AppColor.grey,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "\$119.99",
                            style: textMedium.copyWith(
                              color: AppColor.black,
                              fontSize: 12.spMin,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(width: 5),
                          ),
                          TextSpan(
                            text: "\$159.99",
                            style: textRegular.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppColor.grey,
                              fontSize: 12.spMin,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      Assets.imageAddTocart,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildShimmerEffect({
  required double height,
  required double width,
  required double radius,
}) {
  return Shimmer(
    color: Colors.grey[300]!,
    colorOpacity: 0.1,
    enabled: true,
    direction: ShimmerDirection.fromLeftToRight(),
    duration: Duration(seconds: 5),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}
