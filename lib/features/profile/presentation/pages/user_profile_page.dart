import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/kyc/presentation/pages/kyc_verificaton_page.dart';
import 'package:sifaris_app/features/profile/domain/entities/profile_entity.dart';
import 'package:sifaris_app/features/profile/presentation/blocs/profile/profile_bloc.dart';
import 'package:sifaris_app/injection_container.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key key,
  }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  SessionModel sessionModel = SessionModel();
  @override
  void initState() {
    super.initState();
    getSession();
  }

  void getSession() async {
    sessionModel = await sl<AuthLocalDataSource>().getSession();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(GetProfileEvent()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadedState) {
                final ProfileEntity profile = state.profile;
                return Stack(
                  children: [
                    Container(
                      height: SizeConfig.screenHeight * 0.40,
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
                            height: 50.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 22.0, horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 30.0),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage:
                                      NetworkImage(profile.profilePhoto),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "${profile.firstName} ${profile.middleName ?? ""} ${profile.lastName}",
                                    style: AppTextTheme.titleStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                          color: profile.citizenDetails.verified
                                              ? AppColors.greenColor
                                              : AppColors.primaryRed,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        profile.status,
                                        style: AppTextTheme.generalStyle,
                                      ),
                                    ),
                                    profile.status == "unverified"
                                        ? Container(
                                            margin: EdgeInsets.only(left: 20.0),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            KycVerificationPage()),
                                                    (route) => true);
                                              },
                                              child: Text(
                                                "Edit KYC",
                                                style: AppTextTheme.normalStyle
                                                    .copyWith(
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.38),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "सम्पर्क",
                            style: AppTextTheme.subtitleStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            decoration: BoxDecoration(
                                color: AppColors.whiteGrayColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: [
                                _profileItem(
                                    value: profile.email, title: "ईमेल"),
                                _divider(),
                                _profileItem(
                                    value: profile.phone, title: "फोन नम्बर"),
                                _divider(),
                                _profileItem(
                                    title: "नागरिकता नम्बर",
                                    value: profile
                                        .citizenDetails.citizenshipNumber)
                              ],
                            ),
                          ),
                          // Address
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "ठेगाना",
                            style: AppTextTheme.subtitleStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            decoration: BoxDecoration(
                                color: AppColors.whiteGrayColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: [
                                _profileItem(
                                    title: "ठेगाना",
                                    value: profile
                                            .citizenDetails.permanentProvince ??
                                        "Gandaki"),
                                _divider(),
                                _profileItem(
                                    title: "जिल्ला",
                                    value: profile
                                            .citizenDetails.permanentDistrict ??
                                        "Baglung"),
                                _divider(),
                                _profileItem(
                                    title: "गा.पा. । न.पा.",
                                    value: profile.citizenDetails
                                            .permanentMunicipality ??
                                        "Galkot"),
                                _divider(),
                                _profileItem(
                                    title: "वार्ड",
                                    value:
                                        profile.citizenDetails.permanentWard ??
                                            "02"),
                              ],
                            ),
                          ), // gender
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "लिङ्ग",
                            style: AppTextTheme.subtitleStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                              height: 50.0,
                              alignment: Alignment.centerLeft,
                              width: SizeConfig.screenWidth,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteGrayColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                // TODO: change this gender later from server value
                                title: Text(
                                  profile.gender ?? "",
                                  style: AppTextTheme.generalStyle
                                      .copyWith(color: AppColors.textColor),
                                ),
                              )),

                          // documents
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "कागजात",
                            style: AppTextTheme.subtitleStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                          GridView.builder(
                              itemCount: profile.personalDocuments.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemBuilder: (context, index) {
                                final document =
                                    profile.personalDocuments[index];
                                return Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: document.url != null
                                            ? Image.network(
                                                profile.personalDocuments[index]
                                                    .url,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                "assets/images/no_image.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          profile
                                              .personalDocuments[index].title,
                                          textAlign: TextAlign.center,
                                          style: AppTextTheme.generalStyle
                                              .copyWith(
                                            color: AppColors.textColor,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                        ],
                      ),
                    )
                  ],
                );
              }
              return Container(
                  height: SizeConfig.screenHeight,
                  alignment: Alignment.center,
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
        ),
      ),
    );
  }

  Widget _profileItem({String value, String title}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: AppTextTheme.generalStyle.copyWith(
              color: AppColors.grayColor,
            ),
          ),
          subtitle: Text(
            value,
            style:
                AppTextTheme.generalStyle.copyWith(color: AppColors.textColor),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 1.0,
      color: AppColors.grayColor,
    );
  }
}
