import 'package:auto_route/auto_route.dart';

import 'package:trendify/ui/auth/login/ui/otp_page.dart';
import 'package:trendify/ui/home/categories_detailes.dart';
import 'package:trendify/ui/home/notifications_page.dart';
import 'package:trendify/ui/home/product_details.dart';
import 'package:trendify/ui/home/product_list_page.dart';

import '../core/locator/locator.dart';
import '../ui/auth/login/ui/forgot_password_page.dart';
import '../ui/auth/login/ui/login_page.dart';
import '../ui/auth/login/ui/reset_password_page.dart';
import '../ui/auth/login/ui/welcome_page.dart';
import '../ui/auth/sign_up/sign_up_page.dart';
import '../ui/home/Rate_Reviews.dart';
import '../ui/home/Store_Details.dart';
import '../ui/home/favorites_page.dart';
import '../ui/home/home_page.dart';
import '../ui/splash/splash_page.dart';
import '../ui/home/browse_categories.dart';
import '../ui/home/product_details.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
// extend the generated private router
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(page: FavoritesRoute.page),
    AutoRoute(page: BrowseCategoriesRoute.page),
    AutoRoute(page: CategoriesDetailesRoute.page),
    AutoRoute(page: ProductListRoute.page),
    AutoRoute(page: ProductDetailsRoute.page),
    AutoRoute(page: StoreDetailsRoute.page),
    AutoRoute(page: RateReviewsRoute.page),
    AutoRoute(page: NotificationsRoute.page)
  ];
}

final appRouter = locator<AppRouter>();
