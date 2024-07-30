import 'package:flutter/material.dart';
import 'package:trendify/values/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtonInverse extends StatelessWidget {
  final String label;
  final Function() callback;
  final double? elevation;
  final double? height;
  final double? width;
  final double? radius;
  final double? padding;
  final Color? buttonColor; // Custom button color
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWight; // Custom text color
  final Color? borderColor; // Custom border color

  const AppButtonInverse(this.label, this.callback,
      {super.key,
      this.elevation = 0.0,
      this.height,
      this.width,
      this.radius,
      this.padding,
      this.buttonColor, // Custom button color
      this.textColor, // Custom text color
      this.borderColor, // Custom border color
      this.fontSize,
      this.fontWight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Use provided width or default to double.infinity
      height: height ?? 55.h, // Use provided height or default to 50.h
      child: MaterialButton(
        elevation: elevation ?? 0.0,
        padding:
            EdgeInsets.symmetric(vertical: padding ?? 10.0, horizontal: 45).r,
        onPressed: callback,
        color: buttonColor ??
            AppColor
                .primaryColor, // Use custom color or default to primary color
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: borderColor ??
                  AppColor
                      .primaryColor), // Match the border color to the button color
          borderRadius:
              BorderRadius.all(Radius.circular(radius ?? kBorderRadius)),
        ),
        child: Text(
          label,
          style: textBold.copyWith(
            color: textColor ??
                AppColor.white, // Use custom text color or default to white
            fontSize: fontSize ?? 16.spMin,
            fontWeight: fontWight ?? FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
