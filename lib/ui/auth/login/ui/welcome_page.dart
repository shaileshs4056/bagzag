import 'package:auto_route/annotations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:trendify/values/export.dart';
import 'package:trendify/widget/button_widget_inverse.dart';
import '../../../../core/api/base_response/base_response.dart';
import '../../../../core/db/app_db.dart';
import '../../../../data/model/response/user_profile_response.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../../widget/app_text_filed.dart';
import '../../../../widget/show_message.dart';
import '../../store/auth_store.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  late GlobalKey<FormState> _formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  late ValueNotifier<bool> showLoading;

  List<ReactionDisposer>? _disposers;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    showLoading = ValueNotifier<bool>(false);

    addDisposer();
  }

  @override
  void dispose() {
    removeDisposer();
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    showLoading.dispose();
    super.dispose();
  }

  void addDisposer() {
    _disposers ??= [
      // success reaction
      reaction((_) => authStore.loginResponse,
          (BaseResponse<UserData?>? response) {
        showLoading.value = false;
        if (response?.code == "1") {
          showMessage(response?.message ?? "");
          appRouter.replaceAll([const HomeRoute()]);
          appDB.isLogin = true;
        }
      }),
      // error reaction
      reaction((_) => authStore.errorMessage, (String? errorMessage) {
        showLoading.value = false;
        if (errorMessage != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      }),
    ];
  }

  void removeDisposer() {
    if (_disposers == null) return;
    for (final element in _disposers!) {
      element.reaction.dispose();
    }
  }

  List<Widget> pages = [
    pageViewOne(),
    pageViewTwo(),
    pageViewThree(),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Observer(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      onPageChanged: (index) => authStore.setSelectedIndex(index),
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                      children: List.generate(
                    pages.length,
                    (index) => Row(
                      children: [
                        Container(
                          height: 5.h,
                          width: 50.r,
                          decoration: BoxDecoration(
                            color: authStore.selectedIndex == index
                                ? AppColor.neonPink
                                : AppColor.mercury,
                          ),
                        ),
                        5.horizontalSpace,
                      ],
                    ),
                  )),
                  37.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppButtonInverse(
                        S.of(context).signUp,
                        (){
                          appRouter.push(SignUpRoute());
                        },
                        height: 50.h,
                        radius: 5.r,
                        buttonColor: AppColor.white,
                        textColor: AppColor.black,
                        borderColor: AppColor.black,
                      ),

                      AppButtonInverse(
                        S.of(context).signIn,
                        () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            showDragHandle: true,
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                scrollDirection:  Axis.vertical,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Column(

                                    children: [
                                      0.verticalSpace,
                                      Image(
                                        image: AssetImage(Assets.imageSpalshLogo),
                                        height: 55.h,
                                        width: 53.w,
                                      ),
                                      17.verticalSpace,
                                      Text(
                                        "Welcome Back !",
                                        style: textBold.copyWith(
                                            fontSize: 16.spMin, fontWeight: FontWeight.w500),
                                      ),
                                      5.verticalSpace,
                                      RichText(
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          text: "Sign In to ",
                                          style: textLight.copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 24.spMin,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "BagZag",
                                              style: textSemiBold.copyWith(
                                                  fontSize: 24.spMin,
                                                  color: AppColor.neonPink,
                                                  fontWeight: FontWeight.w300),
                                              recognizer: TapGestureRecognizer()..onTap = () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                      20.verticalSpace,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(Assets.imageFacebook),
                                            height: 50.h,
                                            width: 50.w,
                                          ),
                                          15.horizontalSpace,
                                          Image(
                                            image: AssetImage(Assets.imageGoogle),
                                            height: 50.h,
                                            width: 50.w,
                                          ),
                                          15.horizontalSpace,
                                          Image(
                                            image: AssetImage(Assets.imageApple),
                                            height: 50.h,
                                            width: 50.w,
                                          ),
                                        ],
                                      ),
                                      25.verticalSpace,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(Assets.imageArroeForword),
                                            width: 22.w,
                                          ),
                                          7.horizontalSpace,
                                          Text(
                                            "Or",
                                            style: textMedium.copyWith(color: AppColor.grey),
                                          ),
                                          7.horizontalSpace,
                                          Image(
                                            image: AssetImage(Assets.imageArrowBack),
                                            width: 22.w,
                                          ),
                                        ],
                                      ),
                                      20.verticalSpace,
                                      AppTextField(
                                        controller: emailController,
                                        label: S.current.email,
                                        hint: S.current.email,
                                        keyboardType: TextInputType.emailAddress,
                                        validators: emailValidator,
                                        focusNode: emailNode,
                                      ),
                                      10.0.verticalSpace,
                                      AppTextField(
                                        label: S.current.password,
                                        hint: S.current.password,
                                        obscureText: true,
                                        validators: passwordValidator,
                                        controller: passwordController,
                                        focusNode: passwordNode,
                                        keyboardType: TextInputType.visiblePassword,
                                        keyboardAction: TextInputAction.done,
                                        maxLength: 15,
                                        suffixIcon: Align(
                                          alignment: Alignment.centerRight,
                                          heightFactor: 1.0,
                                          widthFactor: 1.0,
                                          child: GestureDetector(
                                            onTap: () => Future.delayed(Duration.zero, () {
                                              passwordNode.unfocus();
                                            }),
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                S.current.forgot,
                                                style: textMedium.copyWith(
                                                  color: AppColor.brownColor,
                                                  fontSize: 14.0.spMin,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      21.verticalSpace,
                                      SizedBox(
                                        width: 1.sw,
                                        child: AppButtonInverse("Sign In",radius: 5.r,height: 55.h,
                                            buttonColor: AppColor.black, () {},
                                        ),
                                      ),
                                      27.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          appRouter.push(ForgotPasswordRoute());
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Forgot Password?",
                                            textAlign: TextAlign.center,
                                            style: textRegular.copyWith(
                                                color: AppColor.santasGray,
                                                decoration: TextDecoration.underline,
                                                fontSize: 18.spMin),
                                          ),
                                        ),
                                      ),
                                      10.verticalSpace,
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                        },
                        height: 50.h,
                        width: 163.w,
                        radius: 5.r,
                        buttonColor: AppColor.black,
                        textColor: AppColor.white,
                        borderColor: AppColor.black,
                      ),
                    ],
                  ),
                  27.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      appRouter.push(HomeRoute());
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Continue as a guest",
                        textAlign: TextAlign.center,
                        style: textRegular.copyWith(
                            color: AppColor.santasGray,
                            decoration: TextDecoration.underline,
                            fontSize: 18.spMin),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

