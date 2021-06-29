import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';

import 'app_text_theme.dart';

showCustomSnack(
    {@required BuildContext context,
    @required String type,
    @required String messege}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
    children: [
      type == SnackBarMessegeType.PROGRESS.toString()
          ? SizedBox(
              height: 30.0, width: 30.0, child: CircularProgressIndicator())
          : (type == SnackBarMessegeType.ERROR.toString()
              ? Icon(
                  Icons.error,
                  color: AppColors.primaryRed,
                )
              : type == SnackBarMessegeType.INFO.toString()
                  ? Icon(
                      Icons.info,
                      color: AppColors.blueColor,
                    )
                  : SizedBox.shrink()),
      SizedBox(
        width: 10.0,
      ),
      Text(messege,
          overflow: TextOverflow.visible,
          maxLines: 2,
          style: AppTextTheme.normalStyle.copyWith(
            color: AppColors.white,
            fontSize: 14.0,
          )),
    ],
  )));
}
