import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendify/data/model/response/categories.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/generated/l10n.dart';
import 'package:trendify/router/app_router.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/ui/home/home_page.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/style.dart';
import 'package:trendify/widget/app_image.dart';

@RoutePage()
class ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSortFilterRow(context),
          Expanded(child: _buildFavouritesProductGrid()),
        ],
      ),
      endDrawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 16.h, left: 21.w, right: 15.w, bottom: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter',
                      style: textMedium,
                    ),
                    Text(
                      'Done',
                      style: textMedium.copyWith(color: AppColor.neonPink),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                title: Text(
                  'Categories',
                  style: textRegular,
                ),
                trailing: Text("Any"),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to home page or perform other actions
                },
              ),
              Divider()
              // Add more items here
            ],
          ),
        ),
      ),
    );
  }

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
      title: Text(
        "Top Wear",
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Image.asset(
              Assets.imageSearch,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSortFilterRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSortButton(context),
          SizedBox(width: 2.w),
          _buildFilterButton(),
        ],
      ),
    );
  }

  Widget _buildSortButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _showSortModalBottomSheet(context);
      },
      child: _buildButton(
        'assets/image/short.png',
        'Sort',
      ),
    );
  }

  Widget _buildFilterButton() {
    return Expanded(
      child: InkWell(
        onTap: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
        child: _buildButton(
          'assets/image/Filter.png',
          'Filter',
        ),
      ),
    );
  }

  Widget _buildButton(String assetPath, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 13.h),
      color: AppColor.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath),
          SizedBox(width: 15.w),
          Text(
            text,
            style: textRegular,
          ),
        ],
      ),
    );
  }

  void _showSortModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Recent Products',
                style: textMedium.copyWith(fontSize: 18.spMin),
              ),
              Row(
                children: [
                  _buildSortOption("Newest to Oldest"),
                  SizedBox(width: 10.w),
                  _buildSortOption("Oldest to Newest"),
                ],
              ),
              Text(
                'Rating',
                style: textMedium.copyWith(fontSize: 18.spMin),
              ),
              Row(
                children: [
                  _buildSortOption("High to Low"),
                  SizedBox(width: 10.w),
                  _buildSortOption("OLow to High"),
                ],
              ),
              Text(
                'Price',
                style: textMedium.copyWith(fontSize: 18.spMin),
              ),
              Row(
                children: [
                  _buildSortOption("High to Low"),
                  SizedBox(width: 10.w),
                  _buildSortOption("OLow to High"),
                ],
              ),
              Text(
                'Offers',
                style: textMedium.copyWith(fontSize: 18.spMin),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  _buildSortOption("High to Low"),
                  SizedBox(width: 10.w),
                  _buildSortOption("OLow to High"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
      margin: EdgeInsets.only(top: 10.h, bottom: 18.h),
      decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(width: 1.r, color: AppColor.grey),
          borderRadius: BorderRadius.circular(4.r)),
      child: Text(
        text,
        style: textRegular,
      ),
    );
  }
}

Widget _buildFavouritesProductGrid() {
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

Widget _buildFavouritesProductCard(int index) {
  return Container(
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
              placeHolder:
                  buildShimmerEffect(radius: 5.r, width: 134.w, height: 169.h),
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
          authStore.isFavorite ? Assets.imageBlackHeart : Assets.imagePinkHeart,
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
        Row(
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
        style: textMedium.copyWith(color: AppColor.black, fontSize: 12.spMin),
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
