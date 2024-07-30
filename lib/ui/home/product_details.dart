import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/router/app_router.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/ui/home/home_page.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/style.dart';
import 'package:trendify/widget/app_image.dart';

@RoutePage()
class ProductDetailsPage extends StatefulWidget {
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  List<String> bestSellerImageUrls = [
    Assets.imageBestsellerimageone,
    Assets.imageBestsellerimagetwo,
    Assets.imageBestsellerimageone,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
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
                    width: 15.w); // Adjust the width of the separator as needed
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
    );
  }
}

///app bar custom
AppBar _buildAppBar() {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new_outlined,
        color: AppColor.black,
      ),
      onPressed: () => appRouter.pop(),
    ),
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
