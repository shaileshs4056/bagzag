import 'package:auto_route/auto_route.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:trendify/widget/app_text_filed.dart';
import 'package:trendify/widget/button_widget_inverse.dart';
import '../../../../core/db/app_db.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../values/validator.dart';
import '../../../../widget/show_message.dart';
import '../../store/auth_store.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  late GlobalKey<FormState> _formKey;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late FocusNode emailNode;
  late FocusNode mobileNode;
  late TabController tabController;
  late ValueNotifier<bool> showLoading;
  List<ReactionDisposer>? _disposers;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    emailNode = FocusNode();
    mobileNode = FocusNode();
    showLoading = ValueNotifier<bool>(false);
    tabController = TabController(length: 2, vsync: this);
    addDisposer();
  }

  @override
  void dispose() {
    removeDisposer();
    mobileController.dispose();
    emailController.dispose();
    emailNode.dispose();
    showLoading.dispose();
    mobileNode.dispose();
    super.dispose();
  }

  void addDisposer() {
    _disposers ??= [
      reaction((_) => authStore.loginResponse, (response) {
        showLoading.value = false;
        if (response?.code == "1") {
          showMessage(response?.message ?? "");
          appRouter.replaceAll([const HomeRoute()]);
          appDB.isLogin = true;
        }
      }),
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
    _disposers?.forEach((disposer) => disposer());
    _disposers = null;
  }

  Country _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('IN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColor.black),
          onPressed: () => appRouter.pop(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Text(
          "Forgot Password",
          style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.verticalSpace,
              Image.asset(
                Assets.imageMessage,
                height: 130.h,
                width: 116.w,
              ),
              24.verticalSpace,
              Text(
                "Enter your email address or mobile number we'll send you a link to reset password.",
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: textRegular.copyWith(
                    fontSize: 14.spMin, color: AppColor.santasGray),
              ),
              15.verticalSpace,
              getTabBar(),
              15.verticalSpace,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: getTabBarView(),
              ),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget getTabBar() {
    return TabBar(
      unselectedLabelColor: AppColor.grey,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: AppColor.neonPink,
      labelColor: AppColor.neonPink,
      indicatorWeight: 1,
      isScrollable: true,
      indicatorPadding: EdgeInsets.only(bottom: 10),
      automaticIndicatorColorAdjustment: true,
      controller: tabController,
      tabs: [
        Tab(
          text: "Email",
        ),
        Tab(
          text: "Mobile",
        ),
      ],
    );
  }

  Widget getTabBarView() {
    return TabBarView(
      controller: tabController,
      children: [
        getEmailTabView(),
        getMobileTabView(),
      ],
    );
  }

  Widget getEmailTabView() {
    return Column(
      children: [
        AppTextField(
          controller: emailController,
          label: S.current.email,
          hint: S.current.email,
          keyboardType: TextInputType.emailAddress,
          validators: emailValidator,
          focusNode: emailNode,
        ),
        10.verticalSpace,
        SizedBox(
          width: 1.sw,
          child: AppButtonInverse(
            "Submit",
            () {
              showDialog(
                useSafeArea: true,
                context: context,
                builder: (context) => AlertDialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 15.r),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25.r, vertical: 26.r),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage(
                          Assets.imageAlertImage,
                        ),
                        height: 102.h,
                        width: 142.w,
                        alignment: Alignment.center,
                      ),
                      24.verticalSpace,
                      Text(
                        "Check Your Email",
                        style: textMedium.copyWith(
                            fontSize: 25.sp, color: AppColor.black),
                      ),
                      10.verticalSpace,
                      Text(
                        "We have sent instructions on how to reset the password.",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: textRegular.copyWith(
                            fontSize: 14.spMin, color: AppColor.santasGray),
                      ),
                      15.verticalSpace,
                      SizedBox(
                        width: 1.sw,
                        child: AppButtonInverse("Ok",
                            height: 55.h,
                            buttonColor: AppColor.black,
                            textColor: AppColor.white, () {
                          appRouter.pop();
                        }),
                      ),
                    ],
                  ),
                ),
              );
            },
            buttonColor: AppColor.black,
          ),
        ),
      ],
    );
  }

  Widget getMobileTabView() {
    return Column(
      children: [
        AppTextField(
          controller: mobileController,
          label: S.current.mobNumber,
          hint: S.current.mobNumber,
          keyboardType: TextInputType.phone,
          validators: mobileValidator,
          focusNode: mobileNode,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            LengthLimitingTextInputFormatter(10),
          ],
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 17.r),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async => {
                    Future.delayed(Duration.zero, () {
                      mobileNode.unfocus();
                      mobileNode.canRequestFocus = false;
                    }),
                    await _openCountryPickerDialog(),
                    mobileNode.canRequestFocus = true,
                  },
                  child: Row(
                    children: [
                      CountryPickerUtils.getDefaultFlagImage(
                          _selectedDialogCountry),
                      5.horizontalSpace,
                      Text(
                        '+${_selectedDialogCountry.phoneCode}',
                        style: textMedium.copyWith(
                          fontSize: 15.spMin,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColor.black,
                        size: 15,
                      ),
                      5.horizontalSpace,
                      Container(
                        width: 2,
                        height: 15,
                        color: AppColor.mercury,
                      ),
                      5.horizontalSpace,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        10.verticalSpace,
        SizedBox(
          width: 1.sw,
          child: AppButtonInverse(
            "Get OTP",
            () {
              appRouter.push(OtpRoute());
            },
            buttonColor: AppColor.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDialogItem(Country country) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CountryPickerUtils.getDefaultFlagImage(country),
                const SizedBox(width: 8.0),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    country.name,
                    overflow: TextOverflow.fade,
                    style: textRegular.copyWith(
                      fontSize: 15.spMin,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "+${country.phoneCode}",
                  style: textRegular.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColor.mercury,
          ),
        ],
      );

  Future _openCountryPickerDialog() => showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => CountryPickerDialog(
          isDividerEnabled: true,
          popOnPick: true,
          titlePadding: const EdgeInsets.all(8.0),
          searchCursorColor: Colors.lightBlueAccent,
          searchInputDecoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
              hintText: S.current.search,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: AppColor.mercury)),
              hintStyle: textRegular.copyWith(color: AppColor.mercury),
              prefixIcon:
                  Icon(Icons.search, color: AppColor.black, size: 22.r)),
          isSearchable: true,
          title: Text(
            "Choose your country code",
            overflow: TextOverflow.fade,
            style:
                textMedium.copyWith(color: AppColor.black, fontSize: 20.spMin),
          ),
          onValuePicked: (Country country) =>
              setState(() => _selectedDialogCountry = country),
          itemBuilder: _buildDialogItem,
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('US'),
            CountryPickerUtils.getCountryByIsoCode('IN'),
          ],
        ),
      );
}
