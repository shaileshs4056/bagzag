import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendify/widget/app_text_filed.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../values/validator.dart';
import '../../../../widget/button_widget_inverse.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  late bool _isObscured;

  @override
  void initState() {
    _isObscured = true;
    super.initState();
    // Initialize any state or set up listeners here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Perform tasks when dependencies change
  }


  @override
  void dispose() {
    // Clean up resources or listeners here
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.r),
          child: Column(
            children: [
              Text("Enter new password below.",style: textRegular.copyWith(
                color: AppColor.grey,
                fontSize: 14.spMin
              ),),
              16.verticalSpace,
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
              185.verticalSpace,
              SizedBox(
                width:1.sw,
                child: AppButtonInverse(S.current.update,buttonColor: AppColor.black,
                    textColor: AppColor.white,
                    radius: 5.r
                    ,(){
                      appRouter.push(ResetPasswordRoute());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
