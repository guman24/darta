import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _textAnimationController;
  AnimationController _imageController;
  Animation<Offset> _textAnimation;
  Animation<Offset> _imageAnimation;

  @override
  void initState() {
    super.initState();
    _textAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    _textAnimation = Tween<Offset>(
      begin: Offset(2.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
        parent: _textAnimationController, curve: Curves.easeIn));
    _imageController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();
    _imageAnimation = Tween<Offset>(
      begin: Offset(0.0, 5.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.decelerate,
    ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              AppColors.primaryBlue,
              AppColors.primaryRed,
            ])),
        child: Builder(
          builder: (context) {
            return Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: SizeConfig.screenHeight * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/gov_small.png",
                          width: SizeConfig.screenWidth * 0.4,
                          height: SizeConfig.screenHeight * 0.2,
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
                          height: SizeConfig.screenHeight * 0.05,
                        ),
                        Text(
                          "सिफारिस प्रणाली",
                          style: AppTextTheme.normalStyle,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.06,
                        ),
                        SlideTransition(
                          position: _textAnimation,
                          child: Text(
                            "प्रविधिमुखी सार्वजनिक सेवा प्रवाहको सुनिश्चितताको प्रयास",
                            style: AppTextTheme.normalStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _imageAnimation,
                      child: Column(
                        children: [
                          Text(
                            "Powered By",
                            textAlign: TextAlign.center,
                            style: AppTextTheme.generalStyle,
                          ),
                          Image.asset("assets/images/powerby.png"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }
}
