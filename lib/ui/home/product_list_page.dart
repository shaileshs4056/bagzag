import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/router/app_router.dart';
import 'package:trendify/ui/auth/store/auth_store.dart';
import 'package:trendify/ui/home/home_page.dart';
import 'package:trendify/ui/home/product_categories.dart';
import 'package:trendify/ui/home/widget/product_list_widget.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/style.dart';
import 'package:trendify/widget/app_image.dart';
import 'package:trendify/widget/button_widget_inverse.dart';

@RoutePage()
class ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

Map<String, List<Map<String, dynamic>>> filterMenuMap = {
  'Categories': [
    {'Type': 'Women (10)', 'isVisible': false},
    {'Type': 'Kids (15)', 'isVisible': false},
    {'Type': 'Beauty (20)', 'isVisible': false},
    {'Type': 'Home & Living (20)', 'isVisible': false},
    {'Type': 'Cameras & Photo (20)', 'isVisible': false},
    {'Type': 'Shoes & Accessories (20)', 'isVisible': false},
  ],
  'Subcategories': [
    {'Type': 'Watcher', 'isVisible': true},
    {'Type': 'Inner Wear', 'isVisible': true},
    {'Type': 'Footwear', 'isVisible': true},
  ],
  'Brand': [
    {'Type': 'Brand 2', 'isVisible': true},
    {'Type': 'Brand 3', 'isVisible': true},
    {'Type': 'Brand 4', 'isVisible': true},
  ],
  'Size': [
    {'Type': 'Regular', 'isVisible': true},
    {'Type': 'Not Specified', 'isVisible': true},
  ],
  'Color': [
    {'Type': 'Red', 'isVisible': true},
    {'Type': 'Blue', 'isVisible': true},
    {'Type': 'Green', 'isVisible': true},
    {'Type': 'Black', 'isVisible': true},
    {'Type': 'White', 'isVisible': true},
    {'Type': 'Red', 'isVisible': true},
    {'Type': 'Blue', 'isVisible': true},
    {'Type': 'Green', 'isVisible': true},
    {'Type': 'Black', 'isVisible': true},
    {'Type': 'White', 'isVisible': true},
    {'Type': 'Red', 'isVisible': true},
    {'Type': 'Blue', 'isVisible': true},
    {'Type': 'Green', 'isVisible': true},
    {'Type': 'Black', 'isVisible': true},
    {'Type': 'White', 'isVisible': true},
    {'Type': 'Red', 'isVisible': true},
    {'Type': 'Blue', 'isVisible': true},
    {'Type': 'Green', 'isVisible': true},
    {'Type': 'Black', 'isVisible': true},
    {'Type': 'White', 'isVisible': true},
  ],
  'Price Range': [
    {'Type': 'Under \$15.00', 'isVisible': true},
    {'Type': '\$15.00 to \$35.00', 'isVisible': true},
    {'Type': '\$100 -', 'isVisible': true},
    {'Type': 'Over \$35.00', 'isVisible': true},
    {'Type': 'Custom', 'isVisible': true},
  ],
  'Offer Range': [
    {'Type': '10% Off', 'isVisible': true},
    {'Type': '20% Off', 'isVisible': true},
    {'Type': '30% Off', 'isVisible': true},
    {'Type': 'Buy 1 Get 1 Free', 'isVisible': true},
    {'Type': 'Seasonal Sale', 'isVisible': true},
  ],
  'Delivery Type': [
    {'Type': 'Standard Shipping', 'isVisible': true},
    {'Type': 'Express Shipping', 'isVisible': true},
    {'Type': 'Same Day Delivery', 'isVisible': true},
    {'Type': 'Free Shipping', 'isVisible': true},
    {'Type': 'In-Store Pickup', 'isVisible': true},
  ],
  'Store Location': [
    {'Type': '10 To 15 Mi', 'isVisible': true},
    {'Type': '15 To 35 Mi', 'isVisible': true},
    {'Type': 'Over 34', 'isVisible': true},
  ],
  'Condition': [
    {'Type': 'New', 'isVisible': true},
    {'Type': 'Used', 'isVisible': true},
    {'Type': 'Refurbished', 'isVisible': true},
    {'Type': 'Open Box', 'isVisible': true},
    {'Type': 'Pre-Owned', 'isVisible': true},
  ],
};
class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: Column(
          children: [
            Expanded(child: ProductListWidget(),),
          ],
        ),
        endDrawer: buildFilterDrawer(context));
  }
  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,size: 20,
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
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: _buildSortFilterRow(context),
      ),
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
          Assets.imageFilter,
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

