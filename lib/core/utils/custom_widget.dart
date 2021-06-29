import 'package:flutter/cupertino.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/size_config.dart';

import 'app_text_theme.dart';

Widget municipalityContentWidge() {
  return Column(
    children: [
      Image.asset(
        "assets/images/gov_small.png",
        width: SizeConfig.screenWidth * 0.25,
        height: SizeConfig.screenHeight * 0.12,
      ),
      Text(
        "मकवानपुर गाँउपालिका",
        style: AppTextTheme.titleStyle,
      ),
      Text(
        "वागमति प्रदेश, नेपाल",
        style: AppTextTheme.subtitleStyle,
      ),
      SizedBox(
        height: SizeConfig.screenHeight * 0.001,
      ),
      Text(
        "सिफारिस प्रणाली",
        style: AppTextTheme.normalStyle,
      ),
    ],
  );
}

Widget topContainer() {
  return Container(
    height: SizeConfig.screenHeight * 0.5,
    width: SizeConfig.screenWidth,
    padding: EdgeInsets.symmetric(vertical: 30.0),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          AppColors.blueColor,
          AppColors.primaryRed,
        ])),
    child: municipalityContentWidge(),
  );
}
