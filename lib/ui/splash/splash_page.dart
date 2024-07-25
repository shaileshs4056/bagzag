import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/values/colors.dart';

import '../../core/db/app_db.dart';
import '../../core/locator/locator.dart';
import '../../router/app_router.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initSetting();
    super.initState();
  }

  Future<void> initSetting() async {
    Future.delayed(const Duration(seconds: 2), () {
      final appDB = locator.get<AppDB>();
      if (!appDB.isLogin) {
        locator<AppRouter>().replaceAll([const WelcomeRoute()]);
      } else {
        locator<AppRouter>().replaceAll([const HomeRoute()]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(

      color: AppColor.white,
      child: Container(
        height:171.h,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(Assets.imageSpalshLogo)),
              Image(image: AssetImage(Assets.imageBagzag))
            ],
          ),
        ),
      ),
    );
  }
}
