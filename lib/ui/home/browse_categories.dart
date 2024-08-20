import 'package:auto_route/annotations.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendify/data/model/response/categories.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/ui/home/home_page.dart';
import 'package:trendify/widget/app_image.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../../values/colors.dart';
import '../../values/style.dart';

@RoutePage()
class BrowseCategoriesPage extends StatefulWidget {
  const BrowseCategoriesPage({super.key});

  @override
  State<BrowseCategoriesPage> createState() => _BrowseCategoriesPageState();
}

class _BrowseCategoriesPageState extends State<BrowseCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 20,
              color: AppColor.black),
          onPressed: () => appRouter.pop(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Text(
          S.current.browseCategories,
          style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: SvgPicture.asset(Assets.assetsImageFilter,height: 21,width: 21,)
            ),
          ),
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
      body: _buildFavouritesProductGrid(),
    );
  }
}

Widget _buildFavouritesProductGrid() {
  return GridView.builder(
    itemCount: image.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisExtent: 155.h,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      crossAxisCount: 2,
    ),
    shrinkWrap: true,
    clipBehavior: Clip.none,
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
    itemBuilder: (context, index) {
      return categoriesCustomStack(
          imagePath: image[index].imagePath, title: image[index].name);
    },
  );
}

List<dynamic> image = [
  CategoryItem(imagePath: Assets.imageMen, name: 'Men'),
  CategoryItem(imagePath: Assets.imageWomen, name: 'Women'),
  CategoryItem(imagePath: Assets.imageKids, name: 'Kids'),
  CategoryItem(imagePath: Assets.imageBeauty, name: 'Beauty'),
  CategoryItem(imagePath: Assets.imageMen, name: 'Home & Living'),
  CategoryItem(imagePath: Assets.imageWomen, name: 'Gedgets'),
  CategoryItem(imagePath: Assets.imageKids, name: 'Toy & Baby'),
  CategoryItem(imagePath: Assets.imageBeauty, name: 'Sports')
];
Widget categoriesCustomStack(
    {required String imagePath, required String title}) {
  return InkWell(
    onTap: () {
      appRouter.push(CategoriesDetailesRoute());
    },
    child: Container(
        padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 11.h),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: AppColor.mercury, width: 2)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 6.h),
              alignment: Alignment.bottomCenter,
              height: 112.h,
              width: 156.w,
              decoration: BoxDecoration(
                  color: AppColor.mercury,
                  borderRadius: BorderRadius.circular(5.r),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: textMedium.copyWith(
                    color: AppColor.black, fontSize: 15.spMin),
              ),
            ),
          ],
        )),
  );
}
