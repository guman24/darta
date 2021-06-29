import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/size_config.dart';

import 'app_text_theme.dart';

Widget customSolidButton({@required String title}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
    width: SizeConfig.screenWidth,
    height: SizeConfig.screenHeight * 0.07,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.primaryBlue,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 3.0,
          spreadRadius: 1.0,
          offset: Offset(-1, 2),
        )
      ],
    ),
    child: Text(
      title,
      style: AppTextTheme.subtitleStyle,
    ),
  );
}

Widget customLinedButton({@required String title}) {
  return Container(
    width: SizeConfig.screenWidth,
    margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
    height: SizeConfig.screenHeight * 0.06,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border.all(color: AppColors.white),
        borderRadius: BorderRadius.circular(30.0)),
    child: Text(
      title,
      style: AppTextTheme.subtitleStyle,
    ),
  );
}
