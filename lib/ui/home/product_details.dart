import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/router/app_router.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/ui/home/Store_Details.dart';
import 'package:trendify/ui/home/home_page.dart';
import 'package:trendify/ui/home/widget/product_details_widget.dart';
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
  Assets.imageBestsellerimagetwo,
  Assets.imageBestsellerimageone,
  Assets.imageBestsellerimageone,
];

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
          child: Column(
        children: [
          _buildImageview(),
          _buildDeliveryMenus(),
          theNewStore(
              imageUrl:
              Assets.imageFavoritiesStoreImageone),
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
      bottomSheet: Container(
        color: AppColor.transparent,
        child: TextButton.icon(
          onPressed: () {},
          label: Text(
            "Add to bag",
            style: textMedium.copyWith(color: AppColor.white, fontSize: 18.spMin),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColor.black),
            minimumSize: WidgetStateProperty.all(Size(double.infinity, 50.h)),
          ),
          icon: SvgPicture.asset(
            Assets.imageAddTocart,
            color: AppColor.white,
            height: 25.h,
            width: 25.w,
          ),
        ).wrapPaddingSymmetric(horizontal: 15.w,vertical: 15.h),
      ),
    );
  }
}


void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Make the bottom sheet background transparent
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.black, // Set your desired background color for the content
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Optional: add rounded corners
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h), // Padding for the content
      child: TextButton.icon(
        onPressed: () {},
        label: Text(
          "Add to bag",
          style: textMedium.copyWith(color: AppColor.white, fontSize: 18.spMin),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColor.black),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.h)),
        ),
        icon: SvgPicture.asset(
          Assets.imageAddTocart,
          color: AppColor.white,
          height: 25.h,
          width: 25.w,
        ),
      ),
    ),
  );
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
      itemCount: productsList.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 15.w);
      },
      itemBuilder: (BuildContext context, int index) {
        return BestsellerStackWidget(
          imagePath: productsList[index].imagePath,
          title: productsList[index].productTitle,
          discountPercentage: productsList[index].discount,
          isFavorite: productsList[index].favorite,
          currentPrice: productsList[index].afterDiscountPrice,
          originalPrice: productsList[index].realPrice,
        );
      },
    ),
  );
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
          assets: imageUrl,
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
            GestureDetector(
              onTap: () {
                appRouter.push(StoreDetailsRoute());
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
            "Send a message",
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
          RichText(
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
    crossAxisAlignment: CrossAxisAlignment.start,
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
          10.verticalSpace,
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
              Text(
                "Denim",
                style:
                    textRegular.copyWith(color: AppColor.grey, fontSize: 14.sp),
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
                              decoration: TextDecoration.lineThrough,
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
      Divider(color: AppColor.black, indent: 3),
      Row(
        children: [
          SvgPicture.asset(
            Assets.assetsImageLike,
            color: AppColor.black,
          ),
          10.horizontalSpace,
          Text(
            "26",
            style: textRegular.copyWith(fontSize: 14.spMin),
          ),
          25.horizontalSpace,
          SvgPicture.asset(Assets.imageChat),
          10.horizontalSpace,
          Text(
            "30",
            style: textRegular.copyWith(fontSize: 14.spMin),
          ),
          30.horizontalSpace,
          SvgPicture.asset(Assets.assetsImageSend),
          Spacer(),
          SvgPicture.asset(Assets.imageAddUser)
        ],
      ).wrapPaddingSymmetric(horizontal: 15.w, vertical: 8.h),
      Divider(color: AppColor.black, indent: 3),
      _buildColorAndSize(),
    ],
  );
}

final List<Color> colors = [
  AppColor.black,
  Colors.red,
  Colors.green,
  Colors.blue,
];
final List<String> size = [
  "S",
  "M",
  "L",
  "XL",
  "XXL",
];

Widget _buildColorAndSize() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Color:",
        style: textRegular.copyWith(
            color: AppColor.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
      ),
      10.verticalSpace,
      SizedBox(
        height: 32.h,
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(5.w),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.r),
                  color: AppColor.white,
                  boxShadow: [BoxShadow(color: AppColor.grey, blurRadius: 3.r)],
                  border: Border.all(width: 1, color: AppColor.grey),
                ),
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.r),
                    color: colors[index],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10.w,
              );
            },
            itemCount: colors.length),
      ),
      10.verticalSpace,
      Row(
        children: [
          Text(
            "Size",
            style: textRegular.copyWith(
                color: AppColor.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
      10.verticalSpace,
      SizedBox(
        height: 35.h,
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.r),
                      color: AppColor.white,
                      border: Border.all(width: 1, color: AppColor.black)),
                  child: Text(
                    size[index],
                    style: textRegular.copyWith(color: AppColor.grey),
                  ));
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10.w,
              );
            },
            itemCount: size.length),
      ),

      10.verticalSpace,
      Text(
        "Description",
        style: textRegular.copyWith(
            color: AppColor.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
      ),
      10.verticalSpace,
      ReadMoreText(
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using , making it look like readable English Flutter(https://flutter.dev/) has its own UI components, along with an engine to render thFlutter(https://flutter.dev/) has its own UI components, along with an engine to render thFlutter(https://flutter.dev/) has its own UI components, along with an engine to render thFlutter(https://flutter.dev/) has its own UI components, along with an engine to render them on both the <@123> and <@456> platforms <@999> http://google.com #read_more. Most of those UI components, right out of the box, conform to the guidelines of #Material Design.',
          trimMode: TrimMode.Line,
          trimLines: 5,
          trimLength: 500,
          style: const TextStyle(color: Colors.grey),
          colorClickableText: Colors.black,
          lessStyle: textMedium.copyWith(color: AppColor.black),
          moreStyle: textMedium.copyWith(color: AppColor.black),

          trimCollapsedText: '..show More',
          trimExpandedText: ' show Less ',
          annotations: [
            // URL
            Annotation(
              regExp: RegExp(
                r'(?:(?:https?|ftp)://)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
              ),
              spanBuilder: ({
                required String text,
                TextStyle? textStyle,
              }) {
                return TextSpan(
                  text: text,
                  style: (textStyle ?? const TextStyle()).copyWith(
                    decoration: TextDecoration.underline,
                    color: Colors.green,
                  ),
                );
              },
            ),
          ]),
      10.verticalSpace,
    ],
  ).wrapPaddingSymmetric(horizontal: 15.w);
}
