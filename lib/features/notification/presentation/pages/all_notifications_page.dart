import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/back_button.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/notification/domain/entities/notification_entity.dart';
import 'package:sifaris_app/features/notification/presentation/blocs/notification/notification_bloc.dart';
import 'package:sifaris_app/features/paper/presentation/pages/paper_status_page.dart';
import 'package:sifaris_app/features/profile/presentation/pages/user_profile_page.dart';
import 'package:sifaris_app/injection.dart';
import 'package:timeago/timeago.dart' as timeago;

class AllNotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationBloc>()..add(GetNotificationsEvent()),
      child: Scaffold(
        body: SafeArea(
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
                              child: CustomBackButton(
                                onTap: () => Navigator.pop(context),
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
                            children: [
                              ListTile(
                                title: Text(
                                  "सूचना",
                                  style: AppTextTheme.subtitleStyle.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Divider(
                                  color: AppColors.grayColor,
                                ),
                              ),
                              BlocBuilder<NotificationBloc, NotificationState>(
                                builder: (context, state) {
                                  if (state is NotificationLoadedState) {
                                    final List<NotificationEntity>
                                        _notifications = state.notifcations;

                                    return ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final currentTime = DateTime.now();
                                          final _notificationCreatedAt = timeago
                                              .format(currentTime.subtract(
                                                  Duration(
                                                      milliseconds:
                                                          _notifications[index]
                                                              .createdAt)));
                                          return ListTile(
                                            onTap: () {
                                              if (_notifications[index].type ==
                                                  "user_verification") {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            UserProfilePage()),
                                                    (route) => true);
                                              }
                                              if (_notifications[index].type ==
                                                  "paper_creation") {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            PapaerStatusPage(
                                                              paper: null,
                                                            )),
                                                    (route) => true);
                                              }
                                            },
                                            leading: Icon(
                                              Icons.notifications,
                                              // color: _notifications[index]
                                              //         .isRead
                                              //     ? AppColors.blueColor
                                              //         .withOpacity(0.5)
                                              //     : AppColors.blueColor,
                                            ),
                                            title: Text(
                                              _notifications[index].title,
                                              maxLines: 2,
                                              style: AppTextTheme.normalStyle
                                                  .copyWith(
                                                color: AppColors.textColor,
                                                fontSize: 15.0,
                                                // fontWeight:
                                                //     testNotifications[index]
                                                //             .isRead
                                                //         ? FontWeight.w500
                                                //         : FontWeight.bold,
                                              ),
                                            ),
                                            subtitle:
                                                Text(_notificationCreatedAt),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              color: AppColors.grayColor,
                                            ),
                                        itemCount: _notifications.length);
                                  } else if (state is NotificationFailedState) {
                                    return Center(
                                      child: Text(state.errorMessage),
                                    );
                                  } else if (state
                                      is NotificationLoadingState) {
                                    return Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
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
      ),
    );
  }
}
