import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';

class InputTheme {
  InputTheme._();
  static InputDecoration getFormField({@required String hintText, Icon icon}) =>
      InputDecoration(
        hintText: hintText,
        prefixIcon: icon ?? null,
        isDense: false,
        labelText: hintText,
        contentPadding: EdgeInsets.fromLTRB(15, 16, 15, 16),
        hintStyle: AppTextTheme.normalStyle.copyWith(
          color: AppColors.grayColor,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: AppColors.primaryRed, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: AppColors.primaryRed, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: AppColors.primaryBlue, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: AppColors.grayColor, width: 1),
        ),
      );

  static BoxDecoration getInputBoxDecoration() => BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.grayColor.withOpacity(0.5),
              offset: Offset(0, 1),
              blurRadius: 0,
              spreadRadius: 1,
            )
          ]);
}
