import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final Function onTap;

  const CustomBackButton({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 35.0,
        width: 35.0,
        padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          size: 20.0,
          color: AppColors.blueColor,
        ),
      ),
    );
  }
}
