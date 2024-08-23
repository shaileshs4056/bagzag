import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

import '../../../data/model/response/product_details_responce.dart';
import '../../../generated/assets.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/app_image.dart';
import '../../auth/store/auth_store.dart';
import '../home_page.dart';


//  authStore.productsList =  ObservableList.of([
//   Product(
//     discount: 10.5,
//     favorite: ValueNotifier<bool>(true),
//     productTitle: 'Loose Textured T-Shirt',
//     totalDiscount: 15.99,
//     imagePath: Assets.imageBestsellerimagetwo,
//     realPrice: 150.98,
//   ),
//   Product(
//     discount: 25.0,
//     favorite: ValueNotifier<bool>(true),
//     productTitle: "Loose Textured T-Shirt",
//     totalDiscount: 50.0,
//     imagePath: Assets.imageBestsellerimageone,
//     realPrice: 499.99,
//   ),
//   Product(
//     discount: 10.00, // No discount applied
//     favorite: ValueNotifier<bool>(true),
//     productTitle: 'Loose Textured T-Shirt',
//     totalDiscount: 3,
//     imagePath: Assets.imageBestsellerimageone, // Price remains unchanged
//     realPrice: 29.99,
//   ),
//   Product(
//     discount: null, // No discount applied
//     favorite: ValueNotifier<bool>(true),
//     productTitle: 'Loose Textured T-Shirt',
//     totalDiscount: 3,
//     imagePath: Assets.imageBestsellerimageone, // Price remains unchanged
//     realPrice: 150,
//   ),
//   Product(
//     discount: null, // No discount applied
//     favorite: ValueNotifier<bool>(true),
//     productTitle: 'Loose Textured T-Shirt',
//     totalDiscount: 0,
//     imagePath: Assets.imageFavproductone,
//     realPrice: 00,
//   ),
// ];

class BestsellerStackWidget extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final double? discountPercentage;
  final ValueNotifier<bool>  isFavorite;
  final num? totalDiscount;
  final double? originalPrice;

  BestsellerStackWidget({
     this.imagePath,
     this.title,
     this.discountPercentage,
    required this.isFavorite,
     this.totalDiscount,
     this.originalPrice,
  });



  @override
  Widget build(BuildContext context) {
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
                Container(
                  height: 175.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: AppColor.mercury,
                  ),
                  child: AppImage(
                    assets: imagePath,
                    backgroundColor: AppColor.grey,
                    height: 180.h,
                    width: 140.w,
                    radius: 5.r,
                    boxFit: BoxFit.cover,
                    placeHolder: buildShimmerEffect(
                      radius: 5.r,
                      width: 134.w,
                      height: 180.h,
                    ),
                  ),
                ),
                discountPercentage==null?SizedBox.shrink():Positioned(
                  top: 10,
                  left: 0,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 3.r, vertical: 3.r),
                    decoration: BoxDecoration(
                      color: AppColor.neonPink,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2.r),
                        bottomRight: Radius.circular(2.r),
                      ),
                    ),
                    child: Text(
                      "$discountPercentage% Off",
                      style: textMedium.copyWith(
                        fontSize: 8.spMin,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: isFavorite,
                  builder: (context, value, child) => Positioned(
                    top: 8,
                    right: 5,
                    child: InkWell(
                      onTap: () {
                        isFavorite.value = !isFavorite.value;
                        // authStore.setIsFavorite(isFavorite);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          shape: BoxShape.circle,
                        ),
                        child: isFavorite.value
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
            6.verticalSpace,
            Text(title!),
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
            5.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
              decoration: BoxDecoration(
                color: AppColor.mercury.withOpacity(0.5),
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
            5.verticalSpace,
            Row(
              children: [
                Text(
            '\$${(originalPrice! - totalDiscount!).toStringAsFixed(2)}',
      style: textMedium.copyWith(
                    color: AppColor.black,
                    fontSize: 12.spMin,
                  ),
                ),
                5.horizontalSpace,
                originalPrice==null?SizedBox.shrink():Text(
                  '\$${originalPrice!}',
                  style: textRegular.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColor.grey,
                    fontSize: 12.spMin,
                  ),
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
}
