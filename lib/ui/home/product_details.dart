import 'package:auto_route/auto_route.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/router/app_router.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/ui/home/home_page.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/extensions/widget_ext.dart';
import 'package:trendify/values/style.dart';
import 'package:trendify/widget/app_image.dart';

@RoutePage()
class ProductDetailsPage extends StatefulWidget {
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

List<String> bestSellerImageUrls = [
  Assets.imageBestsellerimageone,
  Assets.imageBestsellerimagetwo,
  Assets.imageBestsellerimageone,
];

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _buildImageview(),
          _buildDeliveryMenus(),
          theNewStore(
              imageUrl:
                  'https://s3-alpha-sig.figma.com/img/05b6/9523/9b03725ad6994b2cacd5dc2ae81f458c?Expires=1723420800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cCmCNR15zggn6FbYdyjQpyTyZfQ8rFMCMy4XPvpn-0fB3ZMTfaDfGLpL4UW2F~OAfCbICyCrAk1yoyFA09E7dTaTLS5u-7L199FB~OqsFHfNj6hUkKjc4vrNaKnmELcroETynniPuZbvOjh7~U8nnkFqlSa2GgiExabZ6gBPukWAe-~i2wJD4IgdDpulU7EVMl62oyL~L5mjZQPKnm-pc7g~2PBuhVhEZBbuhQGQ4bx5ituD9UYVv7FcXFDRXJW-AQ4wnA1TDsfImEhjEJYPSjcdkQJNrGHCZeSSjfkD-FatrilsxTNgKUg1J4WsMg375jzVbADfeueijOBUI364Yg__'),
          _buildHeader(
            title: "You May Also Like",
            actionText: "",
            onPressed: () {},
          ),
          10.verticalSpace,
          _buildBestsellerListView(),
          _buildHeader(
            title: "More From The New Store",
            actionText: "View More",
            onPressed: () {},
          ),
          10.verticalSpace,
          _buildBestsellerListView(),
        ],
      )),
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

Widget _buildHeader(
    {required String title,
    required String actionText,
    required VoidCallback onPressed}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.spMin,
            color: Colors.black,
          ),
        ),
        TextButton.icon(
          label: Text(actionText,
              style: textRegular.copyWith(
                fontSize: 14.sp,
                color: AppColor.grey,
              )),
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 10.spMax,
            color: AppColor.grey,
          ),
          iconAlignment: IconAlignment.end,
        ),
      ],
    ),
  );
}

Widget _buildBestsellerListView() {
  return SizedBox(
    height: 257.h,
    child: ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      scrollDirection: Axis.horizontal,
      itemCount: bestSellerImageUrls.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 15.w);
      },
      itemBuilder: (BuildContext context, int index) {
        return bestsellerCustomStack(
            imagePath: bestSellerImageUrls[index], title: '');
      },
    ),
  );
}

Widget bestsellerCustomStack(
    {required String imagePath, required String title}) {
  return Observer(builder: (context) {
    return Container(
      width: 140.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AppImage(
                  assets: imagePath,
                  height: 158.h,
                  width: 130.w,
                  radius: 5.r,
                  boxFit: BoxFit.cover,
                  placeHolder: buildShimmerEffect(
                      radius: 5.r, width: 130.w, height: 175.h)),
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

///buyer's most love

Widget theNewStore({required String imageUrl}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
    decoration: BoxDecoration(
      color: AppColor.mercury.withOpacity(0.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppImage(
          url: imageUrl,
          height: 54.h,
          width: 54.w,
          boxFit: BoxFit.fill,
          radius: 5.r,
          placeHolder: buildShimmerEffect(
            radius: 5.r,
            width: 54.w,
            height: 54.h,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The New Store",
              style: textSemiBold,
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
                Text(
                  "4.5",
                  style: textMedium.copyWith(
                    color: AppColor.black,
                    fontSize: 12.spMin,
                  ),
                ),
                Text(
                  "(25 Reviews)",
                  style: textRegular.copyWith(
                    color: AppColor.grey,
                    fontSize: 12.spMin,
                  ),
                ),
              ],
            ),
            5.verticalSpace,
            Text(
              "John Doe",
              style: textRegular.copyWith(
                fontSize: 14.sp,
              ),
            ),
          ],
        ).wrapPaddingSymmetric(horizontal: 10.w),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 15.r),
          decoration: BoxDecoration(
            color: AppColor.black,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Text(
            "SEND a message",
            style: textMedium.copyWith(
              fontSize: 10.spMin,
              color: AppColor.white,
            ),
          ),
        ),
      ],
    ),
  );
}

/// delivery instraction

Widget _buildDeliveryMenus() {
  return Column(
    children: [
      Row(
        children: [
          Image(image: AssetImage('assets/image/delivery.png')),
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Free Delivery  ',
                      style: textRegular.copyWith(
                          color: AppColor.black, fontSize: 12.spMin)),
                  TextSpan(
                      text: '| Estimated Delivery',
                      style: textRegular.copyWith(
                          color: AppColor.grey, fontSize: 12.spMin)),
                  TextSpan(
                      text: ' 2-3 Days',
                      style: textRegular.copyWith(
                          color: AppColor.black, fontSize: 12.spMin)),
                ],
              ),
            ),
          ).wrapPaddingOnly(left: 12.w),
        ],
      ).wrapPaddingSymmetric(horizontal: 15.w, vertical: 6.h),
      Row(
        children: [
          Image(image: AssetImage('assets/image/noreturn.png')),
          Text('No return Policy',
                  style: textRegular.copyWith(
                      color: AppColor.black, fontSize: 12.spMin))
              .wrapPaddingOnly(left: 12.w),
        ],
      ).wrapPaddingSymmetric(horizontal: 15.w, vertical: 6.h),
      20.verticalSpace,
      _buildProductMenus(MenuTitle: "Buyer	protection &	Refund	policy"),
      _buildProductMenus(MenuTitle: "Shipping & Policies"),
      _buildProductMenus(MenuTitle: " report a product"),
    ],
  );
}

