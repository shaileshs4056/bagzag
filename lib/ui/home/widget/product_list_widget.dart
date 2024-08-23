import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import '../../../generated/assets.dart';
import '../../../router/app_router.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/app_image.dart';
import '../home_page.dart';

class ProductListWidget extends StatefulWidget {
  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}
class _ProductListWidgetState extends State<ProductListWidget> {

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authStore.favouriteList();
    print(authStore.favoriteProducts.length);
  }
  @override
  Widget build(BuildContext context) {

    return Observer(
      builder: (context) {
        return GridView.builder(
          itemCount: authStore.favoriteProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 290.h,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
          ),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
          itemBuilder: (context, index) {
            print(authStore.favoriteProducts[index].favorite.value);
            return  authStore.favoriteProducts[index].favorite.value==true?_buildFavouritesProductCard(index):null;
          },
        );
      }
    );
  }

  Widget _buildFavouritesProductCard(int index) {
    var data =  authStore.favoriteProducts[index];
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            appRouter.push(ProductDetailsRoute(product: data)).then((value) => authStore.favouriteList(),);
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topLeft,
                  children: [
                    AppImage(
                      assets: data.imagePath,
                      height: 180.h,
                      width: 169.w,
                      radius: 5.r,
                      boxFit: BoxFit.fill,
                      placeHolder: buildShimmerEffect(
                          radius: 5.r, width: 169.w, height: 180.h),
                    ),
                    data.discount==null?SizedBox.shrink():_buildDiscountTag(),
                    ValueListenableBuilder(
                      valueListenable: data.favorite,
                      builder: (context, value, child) => Positioned(
                        top: 5.h,
                        right: 10.w,
                        child: InkWell(
                          onTap: () {
                            data.favorite.value = !data.favorite.value;
                           authStore.favouriteList();

                           print(authStore.favoriteProducts.length);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              shape: BoxShape.circle,
                            ),
                            child: data.favorite.value
                                ? Image(
                              image: AssetImage(Assets.imagePinkHeart),
                              height: 12.h,
                              width: 12.w,
                              fit: BoxFit.contain,
                            )
                                : Image(
                              image: AssetImage(Assets.imageBlackHeart),
                              height: 12.h,
                              width: 12.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data.productTitle}'),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        appRouter.push(RateReviewsRoute());
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.imageStar,
                            height: 12.h,
                            width: 12.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "4.5",
                            style: textMedium.copyWith(
                                color: AppColor.black, fontSize: 12.spMin),
                          ),
                          Text(
                            " | 256",
                            style: textRegular.copyWith(
                                color: AppColor.grey, fontSize: 12.spMin),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _buildFreeShippingTag(),
                    SizedBox(height: 7.h),
                    Row(
                      children: [
                       data.totalDiscount==0?SizedBox.shrink():Text(
                          "\$${(data.realPrice!-data.totalDiscount!).toStringAsFixed(2)}",
                          style:
                          textMedium.copyWith(color: AppColor.black, fontSize: 12.spMin),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "\$${data.realPrice!}",
                          style: textRegular.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppColor.grey,
                            fontSize: 12.spMin,
                          ),
                        ),
                        Spacer(),
                        SvgPicture.asset(Assets.imageAddTocart),
                      ],
                    ),
                  ],
                ),
              ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildDiscountTag() {
    return Positioned(
      top: 10,
      left: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.r, vertical: 3.r),
        decoration: BoxDecoration(
          color: AppColor.neonPink,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(2.r),
            bottomRight: Radius.circular(2.r),
          ),
        ),
        child: Text(
          "30% Off",
          style: textMedium.copyWith(fontSize: 8.spMin, color: AppColor.white),
        ),
      ),
    );
  }

  Widget _buildProductDetails(var data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Loose Textured T-Shirt"),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: () {
              appRouter.push(RateReviewsRoute());
            },
            child: Row(
              children: [
                Image.asset(
                  Assets.imageStar,
                  height: 12.h,
                  width: 12.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 5.w),
                Text(
                  "4.5",
                  style: textMedium.copyWith(
                      color: AppColor.black, fontSize: 12.spMin),
                ),
                Text(
                  " | 256",
                  style: textRegular.copyWith(
                      color: AppColor.grey, fontSize: 12.spMin),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          _buildFreeShippingTag(),
          SizedBox(height: 7.h),
        ],
      ),
    );
  }

  Widget _buildFreeShippingTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
      decoration: BoxDecoration(
        color: AppColor.mercury.withOpacity(0.5),
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Text(
        "Free Shipping",
        style: textMedium.copyWith(fontSize: 10.spMin, color: AppColor.grey),
      ),
    );
  }
  
}
