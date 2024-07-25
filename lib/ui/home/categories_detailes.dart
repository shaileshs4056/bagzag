import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/router/app_router.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/export.dart';
import 'package:trendify/widget/app_image.dart';

@RoutePage()
class CategoriesDetailesPage extends StatefulWidget {
  @override
  State<CategoriesDetailesPage> createState() => _CategoriesDetailesPageState();
}

class _CategoriesDetailesPageState extends State<CategoriesDetailesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColor.mercury,
            expandedHeight: 178.0,
            flexibleSpace: FlexibleSpaceBar(
                stretchModes: [StretchMode.zoomBackground],
                titlePadding: EdgeInsets.only(left: 15.w, bottom: 20.h),
                title: Text(
                  'Man',
                  textAlign: TextAlign.left,
                  style: textSemiBold.copyWith(
                      color: AppColor.black, fontSize: 30.spMin),
                ),
                background: Align(
                  alignment: Alignment.bottomRight,
                  child: AppImage(
                    assets: Assets.imageMen,
                    height: 122.h,
                    width: 128.w,
                  ),
                )),
            // Make the app bar "floating"
            floating: true,
            // Snap app bar to the top on scroll
            snap: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: AppColor.black),
              onPressed: () => appRouter.pop(),
            ),
          ),
          // SliverList or other sliver widgets can be added here
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () {
                          appRouter.push(ProductListRoute());
                        },
                        contentPadding: EdgeInsets.zero,
                        titleAlignment: ListTileTitleAlignment.threeLine,
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16.h,
                          color: AppColor.grey,
                        ),
                        title: Text(
                          'Top Wear',
                          style: textMedium.copyWith(
                              color: AppColor.black, fontSize: 16.spMin),
                        ),
                      ),
                      Divider(
                        color: AppColor.grey,
                      )
                    ],
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
