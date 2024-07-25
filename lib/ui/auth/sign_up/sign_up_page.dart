import 'package:auto_route/auto_route.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

import '../../../core/locator/locator.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../values/validator.dart';
import '../../../widget/app_text_filed.dart';
import '../../../widget/button_widget_inverse.dart';
import '../login/widget/sign_up_widget.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final bool _isHidden = true;
  late GlobalKey<FormState> _formKey;
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  late FocusNode mobileNode;
  late ValueNotifier<bool> showLoading;
  late ValueNotifier<bool> _isRead;
  late List<ReactionDisposer> _disposers;

  late bool _isObscured;

  bool get isCurrent => !ModalRoute.of(context)!.isCurrent;

  Country _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('US');

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _isObscured = true;
    mobileNode = FocusNode();
    showLoading = ValueNotifier<bool>(false);
    _isRead = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    super.dispose();
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    mobileNode.dispose();
    showLoading.dispose();
    _isRead.dispose();
  }

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
          S.current.signUp,
          style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.0.verticalSpace,
              getHeaderContent(),
              getSignUpForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeaderContent() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget getSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          20.0.verticalSpace,
          AppTextField(
            controller: fNameController,
            label: S.current.firstName,
            hint: S.current.firstName,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.sentences,
            validators: nameValidator,
          ),
          10.0.verticalSpace,
          AppTextField(
            controller: lNameController,
            label: S.current.lastName,
            hint:  S.current.lastName,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.sentences,
            validators: nameValidator,
          ),
          10.verticalSpace,
          AppTextField(
            controller: emailController,
            label: S.current.email,
            hint: S.current.email,
            keyboardType: TextInputType.emailAddress,
            validators: emailValidator,
          ),
          10.0.verticalSpace,
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
          AppTextField(
            label: S.current.newPassword,
            hint: S.current.newPassword,
            obscureText: _isObscured,
            validators: passwordValidator,
            controller: newPasswordController,
            // focusNode: passwordNode,
            keyboardType: TextInputType.visiblePassword,
            keyboardAction: TextInputAction.done,
            maxLength: 15,
            suffixIcon: Align(
              alignment: Alignment.centerRight,
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: GestureDetector(
                onTap: () => Future.delayed(Duration.zero, () {
                  // passwordNode.unfocus();
                }),
                child: Padding(
                    padding: EdgeInsets.only(right: 20.r),
                    child: InkWell(child: Icon(_isObscured ? Icons.visibility : Icons.visibility_off,size: 20.r,),
                      onTap: (){
                        _isObscured = !_isObscured;
                        setState(() {

                        });
                      },)
                ),
              ),
            ),
          ),
          10.verticalSpace,
          AppTextField(
            label: S.current.confirmPassword,
            hint: S.current.confirmPassword,
            obscureText: _isObscured,
            validators: passwordValidator,
            controller: newPasswordController,
            // focusNode: passwordNode,
            keyboardType: TextInputType.visiblePassword,
            keyboardAction: TextInputAction.done,
            maxLength: 15,
            suffixIcon: Align(
              alignment: Alignment.centerRight,
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: GestureDetector(
                onTap: () => Future.delayed(Duration.zero, () {
                  // passwordNode.unfocus();
                }),
                child: Padding(
                    padding: EdgeInsets.only(right: 20.r),
                    child: InkWell(child: Icon(_isObscured ? Icons.visibility : Icons.visibility_off,size: 20.r,),
                      onTap: (){
                        _isObscured = !_isObscured;
                        setState(() {

                        });
                      },)
                ),
              ),
            ),
          ),
          10.0.verticalSpace,
          ValueListenableBuilder<bool>(
            valueListenable: _isRead,
            builder: (context, bool value, child) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  height: 20.0,
                  width: 20.0,
                  duration: const Duration(milliseconds: 300),
                  child: IconButton(
                    splashColor: AppColor.transparent,
                    padding: EdgeInsets.zero,
                    icon: Image.asset(
                      Assets.imageTickSquare,
                      color: value ? AppColor.neonPink : AppColor.osloGray,
                    ),
                    onPressed: () => _isRead.value = !value,
                  ),
                ),
                8.0.horizontalSpace,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: S.current.iAgree,
                      style: textLight.copyWith(
                        color: AppColor.grey,
                        fontSize: 14.spMin,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: S.current.tNc,
                          style: textSemiBold.copyWith(
                            fontSize: 14.spMin,
                            color: AppColor.black
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(S.current.tNc)),
                              );
                            },
                        ),
                        TextSpan(
                          text: S.current.and,
                        ),
                        TextSpan(
                          text: S.current.privacyPolicy,
                          style: textSemiBold.copyWith(
                            fontSize: 14.spMin,
                              color: AppColor.black
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(S.current.privacyPolicy),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          18.0.verticalSpace,
          SizedBox(
            width:1.sw,
            child: AppButtonInverse(S.current.signUp,buttonColor: AppColor.black,
                textColor: AppColor.white,
                radius: 5.r
                ,(){
                  {
                    //navigator.pushNamed(RouteName.otpVerificationPage);
                    if (_formKey.currentState?.validate() ?? false) {
                      if (newPasswordController.text.trim() !=
                          confirmPasswordController.text.trim()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.current.passwordMismatch)),
                        );

                        return;
                      }
                      if (!_isRead.value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.current.acceptTnC,
                            ),
                          ),
                        );

                        return;
                      }
                      signUpAndNavigateToHome();
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<void> signUpAndNavigateToHome() async {
    locator<AppRouter>().push(const OtpRoute());
  }

  void removeDisposer() {
    for (final element in _disposers) {
      element.reaction.dispose();
    }
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