Widget buildMainDrawerContent(BuildContext context) {
  final filterMenuList = [
    {'Category': 'Category 1', 'Type': 'Type A'},
    {'Category': 'Category 2', 'Type': 'Type B'},
    {'Category': 'Category 3', 'Type': 'Type C'},
  ];

  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: 16.h, left: 21.w, right: 15.w, bottom: 32.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyle(fontSize: 18.sp), // Replace with textMedium
              ),
              Text(
                'Done',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.pink, // Replace with AppColor.neonPink
                ),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            filterMenuList.length,
            (index) => Column(
              children: [
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
                  title: Text(
                    "${filterMenuList[index]['Category']}",
                    style: TextStyle(
                      fontSize: 16.sp, // Replace with textRegular
                      color: Colors.black, // Replace with AppColor.black
                    ),
                  ),
                  trailing: Text(
                    "${filterMenuList[index]['Type']}",
                    style: TextStyle(
                      fontSize: 16.sp, // Replace with textRegular
                      color: Colors.grey, // Replace with AppColor.grey
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/nestedroute');
                  },
                ),
                Divider(
                  color: Colors.black, // Replace with AppColor.black
                ),
              ],
            ),
          ),
        ),
        // Add more items here
      ],
    ),
  );
}

Widget buildNestedDrawerContent(BuildContext context) {
  final filterMenuList = [
    {'Category': 'Category 1', 'Type': 'Type A'},
    {'Category': 'Category 2', 'Type': 'Type B'},
  ];

  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: 16.h, left: 21.w, right: 15.w, bottom: 32.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyle(fontSize: 18.sp), // Replace with textMedium
              ),
              Text(
                'Done',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.pink, // Replace with AppColor.neonPink
                ),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            filterMenuList.length,
            (index) => Column(
              children: [
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
                  title: Text(
                    "${filterMenuList[index]['Category']}",
                    style: TextStyle(
                      fontSize: 16.sp, // Replace with textRegular
                      color: Colors.black, // Replace with AppColor.black
                    ),
                  ),
                  trailing: Text(
                    "${filterMenuList[index]['Type']}",
                    style: TextStyle(
                      fontSize: 16.sp, // Replace with textRegular
                      color: Colors.grey, // Replace with AppColor.grey
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/nested');
                  },
                ),
                Divider(
                  color: Colors.black, // Replace with AppColor.black
                ),
              ],
            ),
          ),
        ),
        // Add more items here
      ],
    ),
  );
}

/// Builds the filter drawer with a nested Navigator.
Widget buildFilterDrawer(BuildContext context) {
  return Drawer(
    child: Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(
              excludeHeaderSemantics: false,
              shadowColor: AppColor.white,
              backgroundColor: AppColor.white,
              elevation: 0,
              title: Text(
                "Filter",
                style: textMedium.copyWith(color: AppColor.black),
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15).r,
                    child: Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: textMedium.copyWith(color: AppColor.neonPink),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                      filterMenuMap.length,
                          (index) => Column(
                        children: [
                          // List tile for each filter option
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 0),
                            title: Text(
                              "${filterMenuMap.keys.elementAt(index)}",
                              style: textRegular.copyWith(
                                  color: AppColor.black),
                            ),
                            trailing: Text(
                              "Any",
                              style: textRegular.copyWith(
                                  color: AppColor.grey),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryDetailScreen(
                                    category: filterMenuMap.keys.elementAt(index),
                                    items: filterMenuMap.values
                                        .elementAt(index)
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          Divider(
                            color: AppColor.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add more items here if needed
                ],
              ),
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
          ),
        );
      },
    ),
  );
}

class UndefinedRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefined Route'),
      ),
      body: Center(
        child: Text('This route is not defined'),
      ),
    );
  }
}