Widget pageViewOne() {
  return Stack(
    children: [
      Positioned(
        left: 0,
        top: 0,
        child: Image(
          alignment: Alignment.topLeft,
          image: AssetImage(Assets.imagePexelsAliPazani),
          height: 257.h,
          width: 257.w,
        ),
      ),
      Positioned(
        left: 167.w,
        right: 0,
        top: 175.h,
        child: Image(
          alignment: Alignment.topRight,
          image: AssetImage(Assets.imagePexelsAliPazani2),
          height: 177.h,
          width: 177.w,
        ),
      ),
      Positioned(
        left: 7.w,
        top: 231.h,
        right: 190.w,
        child: Image(
          image: AssetImage(Assets.imagePexelsGabbTapique3),
          height: 145.h,
          width: 145.w,
        ),
      ),
      Positioned(
        top: 390.h,
        child: Text(
          "Trendy Collection",
          style: textBold.copyWith(
            color: AppColor.neonPink,
            fontSize: 18.spMin,
          ),
        ),
      ),
      Positioned(
        top: 410.h,
        left: 0,
        right: 105,
        child: RichText(
          overflow: TextOverflow.clip,
          textAlign: TextAlign.start,
          text: TextSpan(
            text: "Let’s Create your own ",
            style: textLight.copyWith(
              color: AppColor.black,
              fontWeight: FontWeight.w300,
              fontSize: 34.spMin,
            ),
            children: [
              TextSpan(
                text: "Style",
                style: textSemiBold.copyWith(
                    fontSize: 34.spMin,
                    color: AppColor.neonPink,
                    fontWeight: FontWeight.w300),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget pageViewTwo() {
  return Stack(
    children: [
      Positioned(
        left: 176.w,
        top: 33.h,
        right: 35.w,
        child: Image(
          alignment: Alignment.topLeft,
          image: AssetImage(Assets.imagePageview23),
          height: 127.h,
          width: 162.w,
        ),
      ),
      Positioned(
        left: 103.w,
        top: 190.h,
        right: 0.w,
        child: Image(
          image: AssetImage(Assets.imagePageview22),
          height: 203.h,
          width: 236.w,
        ),
      ),
      Positioned(
        left: 0.w,
        right: 173.w,
        top: 82.h,
        child: Image(
          alignment: Alignment.topRight,
          image: AssetImage(Assets.imagePageview21),
          height: 204.h,
          width: 164.w,
        ),
      ),
      Positioned(
        top: 390.h,
        child: Text(
          "Payments",
          style: textBold.copyWith(
            color: AppColor.neonPink,
            fontSize: 18.spMin,
          ),
        ),
      ),
      Positioned(
        top: 410.h,
        left: 0,
        right: 105,
        child: RichText(
          overflow: TextOverflow.clip,
          textAlign: TextAlign.start,
          text: TextSpan(
            text: "100% secure  ",
            style: textLight.copyWith(
              color: AppColor.black,
              fontWeight: FontWeight.w300,
              fontSize: 34.spMin,
            ),
            children: [
              TextSpan(
                text: "payment",
                style: textSemiBold.copyWith(
                    fontSize: 34.spMin,
                    color: AppColor.neonPink,
                    fontWeight: FontWeight.w300),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget pageViewThree() {
  return Stack(
    children: [
      Positioned(
        left: 0,
        right: 115.w,
        top: 34.h,
        child: Image(
          alignment: Alignment.topLeft,
          image: AssetImage(Assets.imagePageview31),
          height: 229.h,
          width: 229.w,
        ),
      ),
      Positioned(
        left: 143.w,
        right: 0,
        top: 205.h,
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.neonPink,
              borderRadius: BorderRadius.circular(15.r)),
          child: Image(
            alignment: Alignment.topRight,
            image: AssetImage(Assets.imagePageview33),
            height: 173.h,
            width: 177.w,
          ),
        ),
      ),
      Positioned(
        top: 390.h,
        child: Text(
          "Track Order",
          style: textBold.copyWith(
            color: AppColor.neonPink,
            fontSize: 18.spMin,
          ),
        ),
      ),
      Positioned(
        top: 410.h,
        left: 0,
        right: 73,
        child: RichText(
          overflow: TextOverflow.clip,
          textAlign: TextAlign.start,
          text: TextSpan(
            text: "Experience the realtime ",
            style: textLight.copyWith(
              color: AppColor.black,
              fontWeight: FontWeight.w300,
              fontSize: 34.spMin,
            ),
            children: [
              TextSpan(
                text: "Tracking",
                style: textSemiBold.copyWith(
                    fontSize: 34.spMin,
                    color: AppColor.neonPink,
                    fontWeight: FontWeight.w300),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
