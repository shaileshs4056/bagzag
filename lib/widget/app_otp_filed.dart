import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendify/values/colors.dart';
import 'package:trendify/values/export.dart';

class AppOtpField extends StatefulWidget {

  AppOtpField({
    Key? key,
  }) : super(key: key);

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      focusedBorderColor: AppColor.black,
      disabledBorderColor: AppColor.mercury,
      enabledBorderColor: AppColor.mercury,
      keyboardType: TextInputType.phone,
      showCursor: true,
      borderRadius: BorderRadius.circular(5.r),
      fieldWidth: 55.w,
      fieldHeight: 55.h,
      filled: true,
      fillColor: Colors.white,
      clearText: true,
      numberOfFields: 4,
      borderColor: Color(0xFF512DA8),
      showFieldAsBox: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "•",
        hintStyle: textBold.copyWith(color: AppColor.red, fontSize: 35.spMin),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.neonPink)
        ),
      ),
      onCodeChanged: (String code) {
      },
      onSubmit: (String verificationCode){
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Verification Code"),
                content: Text('Code entered is $verificationCode'),
              );
            }
        );
      }, // end onSubmit
    );
  }
}
