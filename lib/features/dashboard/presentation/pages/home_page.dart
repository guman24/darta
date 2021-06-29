import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/core/constants/themes.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/dashboard/data/model/suchana.dart';
import 'package:sifaris_app/features/kyc/presentation/pages/kyc_verificaton_page.dart';
import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';
import 'package:sifaris_app/features/notice/presentation/blocs/notice/notice_bloc.dart';
import 'package:sifaris_app/features/notice/presentation/pages/all_notice_page.dart';
import 'package:sifaris_app/features/notification/presentation/pages/all_notifications_page.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';
import 'package:sifaris_app/features/paper/presentation/blocs/get_papers/get_papers_bloc.dart';
import 'package:sifaris_app/features/paper/presentation/pages/all_applied_paper.dart';
import 'package:sifaris_app/features/paper/presentation/widgets/applied_paper_item.dart';
import 'package:sifaris_app/features/profile/presentation/pages/user_profile_page.dart';
import 'package:sifaris_app/features/template/domain/entities/template_category_entity.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';
import 'package:sifaris_app/features/template/presentation/blocs/category_template/categorytemplate_bloc.dart';
import 'package:sifaris_app/features/template/presentation/blocs/templates/templates_bloc.dart';
import 'package:sifaris_app/features/template/presentation/blocs/templates_toggle/templates_toggle_cubit.dart';
import 'package:sifaris_app/features/template/presentation/pages/all_templates_page.dart';
import 'package:sifaris_app/features/template/presentation/widgets/templates_grid_item.dart';
import 'package:sifaris_app/injection.dart';
import 'package:sifaris_app/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  SessionModel sessionModel = SessionModel();
  bool isVerified = true;
  int count;

  @override
  void initState() {
    super.initState();
    getNotificationCount();
  }

  Future getNotificationCount() async {
    count = getIt<SharedPreferences>().getInt(NOTIFICATION_COUNT);
    print("counti is $count");

    return await sl<AuthLocalDataSource>().getSession();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getNotificationCount(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            sessionModel = snapshot.data;
            return AnimatedContainer(
                transform: Matrix4.translationValues(xOffset, yOffset, 0)
                  ..scale(scaleFactor),
                height: SizeConfig.screenHeight,
                duration: Duration(milliseconds: 500),
                child: SingleChildScrollView(
                    // todo: uncomment later
                    physics: sessionModel.verificationEnum ==
                            VerificationEnum.Unsent.toString()
                        ? NeverScrollableScrollPhysics()
                        : AlwaysScrollableScrollPhysics(),
                    child: Stack(
                      children: [
                        _homePageTopWidget(),
                        _homePageMidWidget(),
                        // TODO:Later
                        sessionModel.verificationEnum ==
                                VerificationEnum.Unsent.toString()
                            ? _homePageBottomWidget()
                            : SizedBox.shrink(),
                      ],
                    )));
          } else {
            return SizedBox.shrink();
          }
        });
  }

  Widget _homePageTopWidget() {
    return Container(
      height: SizeConfig.screenHeight * 0.7,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.blueColor,
              AppColors.primaryRed,
            ]),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.07,
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: isDrawerOpen
                            ? IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: AppColors.white,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  });
                                })
                            : IconButton(
                                icon: Icon(Icons.menu),
                                color: AppColors.white,
                                onPressed: () {
                                  setState(() {
                                    xOffset = 300;
                                    yOffset = 120;
                                    scaleFactor = 0.8;
                                    isDrawerOpen = true;
                                  });
                                }),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: GestureDetector(
                        onTap: () {
                          getIt<SharedPreferences>()
                              .setInt(NOTIFICATION_COUNT, 0);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AllNotificationsPage()),
                              (route) => true);
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 20.0),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Text(count > 0 ? count.toString() : "",
                                    style: AppTextTheme.generalStyle.copyWith(
                                      fontSize: 10.0,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Icon(
                                  Icons.notifications,
                                  size: 30.0,
                                  color: AppColors.white,
                                ),
                              ],
                            )),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => UserProfilePage()),
                                (route) => true);
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: 20.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://thumbs.dreamstime.com/b/handsome-man-black-suit-white-shirt-posing-studio-attractive-guy-fashion-hairstyle-confident-man-short-beard-125019349.jpg"),
                              )),
                        )),
                  ],
                ),
              ),
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
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider(
                          create: (_) =>
                              TemplatesToggleCubit()..init(type: "random"),
                          child: AllTemplatesPage())),
                  (route) => true);
            },
            child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.search_rounded)),
          )
        ],
      ),
    );
  }

  Widget _homePageMidWidget() {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.4),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: Column(
        children: [
          // sifaris ko dhacha random
          BlocProvider(
              create: (_) =>
                  getIt<TemplatesBloc>()..add(LoadPopularTemplates()),
              child: DashboardPopularTemplate()),
          // Category Templates
          BlocProvider(
              create: (_) =>
                  sl<CategorytemplateBloc>()..add(LoadCategoryTemplatesEvent()),
              child: DashboardCategoryTemplate(context: context)),
          // Notices
          BlocProvider(
              create: (_) => sl<NoticeBloc>()..add(GetNoticesEvent()),
              child: DashboardNotices(context: context)),

          // applied sifaris
          BlocProvider(
              create: (_) =>
                  getIt<GetPapersBloc>()..add(PerfomGetPapersEvent()),
              child: DashboardAppliedTemplates(context: context)),
        ],
      ),
    );
  }

  Widget _homePageBottomWidget() {
    return Container(
        decoration: BoxDecoration(color: Colors.transparent),
        margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.1),
        constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
              ),
              child: Stack(
                children: [
                  ListTile(
                    title: Text(
                      "खातालाई प्रमाणित गर्नुहोस् !",
                      style: AppTextTheme.subtitleStyle,
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(right: 100.0),
                      child: Text(
                        "सबै ढाँचा प्रयोग गर्न खातालाई प्रमाणित गर्न आवश्यक छ",
                        style: AppTextTheme.generalStyle
                            .copyWith(color: AppColors.white.withOpacity(0.6)),
                      ),
                    ),
                    leading: Icon(
                      Icons.verified_user_outlined,
                      size: 50.0,
                      color: AppColors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => KycVerificationPage()),
                            (route) => true);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Text(
                          'प्रमाणिकरण',
                          style: AppTextTheme.generalStyle.copyWith(
                            color: AppColors.primaryRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class DashboardAppliedTemplates extends StatefulWidget {
  const DashboardAppliedTemplates({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _DashboardAppliedTemplatesState createState() =>
      _DashboardAppliedTemplatesState();
}

class _DashboardAppliedTemplatesState extends State<DashboardAppliedTemplates> {
  double _paperStatusPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "जारी भएका सिफारिस",
                style: AppTextTheme.titleStyle.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => AllAppliedPaperPage()),
                      (route) => true);
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "सबै हेर्नुहोस",
                    style: AppTextTheme.generalStyle.copyWith(
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          BlocBuilder<GetPapersBloc, GetPapersState>(
            builder: (context, state) {
              if (state is GetPapersSuccessState) {
                final List<PaperEntity> _jarisifaris = state.papers;
                return ListView.builder(
                    itemCount: _jarisifaris.take(4).toList().length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AppliedPaperItem(
                        appliedPaper: _jarisifaris[index],
                      );
                    });
              } else if (state is GetPapersLoadingState) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is GetPapersFailState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}

class DashboardNotices extends StatelessWidget {
  const DashboardNotices({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "सूचना",
                style: AppTextTheme.titleStyle.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => AllNoticesPage()),
                      (route) => true);
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "सबै हेर्नुहोस",
                    style: AppTextTheme.generalStyle.copyWith(
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          BlocBuilder<NoticeBloc, NoticeState>(
            builder: (context, state) {
              if (state is NoticesLoaded) {
                List<NoticeEntity> _notices = state.notices;
                return GridView.builder(
                    itemCount: _notices.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.3,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: suchanaList[index].color,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0,
                                spreadRadius: 2,
                                color: AppColors.grayColor.withOpacity(0.4),
                                offset: Offset(1, 1),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                _notices[index].title,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: AppTextTheme.normalStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Text(
                                "By: ${_notices[index].createdBy}",
                                style: AppTextTheme.generalStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.dvr_outlined,
                                    color: AppColors.blueColor,
                                    size: 30.0,
                                  )),
                            )
                          ],
                        ),
                      );
                    });
              } else if (state is NoticeLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NoticesFailed) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}

// !DASHBOARD POPULAR TEMPLATES

class DashboardPopularTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "सिफारिसका ढाँचा",
                style: AppTextTheme.titleStyle.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                            create: (_) =>
                                TemplatesToggleCubit()..init(type: "random"),
                            child: AllTemplatesPage())),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "सबै हेर्नुहोस",
                    style: AppTextTheme.generalStyle.copyWith(
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          BlocBuilder<TemplatesBloc, TemplatesState>(
            builder: (context, state) {
              if (state is TemplatesLoaded) {
                List<TemplateEntity> templates =
                    state.templates.take(6).toList();
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: templates.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.1, crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      String icon = templates[index].icon;
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.grayColor,
                            width: 0.5,
                          ),
                        ),
                        child: TemplateGridItem(
                          index: index,
                          templates: templates,
                        ),
                      );
                    });
              }
              if (state is TemplatesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TemplatesFailed) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}

