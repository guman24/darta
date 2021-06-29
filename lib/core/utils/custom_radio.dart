import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final dynamic value;
  final Function(dynamic) onTap;
  final Color activeColor;
  final dynamic groupValue;

  const CustomRadioButton({
    Key key,
    this.label,
    this.groupValue,
    this.value,
    this.onTap,
    this.activeColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: SizeConfig.screenWidth,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(label,
            style:
                AppTextTheme.normalStyle.copyWith(color: AppColors.blueColor)),
        trailing: Radio(
          value: value,
          onChanged: onTap,
          groupValue: groupValue,
          activeColor: activeColor,
        ),
      ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       SizedBox(
      //         width: 30.0,
      //         height: 30.0,
      //         child: Radio(
      //           onChanged: onTap,
      //           groupValue: groupValue,
      //           activeColor: activeColor,
      //           value: value,
      //         ),
      //       ),
      //       SizedBox(
      //         width: 20.0,
      //       ),
      //       Text(
      //         label,
      //         textAlign: TextAlign.left,
      //         style: AppTextTheme.generalStyle.copyWith(
      //           color: AppColors.black,
      //         ),
      //       )
      //     ],
      //   ),
      // );
    );
  }
}
