import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/back_button.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/setting/presentation/pages/password_change_page.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.15,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  AppColors.blueColor,
                  AppColors.primaryRed,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: CustomBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.1),
              constraints: BoxConstraints(maxHeight: SizeConfig.screenHeight),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: SizeConfig.screenHeight,
                      ),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "सेत्टिंग",
                            style: AppTextTheme.subtitleStyle.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),
                          _settingItem(
                              "पासवर्ड परिवर्तन गर्नुहोस्",
                              Icons.vpn_key_rounded,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PasswordChangePage()))),
                          _settingItem("नोटिफिकेशन सेत्टिंग",
                              Icons.notifications, () => null),
                          _settingItem(
                              "एप उपडेट", Icons.refresh_rounded, () => null),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _settingItem(String title, IconData icon, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                  color: AppColors.textColor.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(1, 0))
            ],
            borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          title: Text(title),
          leading: Icon(
            icon,
            color: AppColors.blueColor,
          ),
        ),
      ),
    );
  }
}
