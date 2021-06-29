import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/back_button.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/login_page.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/register_page.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  PageController _pageViewController = PageController(
    initialPage: 0,
  );

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue,
            AppColors.primaryRed,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.8, 0.9],
        )),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            _currentIndex == 1
                ? Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 40.0,
                    ),
                    child: CustomBackButton(
                      onTap: () {
                        if (_currentIndex == 0) {
                          Navigator.pop(context);
                        } else if (_currentIndex == 1) {
                          _pageViewController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInExpo);
                        }
                      },
                    ),
                  )
                : SizedBox.shrink(),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.1),
              constraints: BoxConstraints(
                maxHeight: SizeConfig.screenHeight * 0.3,
                maxWidth: SizeConfig.screenWidth,
                minWidth: SizeConfig.screenWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Image.asset("assets/images/gov_small.png")),
                  Expanded(
                    flex: 2,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "मकवानपुरगढी गाँउपालिका \n",
                            style: AppTextTheme.titleStyle),
                        TextSpan(
                            text: "वागमति प्रदेश, नेपाल\n",
                            style: AppTextTheme.subtitleStyle),
                        TextSpan(
                            text: "सिफारिस प्रणाली",
                            style: AppTextTheme.normalStyle)
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.4),
              constraints: BoxConstraints(
                maxHeight: SizeConfig.screenHeight * 0.6,
              ),
              alignment: Alignment.center,
              child: PageView(
                controller: _pageViewController,
                // physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _onboardingFirst(),
                  _onboardingSecond(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _onboardingFirst() {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: Image.asset(
            "assets/images/intro1.png",
            width: 180.0,
            height: 180.0,
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 10,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 10,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: Text(
              "यस एप मार्फत तपाइले मकवानपुर नगरपालिकाद्वारा प्रदान गरिने सिफारिशको लागि निवेदन बुझाउन सक्नु हुनेछ |",
              textAlign: TextAlign.center,
              style: AppTextTheme.normalStyle,
            ),
          ),
        ),
        Expanded(
            flex: 0,
            child: GestureDetector(
                onTap: () {
                  if (_currentIndex == 0) {
                    _pageViewController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInExpo);
                  }
                },
                child: customSolidButton(title: "अर्को"))),
        Expanded(
          child: Container(),
        )
      ],
    );
  }

  Widget _onboardingSecond() {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: Image.asset(
            "assets/images/intro2.png",
            width: 180.0,
            height: 180.0,
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 10,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 10,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: Text(
              "यस एपका सम्पूर्ण विवरणहरु नेपाली भाषामा भर्नुहुन अनुरोध गर्दछ |",
              textAlign: TextAlign.center,
              style: AppTextTheme.normalStyle,
            ),
          ),
        ),
        Expanded(
            flex: 0,
            child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                      (route) => true);
                },
                child: customSolidButton(title: "साईन ईन"))),
        Expanded(
          flex: 0,
          child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterPage()),
                    (route) => true);
              },
              child: customLinedButton(title: "साइन अप")),
        )
      ],
    );
  }
}
