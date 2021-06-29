import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';
import 'package:sifaris_app/features/paper/presentation/blocs/get_papers/get_papers_bloc.dart';
import 'package:sifaris_app/features/paper/presentation/pages/paper_status_page.dart';
import 'package:sifaris_app/features/paper/presentation/widgets/applied_paper_item.dart';
import 'package:sifaris_app/injection.dart';

class AllAppliedPaperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => getIt<GetPapersBloc>()..add(PerfomGetPapersEvent()),
      child: SafeArea(
        child: Stack(
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
                          EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
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
            Container(
              height: SizeConfig.screenHeight,
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.1),
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverToBoxAdapter(
                      child: Container(
                    constraints: BoxConstraints(
                        minHeight: SizeConfig.screenHeight,
                        minWidth: double.infinity,
                        maxHeight: double.infinity),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                              child: Text(
                                "जारी भएका सिफारिस",
                                textAlign: TextAlign.start,
                                style: AppTextTheme.subtitleStyle.copyWith(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            BlocBuilder<GetPapersBloc, GetPapersState>(
                              builder: (context, state) {
                                if (state is GetPapersSuccessState) {
                                  final List<PaperEntity> _jarisifaris =
                                      state.papers;
                                  return ListView.builder(
                                      itemCount: _jarisifaris.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return AppliedPaperItem(
                                            appliedPaper: _jarisifaris[index]);
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
                        )),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
