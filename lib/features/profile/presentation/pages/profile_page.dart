import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/core/blocs/gender_cubit.dart';
import 'package:sifaris_app/core/blocs/organization_cubit/organization_cubit.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:sifaris_app/features/profile/data/local_profile_model.dart';
import 'package:sifaris_app/features/profile/presentation/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:sifaris_app/features/profile/presentation/blocs/profile_toggle/profile_toggle_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sifaris_app/injection.dart';

import '../../../../injection_container.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEdit = false;
  final _localAuthSource = getIt<ProfileLocalDataSource>();
  LocalProfileModel localProfileModel;

  @override
  void initState() {
    super.initState();
    getLocalProfile();
  }

  void getLocalProfile() async {
    localProfileModel = await _localAuthSource.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ProfileEditBloc(),
        child: SingleChildScrollView(
          child: SafeArea(
            // child: BlocConsumer<ProfileToggleCubit, ProfileToggleState>(
            //   listener: (context, state) {
            //     if (state.isEdit) {
            //       _isEdit = true;
            //     } else if (state.isView) {
            //       _isEdit = false;
            //     }
            //   },
            //   builder: (context, state) {
            //     return _isEdit
            //         ? EditPage()
            //         : ViewPage(
            //             profileModel: localProfileModel,
            //           );
            //   },
            // ),
            child: ViewPage(),
          ),
        ),
      ),
    );
  }
}

