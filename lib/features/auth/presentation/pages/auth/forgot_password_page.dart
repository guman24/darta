import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/blocs/count_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/custom_scaffold_messenger.dart';
import 'package:sifaris_app/core/utils/custom_widget.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/email_cubit.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/forgot_password_reset_cubit.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/otp_cubit.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/password_reset/password_reset_bloc.dart';
import 'package:sifaris_app/features/auth/presentation/widgets/forgot_password_widget_model.dart';
import 'package:sifaris_app/injection.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  PageController _pageController = PageController();
  var _selectedIndex = 0;
  final authLocalDataSource = getIt<AuthLocalDataSource>();
  final sharePreference = getIt<SharedPreferences>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => OtpCubit()),
          BlocProvider(create: (_) => EmailCubit()),
          BlocProvider(lazy: false, create: (_) => ForgotPasswordResetCubit()),
          BlocProvider(create: (_) => getIt<PasswordResetBloc>())
        ],
        child: SafeArea(
          child: Stack(
            children: [
              topContainer(),
              BlocListener<PasswordResetBloc, PasswordResetState>(
                listener: (context, state) {
                  if (state is PasswordResetSendOtpLoading) {
                    showCustomSnack(
                        context: context,
                        type: SnackBarMessegeType.PROGRESS.toString(),
                        messege: "Loading..");
                  } else if (state is PasswordResetSentOtp) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    authLocalDataSource.saveForgotPasswordOtp(otp: state.otp);
                    _onNext();
                  } else if (state is PasswrodResetLoading) {
                    showCustomSnack(
                        context: context,
                        type: SnackBarMessegeType.PROGRESS.toString(),
                        messege: "Loading..");
                  } else if (state is PasswordResetSuccess) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    showCustomSnack(
                        context: context,
                        type: SnackBarMessegeType.INFO.toString(),
                        messege: state.successMessage);
                    Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                  } else if (state is PasswordResetFailure) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    showCustomSnack(
                        context: context,
                        type: SnackBarMessegeType.INFO.toString(),
                        messege: state.failMessage);
                  }
                },
                child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
                    builder: (context, state) {
                  return CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: SizeConfig.screenHeight * 0.6,
                          ),
                          margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.38,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              )),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    "खाताको पुष्टि",
                                    style: AppTextTheme.subtitleStyle
                                        .copyWith(color: AppColors.black),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: PageView.builder(
                                    controller: _pageController,
                                    physics: NeverScrollableScrollPhysics(),
                                    onPageChanged: (newIndex) => setState(
                                        () => _selectedIndex = newIndex),
                                    itemCount: widgets.length,
                                    itemBuilder: (context, index) {
                                      return widgets[index].widget;
                                    }),
                              ),
                              Expanded(
                                flex: 0,
                                child: _nextButton(
                                    context.read<PasswordResetBloc>()),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
              GestureDetector(
                onTap: () {
                  if (_selectedIndex == 0) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  height: 40.0,
                  width: 40.0,
                  margin: EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNext() {
    if (_selectedIndex < 2) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {}
  }

  Widget _nextButton(PasswordResetBloc bloc) {
    switch (_selectedIndex) {
      case 0:
        return BlocBuilder<EmailCubit, String>(
          builder: (context, email) {
            return GestureDetector(
                onTap: () async {
                  if (email == null) {
                    showCustomSnack(
                        context: context,
                        type: SnackBarMessegeType.ERROR.toString(),
                        messege: "Enter valid email");
                  }
                  bloc.add(ResetSendOtp(email: email));
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: customSolidButton(title: "अर्को")));
          },
        );
        break;
      case 1:
        return BlocBuilder<OtpCubit, String>(
          builder: (context, otp) {
            return GestureDetector(
                onTap: () async {
                  if (otp != null && otp.length == 6) {
                    _onNext();
                  } else {
                    showCustomSnack(
                        context: context,
                        type: SnackBarMessegeType.ERROR.toString(),
                        messege: "Enter Valid OTP");
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: customSolidButton(title: "अर्को")));
          },
        );
        break;
      case 2:
        return BlocBuilder<ForgotPasswordResetCubit, Map<String, dynamic>>(
          builder: (mContext, data) {
            return GestureDetector(
                onTap: () async {
                  if (data != null) {
                    bloc.add(ResetPassword(
                      email: 'rkk@gmail.com',
                      otp: sharePreference.getString(FORGOT_PASSWORD_OTP),
                      password: sharePreference.getString(NEW_PASSWORD),
                      confirmPassword:
                          sharePreference.getString(NEW_CONFIRM_PASSWORD),
                    ));
                  } else {
                    showCustomSnack(
                        context: context,
                        type: SnackBarMessegeType.ERROR.toString(),
                        messege: "Enter Correct Password");
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: customSolidButton(title: "अर्को")));
          },
        );
        break;
      default:
        return GestureDetector(
            onTap: () async {
              _onNext();
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: customSolidButton(title: "अर्को")));
    }
  }
}
