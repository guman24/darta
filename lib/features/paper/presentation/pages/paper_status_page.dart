import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/back_button.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';

class PapaerStatusPage extends StatelessWidget {
  const PapaerStatusPage({Key key, @required this.paper}) : super(key: key);

  final PaperEntity paper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.4,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    AppColors.blueColor,
                    AppColors.primaryRed,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.1,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: CustomBackButton(
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.10,
                  left: 30.0,
                  right: 30.0,
                ),
                constraints: BoxConstraints(
                  maxHeight: SizeConfig.screenHeight * 0.3,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      paper.templateEntity.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTextTheme.titleStyle.copyWith(
                        letterSpacing: 1.4,
                        height: 1.5,
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Text(
                        paper.status == "verified"
                            ? "सफल"
                            : (paper.status == "processing"
                                ? "जाँच गर्दै"
                                : "असफल भयो"),
                        textAlign: TextAlign.right,
                        style: AppTextTheme.generalStyle.copyWith(
                          color: paper.status == "verified"
                              ? AppColors.greenColor
                              : (paper.status == "processing"
                                  ? AppColors.yellowColor
                                  : AppColors.primaryRed),
                        ),
                      ),
                    ),
                    LinearPercentIndicator(
                      percent: paper.status == "verified" ||
                              paper.status == "unverified"
                          ? 1.0
                          : 0.5,
                      lineHeight: 10.0,
                      progressColor: paper.status == "verified"
                          ? AppColors.greenColor
                          : (paper.status == "processing"
                              ? AppColors.yellowColor
                              : AppColors.primaryRed),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      paper.status == "verified"
                          ? PAPER_SUCCESS_MESSAGE
                          : (paper.status == "processing"
                              ? PAPER_UNDER_REVIEW
                              : PAPER_FAIL_MESSAGE),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTextTheme.normalStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