///menus for products

Widget _buildProductMenus({required String MenuTitle}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: AppColor.mercury, width: 1.w)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            MenuTitle,
            style: textRegular,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        InkWell(
            child: Icon(
          Icons.navigate_next_outlined,
          color: AppColor.mercury,
        ))
      ],
    ),
  ).wrapPaddingSymmetric(horizontal: 15.w, vertical: 5.h);
}

List<String> favoritesPageImages = [
  Assets.imageFavproductone,
  Assets.imageFavproducttwo,
  Assets.imageFavproductthree,
  Assets.imageFavproductfour,
  Assets.imageFavproductone,
  Assets.imageFavproducttwo,
  Assets.imageFavproductthree,
  Assets.imageFavproductfour,
];
Widget _buildImageview() {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 255,
            child: PageView.builder(
              scrollBehavior: ScrollBehavior(),
              controller: controller,
              itemCount: favoritesPageImages.length,
              itemBuilder: (context, index) {
                return Container(
                  child: AppImage(
                      assets: favoritesPageImages[index],
                      height: 240.h,
                      width: double.maxFinite,
                      radius: 5.r,
                      boxFit: BoxFit.cover,
                      placeHolder: buildShimmerEffect(
                          radius: 5.r, width: 130.w, height: 175.h)),
                ).wrapPaddingSymmetric(horizontal: 15);
              },
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: favoritesPageImages.length,
            effect: const WormEffect(
              dotHeight: 7,
              dotWidth: 7,
              dotColor: AppColor.grey,
              activeDotColor: AppColor.black,
              type: WormType.thinUnderground,
            ),
          ).wrapCenter(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 9.h, top: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
                decoration: BoxDecoration(
                  color: AppColor.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Text(
                  "in Stock",
                  style: textMedium.copyWith(
                      fontSize: 10.spMin, color: AppColor.green),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Loose Textured T-Shirt",
                    style: textRegular.copyWith(),
                  ),
                  Spacer(),
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
                    " | 256 Reviews",
                    style: textRegular.copyWith(
                      color: AppColor.grey,
                      fontSize: 12.spMin,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 3.h, bottom: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
                decoration: BoxDecoration(
                    color: AppColor.mercury.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2.r)),
                child: Text(
                  "Free Shipping",
                  style: textMedium.copyWith(
                      fontSize: 10.spMin, color: AppColor.grey),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Men ',
                        style: textRegular.copyWith(
                            color: AppColor.black, fontSize: 12.spMin)),
                    TextSpan(
                        text: '/ Top Were',
                        style: textRegular.copyWith(
                            color: AppColor.grey, fontSize: 12.spMin)),
                  ],
                ),
              ).wrapPaddingOnly(bottom: 6.h),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '\$119.99',
                            style: textMedium.copyWith(
                                color: AppColor.black, fontSize: 16.spMin)),
                        WidgetSpan(
                          child: SizedBox(width: 10.w),
                        ),
                        TextSpan(
                            text: '\$159.99',
                            style: textRegular.copyWith(
                                color: AppColor.grey, fontSize: 16.spMin)),
                        WidgetSpan(
                          child: SizedBox(width: 8.w),
                        ),
                        TextSpan(
                            text: '(20% Off)',
                            style: textRegular.copyWith(
                                color: AppColor.neonPink, fontSize: 12.spMin)),
                      ],
                    ),
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Condition :',
                            style: textRegular.copyWith(
                                color: AppColor.grey, fontSize: 14.spMin)),
                        TextSpan(
                            text: 'Like New',
                            style: textMedium.copyWith(
                                color: AppColor.black, fontSize: 14.spMin)),
                      ],
                    ),
                  )
                ],
              ),
              15.verticalSpace,
            ],
          ).wrapPaddingSymmetric(horizontal: 15.w)
        ],
      ),
      Divider(),
      Row(
        children: [
          Image(
            image: AssetImage('assets/image/like.png'),
            color: AppColor.black,
          ),
          10.horizontalSpace,
          Text(
            "26",
            style: textRegular.copyWith(fontSize: 14.spMin),
          ),
          25.horizontalSpace,
          Image(
            image: AssetImage('assets/image/Chat.png'),
            color: AppColor.black,
          ),
          10.horizontalSpace,
          Text(
            "30",
            style: textRegular.copyWith(fontSize: 14.spMin),
          ),
          30.horizontalSpace,
          Image(
            image: AssetImage('assets/image/Send.png'),
            color: AppColor.black,
          ),
          Spacer(),
          Image(
            image: AssetImage('assets/image/Send.png'),
            color: AppColor.black,
          ),
        ],
      ).wrapPaddingSymmetric(horizontal: 15.w, vertical: 8.h),
      Divider(),
    ],
  );
}
