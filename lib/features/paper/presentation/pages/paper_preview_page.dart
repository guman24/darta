import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/paper/presentation/pages/paper_create_page.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';

class PaperPreviewPage extends StatefulWidget {
  final TemplateEntity templateEntity;

  const PaperPreviewPage({Key key, this.templateEntity}) : super(key: key);
  @override
  _PaperPreviewPageState createState() => _PaperPreviewPageState();
}

class _PaperPreviewPageState extends State<PaperPreviewPage> {
  TemplateEntity get template => widget.templateEntity;

  int _pageIndex = 1;
  PageController _pageController;
  List<Widget> tabs = [];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
    tabs = [
      PaperCreatePage(templateEntity: template),
      Preview(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: PageView(
      //   children: tabs,
      //   physics: NeverScrollableScrollPhysics(),
      //   controller: _pageController,
      //   onPageChanged: onPageChanged,
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _pageIndex,
      //   onTap: onTabTapped,
      //   elevation: 5,
      //   backgroundColor: Colors.white,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Padding(
      //             padding: EdgeInsets.symmetric(vertical: 10.0),
      //             child: Icon(FontAwesomeIcons.edit)),
      //         label: "सच्याउने"),
      //     BottomNavigationBarItem(
      //         icon: Padding(
      //             padding: EdgeInsets.symmetric(vertical: 10.0),
      //             child: Icon(FontAwesomeIcons.solidEye)),
      //         label: "हेर्नुहोस्"),
      //   ],
      // ),
      body: Preview(),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}

class Preview extends StatelessWidget {
  const Preview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Text(
                      "बुझाउनुभयो",
                      textAlign: TextAlign.right,
                      style: AppTextTheme.generalStyle.copyWith(
                        color: AppColors.yellowColor,
                      ),
                    ),
                  ),
                  LinearPercentIndicator(
                    percent: 0.1,
                    lineHeight: 10.0,
                    progressColor: AppColors.yellowColor,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "हामी तपाईंको खाता जाँच गर्दैछौं",
                    style: AppTextTheme.normalStyle,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              margin: EdgeInsets.only(top: 10.0, left: 20.0),
              child: Icon(Icons.arrow_back_ios),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.35),
              // height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                    decoration:
                        BoxDecoration(color: AppColors.white, boxShadow: [
                      BoxShadow(
                        color: AppColors.grayColor.withOpacity(0.3),
                        blurRadius: 1,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.asset("assets/images/gov_small.png"),
                          title: Text(
                            'मकवानपुरगढी गाँउपालिका',
                            textAlign: TextAlign.center,
                            style: AppTextTheme.subtitleStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                          subtitle: Text(
                            "वागमति प्रदेश, नेपाल",
                            textAlign: TextAlign.center,
                            style: AppTextTheme.normalStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            "फारम बुझा",
                            style: AppTextTheme.generalStyle.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "फा गर्न ढाँचा",
                            textAlign: TextAlign.center,
                            style: AppTextTheme.generalStyle.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Text(
                            "फारम बुझा",
                            style: AppTextTheme.generalStyle.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "तपाईको फारम बुझाइएको छैन किनकि केहि गल्तीका कार सबै कमप्रयोग सिफा गर्न वश्यक छ सबै ढाँचा प्रयोग सिफागर्नवश्यक छ सबै ढाँचा प्रयोग सिफा गर्न वश्यक छ सबै ढाँचा प्रयोग सिफा ग श्यक छ सबै ढाँचा प्रयोग सिफा गर्न श्यक छ सबै ढाँचा प्रयोग गर्न श्यक छ सबै ढाँचा प्रयोग सिफा गर्नवश्यक छ सबै ढाँचा प्रयोग ख गर्न श्यक छ सबै ढाँचा प्रयोग सिफा गर्न श्यक छ सबै ढाँचा प्रयोग सिफा गर्न श्यक छईको फारम बुझाइएको",
                            textAlign: TextAlign.left,
                            style: AppTextTheme.generalStyle.copyWith(
                              color: AppColors.textColor,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.55,
                          ),
                          child: ListTile(
                            title: Divider(
                              color: AppColors.textColor,
                              height: 2.0,
                            ),
                            subtitle: Text(
                              'सिफा गर्न',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: ListTile(
                      title: Text(
                        "कागजात",
                        style: AppTextTheme.normalStyle.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                      subtitle: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              child: ListTile(
                                title: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(citizenshipURL),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "अगाडिको",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
