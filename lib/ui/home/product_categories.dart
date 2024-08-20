import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendify/router/app_router.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/style.dart';
import 'package:trendify/widget/button_widget.dart';
import 'package:trendify/widget/button_widget_inverse.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> items;
  CategoryDetailScreen({
    required this.category,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: textMedium.copyWith(color: AppColor.black),
        ),
        excludeHeaderSemantics: false,
        shadowColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 20,
              color: AppColor.black),
          onPressed: () => appRouter.pop(),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Observer(
            warnWhenNoObservables: false,
            builder: (context) {
              return CheckboxListTile(
                dense: true,
                title: Text(
                  'Any',
                  style: textMedium.copyWith(
                      fontSize: 14.spMin, color: AppColor.neonPink),
                ),
                value: authStore.isCheck,
                activeColor: AppColor.neonPink,
                onChanged: (value) {
                  authStore.setIsCheck();
                },
              );
            },
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            children: [
              ListTile(
                title: Text(
                  item['Type']!,
                  style: textRegular.copyWith(
                      fontSize: 14.spMin, color: AppColor.black),
                ),
                trailing: Visibility(
                  visible: item['isVisible']!,
                  child: Observer(
                    warnWhenNoObservables: false,
                    builder: (context) {
                      return Checkbox(
                        value: authStore.isCheck,
                        activeColor: AppColor.neonPink,
                        onChanged: (value) {
                          authStore.setIsCheck();
                        },
                      );
                    },
                  ),
                ),
              ),
              Divider(
                color: AppColor.grey,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 15.w),
        child: AppButtonInverse(
          width: 1.sw,
          height: 51.h,
          fontSize: 16.sp,
          fontWight: FontWeight.w500,
          radius: 5.r,
          'Clear Filter',
          textColor: AppColor.black,
          () {
            appRouter.pop();
          },
          buttonColor: AppColor.white,
          borderColor: AppColor.black,
        ),
      ),
    );
  }
}
