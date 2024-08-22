import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendify/ui/home/widget/product_list_widget.dart';
import 'package:trendify/values/extensions/widget_ext.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../../values/colors.dart';
import '../../values/style.dart';
import '../../widget/app_image.dart';
import '../auth/store/auth_store.dart';
import 'home_page.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  List<Map<String, dynamic>> favoritesStorePageImages = [
    {
      'imagePath': Assets.imageFavoritiesStoreImageone,
      'title': 'The New Store',
    },
    {
      'imagePath': Assets.imageFavoritiesStoreImagetwo,
      'title': 'Seven Sennse Store',
    },
    {
      'imagePath': Assets.imageFavoritiesStoreImagethree,
      'title': 'Seven Sennse Store',
    },
    {
      'imagePath': Assets.imageFavoritiesStoreImageone,
      'title': 'The New Store',
    },
    {
      'imagePath': Assets.imageFavoritiesStoreImagetwo,
      'title': 'Seven Sennse Store',
    },
    {
      'imagePath': Assets.imageFavoritiesStoreImagethree,
      'title': 'Seven Sennse Store',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          indicatorWeight: 3.w,
          indicatorColor: AppColor.black,
          unselectedLabelColor: AppColor.grey,
          labelColor: AppColor.black,
          labelStyle: textRegular.copyWith(),
          controller: tabController,
          tabs: const [
            Tab(text: "Store"),
            Tab(text: "Products"),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 20,
              color: AppColor.black),
          onPressed: () => appRouter.pop(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Text(
          S.current.favorites,
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
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _buildFavouritesStoreList(),
          ProductListWidget()
        ],
      ),
    );
  }
  ///store list build method
  Widget _buildFavouritesStoreList() {
    return ListView.separated(
      itemCount: favoritesStorePageImages.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildFavouritesStoreCard(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 15.h,
        );
      },
    );
  }

  Widget _buildFavouritesStoreCard(index) {
    return InkWell(
      onTap: () {
        appRouter.push(BrowseCategoriesRoute());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(favoritesStorePageImages[index]['imagePath'],fit: BoxFit.cover,height: 154,width: double.infinity,),
          AppImage(
            backgroundColor: AppColor.red,
            assets: favoritesStorePageImages[index]['imagePath'],
            height: 154.h,
            width:double.infinity,
            radius: 10.r,
            boxFit: BoxFit.cover,
            placeHolder:
                buildShimmerEffect(radius: 5.r, height: 159.h, width: 1.sw),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${favoritesStorePageImages[index]['title']}",
                    style: textRegular.copyWith(fontSize: 16.sp),
                  ).wrapPaddingOnly(top: 5, bottom: 10),
                  Text(
                    "3038 Godfrey Stree Tigard, OR 97223",
                    style: textRegular.copyWith(fontSize: 12.sp),
                  ),
                ],
              ),
              InkWell(
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
              ).wrapPaddingOnly(right: 5.w),
            ],
          ),
        ],
      ).wrapPaddingSymmetric(horizontal: 15.w),
    );
  }
}
