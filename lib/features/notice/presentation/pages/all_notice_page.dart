import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/themes.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';
import 'package:sifaris_app/features/notice/domain/model/test/suchana.dart';
import 'package:sifaris_app/features/notice/presentation/blocs/notice/notice_bloc.dart';
import 'package:sifaris_app/injection_container.dart';
import 'package:url_launcher/url_launcher.dart';

class AllNoticesPage extends StatefulWidget {
  @override
  _AllNoticesPageState createState() => _AllNoticesPageState();
}

class _AllNoticesPageState extends State<AllNoticesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NoticeBloc>()..add(GetNoticesEvent()),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: SizeConfig.screenHeight * 0.4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      AppColors.blueColor,
                      AppColors.primaryRed,
                    ])),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DashBoardPage()),
                                    (route) => false);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.blueColor,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.notifications,
                                    size: 30.0,
                                    color: AppColors.white,
                                  ),
                                  onPressed: () {}),
                              SizedBox(
                                width: 20.0,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://thumbs.dreamstime.com/b/handsome-man-black-suit-white-shirt-posing-studio-attractive-guy-fashion-hairstyle-confident-man-short-beard-125019349.jpg"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            BlocBuilder<NoticeBloc, NoticeState>(
              builder: (context, state) {
                if (state is NoticesLoaded) {
                  final List<NoticeEntity> _notices = state.notices;
                  final _colors =
                      noticesColorList.take(_notices.length).toList();
                  return Container(
                    height: SizeConfig.screenHeight,
                    margin:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.12),
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  )),
                              child: ListTile(
                                title: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'सूचना',
                                    style: AppTextTheme.subtitleStyle.copyWith(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: ListView.builder(
                                    itemCount: _notices.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 5, 0, 20),
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: _colors[index],
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _notices[index].title,
                                              style: AppTextTheme.normalStyle
                                                  .copyWith(
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            Text(
                                              "By: ${_notices[index].createdBy}",
                                              style: AppTextTheme.generalStyle
                                                  .copyWith(
                                                      color: AppColors.textColor
                                                          .withOpacity(0.5)),
                                            ),
                                            Text(
                                              _notices[index].description,
                                              style: AppTextTheme.generalStyle
                                                  .copyWith(
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                final _url = ApiConstants
                                                        .BASE_URL +
                                                    "${_notices[index].fileURL}";
                                                _openPdf(_url);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Image.asset(
                                                  "assets/images/pdf.png",
                                                  height: 40.0,
                                                  width: 40.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                _notices[index].createdAt,
                                                textAlign: TextAlign.end,
                                                style: AppTextTheme.generalStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .textColor
                                                            .withOpacity(0.5)),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              )),
                        )
                      ],
                    ),
                  );
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
      ),
    );
  }

  void _openPdf(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not lunch $url';
  }
}
