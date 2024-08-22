import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/assets.dart';
import '../../../router/app_router.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/app_image.dart';
import '../../auth/store/auth_store.dart';
import '../home_page.dart';

class ProductListWidget extends StatefulWidget {
  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: favoritesPageImages.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 272.h,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        crossAxisCount: 2,
      ),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
      itemBuilder: (context, index) {
        return _buildFavouritesProductCard(index);
      },
    );
  }

  Widget _buildFavouritesProductCard(int index) {
    return GestureDetector(
      onTap: () {
        appRouter.push(ProductDetailsRoute());
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
                  assets: favoritesPageImages[index],
                  height: 139.h,
                  width: 169.w,
                  radius: 5.r,
                  placeHolder: buildShimmerEffect(
                      radius: 5.r, width: 134.w, height: 169.h),
                ),
                if (index % 2 == 0) _buildDiscountTag(),
                Positioned(
                  top: 8,
                  right: 10.w,
                  child: _buildFavoriteButton(),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _buildProductDetails(),
          ],
        ),
      ),
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

  Widget _buildFavoriteButton() {
    return InkWell(
      onTap: () {
        authStore.setIsFavorite();
      },
      child: Observer(builder: (context) {
        return Container(
          padding: EdgeInsets.all(8.r),
          decoration: const BoxDecoration(
            color: AppColor.mercury,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            authStore.isFavorite
                ? Assets.imageBlackHeart
                : Assets.imagePinkHeart,
            height: 12.h,
            width: 12.w,
            fit: BoxFit.contain,
          ),
        );
      }),
    );
  }

  Widget _buildProductDetails() {
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
          _buildPriceAndCart(),
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

  Widget _buildPriceAndCart() {
    return Row(
      children: [
        Text(
          "\$119.99",
          style:
          textMedium.copyWith(color: AppColor.black, fontSize: 12.spMin),
        ),
        SizedBox(width: 5.w),
        Text(
          "\$159.99",
          style: textRegular.copyWith(
            decoration: TextDecoration.lineThrough,
            color: AppColor.grey,
            fontSize: 12.spMin,
          ),
        ),
        Spacer(),
        SvgPicture.asset(Assets.imageAddTocart),
      ],
    );
  }
}