// ! DASHBOARD CATEGORY TEMPLATES
class DashboardCategoryTemplate extends StatelessWidget {
  const DashboardCategoryTemplate({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ढाँचाका क्याटागोरी",
                style: AppTextTheme.titleStyle.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider(
                              create: (_) => TemplatesToggleCubit()
                                ..init(type: "category"),
                              child: AllTemplatesPage())),
                      (route) => true);
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "सबै हेर्नुहोस",
                    style: AppTextTheme.generalStyle.copyWith(
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<CategorytemplateBloc, CategorytemplateState>(
            builder: (context, state) {
              if (state is CategoryTemplatesLoaded) {
                final List<TemplateCategoryEntity> _categoryTemplates =
                    state.categories;
                final List<Color> _colors =
                    categoryColorList.take(_categoryTemplates.length).toList();
                return GridView.builder(
                    itemCount: _categoryTemplates.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.2, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _colors[index],
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 2,
                                color: AppColors.whiteGrayColor,
                                offset: Offset(0, 1),
                              )
                            ]),
                        child: Text(
                          _categoryTemplates[index].categoryName,
                          style: AppTextTheme.generalStyle.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    });
              } else if (state is CategoryTemplatesFailed) {
                return Center(
                  child: Text(state.errorMessage.toString()),
                );
              } else if (state is CategoryTemplateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
