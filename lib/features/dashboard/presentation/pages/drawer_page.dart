import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:sifaris_app/features/notice/presentation/pages/all_notice_page.dart';
import 'package:sifaris_app/features/paper/presentation/pages/all_applied_paper.dart';
import 'package:sifaris_app/features/setting/presentation/pages/setting_page.dart';
import 'package:sifaris_app/features/template/presentation/blocs/templates_toggle/templates_toggle_cubit.dart';
import 'package:sifaris_app/features/template/presentation/pages/all_templates_page.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.drawerBgColor,
        // height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.fromLTRB(0, SizeConfig.screenHeight * 0.03, 10, 10),
        child: Container(
          constraints: BoxConstraints(
            minHeight: SizeConfig.screenHeight,
          ),
          margin: EdgeInsets.only(
              left: 20.0, right: SizeConfig.screenWidth * 0.32, top: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Icon(
              //       Icons.cancel,
              //       color: Colors.white,
              //     ),
              //     SizedBox(
              //       width: 10.0,
              //     ),
              //     Text(
              //       "मेनू बन्द गर्नुहोस्",
              //       style: AppTextTheme.generalStyle
              //           .copyWith(color: AppColors.white.withOpacity(0.8)),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: SizeConfig.screenHeight * 0.05,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(
                        "https://thumbs.dreamstime.com/b/handsome-man-black-suit-white-shirt-posing-studio-attractive-guy-fashion-hairstyle-confident-man-short-beard-125019349.jpg"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Rajan Karki",
                    style: AppTextTheme.subtitleStyle.copyWith(
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                color: AppColors.whiteGrayColor,
              ),
              Text(
                "सेवाहरू",
                style: AppTextTheme.generalStyle.copyWith(
                  color: AppColors.white.withOpacity(0.8),
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

              _drawerListItem(
                  "सिफारिसका ढाँचा",
                  () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider(
                              create: (_) =>
                                  TemplatesToggleCubit()..init(type: "random"),
                              child: AllTemplatesPage())),
                      (route) => true)),
              SizedBox(
                height: 10.0,
              ),

              _drawerListItem(
                  "ढाँचाका क्याटागोरी",
                  () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider(
                              create: (_) => TemplatesToggleCubit()
                                ..init(type: "category"),
                              child: AllTemplatesPage())),
                      (route) => true)),
              SizedBox(
                height: 10.0,
              ),
              _drawerListItem(
                  "सूचना",
                  () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => AllNoticesPage()),
                      (route) => true)),

              SizedBox(
                height: 10.0,
              ),
              _drawerListItem(
                  "जारी भएका सिफारिस",
                  () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => AllAppliedPaperPage()),
                      (route) => true)),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                color: AppColors.whiteGrayColor,
              ),
              Text(
                "अन्य",
                style: AppTextTheme.generalStyle.copyWith(
                  color: AppColors.white.withOpacity(0.8),
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              _drawerListItem(
                  "सेत्टिंग",
                  () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SettingPage()))),
              SizedBox(
                height: 10.0,
              ),
              _drawerListItem("प्रमाणिकरण", () => null),
              SizedBox(
                height: 10.0,
              ),
              _drawerListItem("हाम्रोबारे", () => null),
              SizedBox(
                height: 10.0,
              ),
              _drawerListItem("सर्तहरू", () => null),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                color: AppColors.whiteGrayColor,
              ),
              _drawerListItem(
                  "बाहिर निस्कनु", () => context.read<AuthCubit>()..loggedOut())
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerListItem(String text, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Text(
          text,
          style: AppTextTheme.normalStyle.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