class ViewPage extends StatelessWidget {
  const ViewPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenHeight * 0.4,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
              Expanded(
                flex: 0,
                child: Container(
                  height: 50.0,
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
                      // GestureDetector(
                      //   onTap: () {
                      //     context.read<ProfileToggleCubit>()
                      //       ..toggle(isEdidt: true);
                      //   },
                      //   child: Container(
                      //     padding:
                      //         EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      //     decoration: BoxDecoration(
                      //         color: AppColors.primaryRed,
                      //         borderRadius: BorderRadius.circular(20.0)),
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           Icons.edit,
                      //           color: AppColors.white,
                      //         ),
                      //         SizedBox(width: 5.0),
                      //         Text(
                      //           "Edit",
                      //           style: AppTextTheme.generalStyle.copyWith(),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                              "https://thumbs.dreamstime.com/b/handsome-man-black-suit-white-shirt-posing-studio-attractive-guy-fashion-hairstyle-confident-man-short-beard-125019349.jpg"),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "Hello",
                            style: AppTextTheme.titleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 2.0),
                          decoration: BoxDecoration(
                              color: Color(0xFF00A928),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            "प्रमाणित",
                            style: AppTextTheme.generalStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.32),
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog();
                            });
                      },
                      child: ListTile(
                        title: Text(
                          "ईमेल",
                          style: AppTextTheme.generalStyle.copyWith(
                            color: AppColors.grayColor,
                          ),
                        ),
                        subtitle: Text(
                          "mmanojrai@gmail.com",
                          style: AppTextTheme.generalStyle
                              .copyWith(color: AppColors.textColor),
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 1.0,
                      color: AppColors.grayColor,
                    ),
                    ListTile(
                      title: Text(
                        "फोन नम्बर",
                        style: AppTextTheme.generalStyle.copyWith(
                          color: AppColors.grayColor,
                        ),
                      ),
                      subtitle: Text(
                        "9813846576",
                        style: AppTextTheme.generalStyle
                            .copyWith(color: AppColors.textColor),
                      ),
                    ),
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
                    ListTile(
                      title: Text(
                        "ठेगाना",
                        style: AppTextTheme.generalStyle.copyWith(
                          color: AppColors.grayColor,
                        ),
                      ),
                      subtitle: Text(
                        "Bagmati",
                        style: AppTextTheme.generalStyle
                            .copyWith(color: AppColors.textColor),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 1.0,
                      color: AppColors.grayColor,
                    ),
                    ListTile(
                      title: Text(
                        "गा.पा. । न.पा.",
                        style: AppTextTheme.generalStyle.copyWith(
                          color: AppColors.grayColor,
                        ),
                      ),
                      subtitle: Text(
                        "Makwanpurgadhi",
                        style: AppTextTheme.generalStyle
                            .copyWith(color: AppColors.textColor),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 1.0,
                      color: AppColors.grayColor,
                    ),
                    ListTile(
                      title: Text(
                        "वार्ड",
                        style: AppTextTheme.generalStyle.copyWith(
                          color: AppColors.grayColor,
                        ),
                      ),
                      subtitle: Text(
                        "वार्ड नं १",
                        style: AppTextTheme.generalStyle
                            .copyWith(color: AppColors.textColor),
                      ),
                    ),
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
                    title: Text(
                      "पुरुष",
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                  "https://thehimalayantimes.com/uploads/imported_images/wp-content/uploads/2018/11/Citizenship.jpg"),
                            )),
                        Text("अगाडि")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                  "https://thehimalayantimes.com/uploads/imported_images/wp-content/uploads/2018/11/Citizenship.jpg"),
                            )),
                        Text("पछाडि")
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class EditPage extends StatefulWidget {
  const EditPage({
    Key key,
  }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String email, phone, genderValue, ward;
  TextEditingController _emailController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _wardController = TextEditingController();
  @override
  void initState() {
    super.initState();

    email = "Rajan@gmail.com";
    phone = "9869570678";
    ward = "१";
    genderValue = "Female";

    _emailController.text = email;
    _phoneController.text = phone;
    _wardController.text = ward;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileEditBloc(),
      child: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.4,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                      GestureDetector(
                        onTap: () {
                          context.read<ProfileToggleCubit>()
                            ..toggle(isEdidt: false);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              color: AppColors.primaryRed,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                "Done",
                                style: AppTextTheme.generalStyle.copyWith(),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                              "https://thumbs.dreamstime.com/b/handsome-man-black-suit-white-shirt-posing-studio-attractive-guy-fashion-hairstyle-confident-man-short-beard-125019349.jpg"),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 25.0,
                            width: 25.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.grayColor,
                            ),
                            child: Icon(
                              Icons.cancel,
                              color: AppColors.whiteGrayColor,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grayColor,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 1.0,
                                )),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rajan Karki",
                            style: AppTextTheme.titleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF00A928),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "प्रमाणित",
                        style: AppTextTheme.generalStyle,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.33),
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) => _emailDialog());
                        },
                        child: ListTile(
                          title: Text(
                            "ईमेल",
                            style: AppTextTheme.generalStyle.copyWith(
                              color: AppColors.grayColor,
                            ),
                          ),
                          subtitle: Text(
                            email,
                            style: AppTextTheme.generalStyle
                                .copyWith(color: AppColors.textColor),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 1.0,
                        color: AppColors.grayColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) => _phoneDialog());
                        },
                        child: ListTile(
                          title: Text(
                            "फोन नम्बर",
                            style: AppTextTheme.generalStyle.copyWith(
                              color: AppColors.grayColor,
                            ),
                          ),
                          subtitle: Text(
                            phone,
                            style: AppTextTheme.generalStyle
                                .copyWith(color: AppColors.textColor),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ),
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
                      ListTile(
                        title: Text(
                          "ठेगाना",
                          style: AppTextTheme.generalStyle.copyWith(
                            color: AppColors.grayColor,
                          ),
                        ),
                        subtitle: Text(
                          "Bagmati",
                          style: AppTextTheme.generalStyle
                              .copyWith(color: AppColors.textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 1.0,
                        color: AppColors.grayColor,
                      ),
                      ListTile(
                        title: Text(
                          "गा.पा. । न.पा.",
                          style: AppTextTheme.generalStyle.copyWith(
                            color: AppColors.grayColor,
                          ),
                        ),
                        subtitle: Text(
                          "Makwanpurgadhi",
                          style: AppTextTheme.generalStyle
                              .copyWith(color: AppColors.textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 1.0,
                        color: AppColors.grayColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) => _wardDialog());
                        },
                        child: ListTile(
                          title: Text(
                            "वार्ड",
                            style: AppTextTheme.generalStyle.copyWith(
                              color: AppColors.grayColor,
                            ),
                          ),
                          subtitle: Text(
                            "वार्ड नं  $ward",
                            style: AppTextTheme.generalStyle
                                .copyWith(color: AppColors.textColor),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ),
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
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) => _genderDialog());
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: 50.0,
                    alignment: Alignment.centerLeft,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        color: AppColors.whiteGrayColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      title: Text(
                        genderValue,
                        style: AppTextTheme.generalStyle
                            .copyWith(color: AppColors.textColor),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ),
                ),

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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                        "https://thehimalayantimes.com/uploads/imported_images/wp-content/uploads/2018/11/Citizenship.jpg"),
                                  )),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.grayColor,
                                          blurRadius: 2,
                                          spreadRadius: 1,
                                          offset: Offset(0, 1),
                                        )
                                      ]),
                                  child: Icon(
                                    FontAwesomeIcons.times,
                                    color: AppColors.grayColor,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.blueColor,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 1.0,
                                      )),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppColors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text("अगाडि")
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                        "https://thehimalayantimes.com/uploads/imported_images/wp-content/uploads/2018/11/Citizenship.jpg"),
                                  )),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.grayColor,
                                          blurRadius: 2,
                                          spreadRadius: 1,
                                          offset: Offset(0, 1),
                                        )
                                      ]),
                                  child: Icon(
                                    FontAwesomeIcons.times,
                                    color: AppColors.grayColor,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.blueColor,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 1.0,
                                      )),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppColors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text("पछाडि")
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _emailDialog() {
    return BlocProvider(
        create: (_) => ProfileEditBloc(),
        child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
          listener: (context, state) {
            if (state is ProfileEmailEdit) {
              setState(() {
                email = state.email;
              });
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 15,
                        left: 20,
                        right: 20,
                      ),
                      margin: EdgeInsets.only(top: 20.0, right: 5.0),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            // initialValue: "example@gmail.com",
                            autofocus: true,
                            decoration: InputTheme.getFormField(
                              hintText: "ईमेल",
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<ProfileEditBloc>()
                                ..add(ProfileEmailEditEvent(
                                    value: _emailController.text));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text('परिवर्तन गर्नुहोस्',
                                  style: AppTextTheme.generalStyle),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grayColor,
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                )
                              ]),
                          child: Icon(
                            FontAwesomeIcons.times,
                            size: 20.0,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ));
  }

  Widget _phoneDialog() {
    return BlocProvider(
        create: (_) => ProfileEditBloc(),
        child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
          listener: (context, state) {
            if (state is ProfilePhoneEdit) {
              setState(() {
                phone = state.phone;
              });
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 15,
                        left: 20,
                        right: 20,
                      ),
                      margin: EdgeInsets.only(top: 20.0, right: 5.0),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            controller: _phoneController,
                            // initialValue: "example@gmail.com",
                            autofocus: true,
                            decoration: InputTheme.getFormField(
                              hintText: "फोन नम्बर",
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<ProfileEditBloc>()
                                ..add(ProfilePhoneEditEvent(
                                    value: _phoneController.text));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text('परिवर्तन गर्नुहोस्',
                                  style: AppTextTheme.generalStyle),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grayColor,
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                )
                              ]),
                          child: Icon(
                            FontAwesomeIcons.times,
                            size: 20.0,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ));
  }

  Widget _wardDialog() {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProfileEditBloc(),
          ),
          BlocProvider(
            create: (_) => sl<OrganizationCubit>()..loadDepartments(),
          ),
        ],
        child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
          listener: (context, state) {
            if (state is ProfileWardEdit) {
              setState(() {
                ward = state.ward;
              });
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 15,
                        left: 20,
                        right: 20,
                      ),
                      margin: EdgeInsets.only(top: 20.0, right: 5.0),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BlocBuilder<OrganizationCubit, OrganizationState>(
                            builder: (context, state) {
                              return state.departments != null
                                  ? DropdownButtonFormField(
                                      value:
                                          state.departments[0].name.toString(),
                                      items: state.departments
                                          .map((e) => DropdownMenuItem(
                                              value: e.name.toString(),
                                              child:
                                                  Text("वार्ड नं ${e.name}")))
                                          .toList(),
                                      onSaved: (value) {
                                        // print("depa value $value");
                                        // formData['department_id'] = value;
                                      },
                                      onChanged: (value) {
                                        ward = value;
                                      },
                                      decoration: InputTheme.getFormField(
                                          hintText: 'वार्ड नम्बर'),
                                    )
                                  : CircularProgressIndicator();
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<ProfileEditBloc>()
                                ..add(ProfileWardEditEvent(value: ward));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text('परिवर्तन गर्नुहोस्',
                                  style: AppTextTheme.generalStyle),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grayColor,
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                )
                              ]),
                          child: Icon(
                            FontAwesomeIcons.times,
                            size: 20.0,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ));
  }

  Widget _genderDialog() {
    return BlocProvider(
        create: (_) => ProfileEditBloc(),
        child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
          listener: (context, state) {
            if (state is ProfileGenderEdit) {
              setState(() {
                genderValue = state.gender;
              });
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return BlocProvider(
              create: (context) => GenderCubit()..init(value: genderValue),
              child: BlocListener<GenderCubit, String>(
                listener: (context, state) {
                  genderValue = state;
                },
                child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.all(20.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 30,
                            bottom: 15,
                            left: 20,
                            right: 20,
                          ),
                          margin: EdgeInsets.only(top: 20.0, right: 5.0),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BlocBuilder<GenderCubit, String>(
                                buildWhen: (previous, current) =>
                                    current != previous,
                                builder: (context, state) {
                                  genderValue = state;
                                  return Container(
                                    decoration:
                                        InputTheme.getInputBoxDecoration(),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text("पुरुष",
                                              style: AppTextTheme.normalStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.blueColor)),
                                          trailing: Radio(
                                            value: "पुरुष",
                                            onChanged: (value) {
                                              context.read<GenderCubit>()
                                                ..changeGender(value: "पुरुष");
                                            },
                                            groupValue: genderValue,
                                            activeColor: AppColors.blueColor,
                                          ),
                                        ),
                                        Divider(),
                                        ListTile(
                                          title: Text("महिला",
                                              style: AppTextTheme.normalStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.blueColor)),
                                          trailing: Radio(
                                            value: "महिला",
                                            onChanged: (value) {
                                              context.read<GenderCubit>()
                                                ..changeGender(value: "महिला");
                                            },
                                            groupValue: genderValue,
                                            activeColor: AppColors.blueColor,
                                          ),
                                        ),
                                        Divider(),
                                        ListTile(
                                          title: Text("अन्य",
                                              style: AppTextTheme.normalStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.blueColor)),
                                          trailing: Radio(
                                            value: "अन्य",
                                            onChanged: (value) {
                                              context.read<GenderCubit>()
                                                ..changeGender(value: "अन्य");
                                            },
                                            groupValue: genderValue,
                                            activeColor: AppColors.blueColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<ProfileEditBloc>(context)
                                    ..add(ProfileGenderEditEvent(
                                        value: genderValue));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.blueColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text('परिवर्तन गर्नुहोस्',
                                      style: AppTextTheme.generalStyle),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 8,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.grayColor,
                                      offset: Offset(0, 1),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Icon(
                                FontAwesomeIcons.times,
                                size: 20.0,
                                color: AppColors.blueColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          },
        ));
  }
}
