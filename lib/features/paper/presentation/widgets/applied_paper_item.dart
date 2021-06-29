import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';
import 'package:sifaris_app/features/paper/presentation/pages/paper_status_page.dart';

class AppliedPaperItem extends StatelessWidget {
  const AppliedPaperItem({
    Key key,
    @required PaperEntity appliedPaper,
  })  : _appliedPaper = appliedPaper,
        super(key: key);

  final PaperEntity _appliedPaper;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => PapaerStatusPage(
                      paper: _appliedPaper,
                    )),
            (route) => true);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: InputTheme.getInputBoxDecoration().copyWith(boxShadow: [
          BoxShadow(
            spreadRadius: 7,
            blurRadius: 3,
            color: AppColors.grayColor.withOpacity(0.2),
            offset: Offset(-2, 5),
          )
        ]),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: InputTheme.getInputBoxDecoration(),
                  child: Image.asset("assets/images/gov_small.png")),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _appliedPaper.templateEntity.title ?? "",
                      style: AppTextTheme.normalStyle.copyWith(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _appliedPaper.nepaliDate,
                      style: AppTextTheme.generalStyle.copyWith(
                          color: AppColors.textColor.withOpacity(0.7)),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 10.0,
                      trailing: new Text(
                        _appliedPaper.status,
                        style: AppTextTheme.generalStyle.copyWith(
                          color: _appliedPaper.status == "verified"
                              ? AppColors.greenColor
                              : (_appliedPaper.status == "rejected"
                                  ? AppColors.primaryRed
                                  : AppColors.yellowColor),
                          // color: jariSifarisList[index].color,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      percent: _appliedPaper.status == "verified" ||
                              _appliedPaper.status == "rejected"
                          ? 1.0
                          : 0.5,
                      progressColor: _appliedPaper.status == "verified"
                          ? AppColors.greenColor
                          : (_appliedPaper.status == "rejected"
                              ? AppColors.primaryRed
                              : AppColors.yellowColor),
                      // progressColor:
                      //     jariSifarisList[index].color,
                      backgroundColor: AppColors.grayColor.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
