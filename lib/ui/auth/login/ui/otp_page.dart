import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendify/generated/assets.dart';
import 'package:trendify/router/app_router.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/style.dart';
import 'package:trendify/widget/button_widget_inverse.dart';
import '../../../../generated/l10n.dart';
import '../../../../widget/app_otp_filed.dart';

@RoutePage()
class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            30.verticalSpace,
            _buildImage(),
            24.verticalSpace,
            _buildDescriptionText(),
            7.verticalSpace,
            _buildPhoneNumberRow(),
            20.verticalSpace,
             AppOtpField(),
            20.verticalSpace,
            _buildVerifyButton(),
            10.verticalSpace,
            _buildResendCodeRow(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColor.black),
        onPressed: () => appRouter.pop(),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColor.white,
      title: Text(
        S.current.forgotPassword,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      Assets.imageMessage,
      height: 130.h,
      width: 116.w,
    );
  }

  Widget _buildDescriptionText() {
    return Text(
      S.current.enterYourEmailAddressOrMobileNumberWellSendYou,
      overflow: TextOverflow.clip,
      textAlign: TextAlign.center,
      style: textRegular.copyWith(fontSize: 14.spMin, color: AppColor.santasGray),
    );
  }

  Widget _buildPhoneNumberRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "+33- 808-621-8522",
          style: textMedium.copyWith(fontSize: 14.spMin),
        ),
        10.horizontalSpace,
        Image(image: AssetImage(Assets.imageEdit)),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: 1.sw,
      child: AppButtonInverse(
        S.current.verify,
            () => appRouter.push(ResetPasswordRoute()),
        buttonColor: AppColor.black,
        textColor: AppColor.white,
        radius: 5.r,
      ),
    );
  }

  Widget _buildResendCodeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.refresh_outlined, color: AppColor.neonPink),
        Text(
          S.current.resendCode,
          style: textRegular.copyWith(
            color: AppColor.black,
            fontSize: 15.spMin,
          ),
        ),
      ],
    );
  }
}
