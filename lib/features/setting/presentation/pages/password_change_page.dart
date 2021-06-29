import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/back_button.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/custom_scaffold_messenger.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:sifaris_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:sifaris_app/features/dashboard/presentation/pages/home_page.dart';
import 'package:sifaris_app/injection.dart';

class PasswordChangePage extends StatefulWidget {
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final _passwordController = TextEditingController();

  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChangePasswordBloc>(),
      child: Scaffold(
        body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              showCustomSnack(
                  context: context,
                  type: SnackBarMessegeType.INFO.toString(),
                  messege: state.successMessage);
              Future.delayed(Duration(seconds: 1));
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => DashBoardPage()));
            } else if (state is ChangePasswordFailure) {
              showCustomSnack(
                  context: context,
                  type: SnackBarMessegeType.ERROR.toString(),
                  messege: state.failMessage);
            } else if (state is ChangePasswordLoading) {
              showCustomSnack(
                  context: context,
                  type: SnackBarMessegeType.PROGRESS.toString(),
                  messege: LOADING_MESSAGE);
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.15,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      AppColors.blueColor,
                      AppColors.primaryRed,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: CustomBackButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.1),
                  constraints:
                      BoxConstraints(maxHeight: SizeConfig.screenHeight),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: SizeConfig.screenHeight * 0.8,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              )),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Text(
                                    "पासवर्ड परिवर्तन गर्नुहोस्",
                                    style: AppTextTheme.subtitleStyle.copyWith(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "पासवर्ड अनिवार्य छ";
                                        } else if (value.length < 6) {
                                          return "पासवर्ड ६ अङ्क भन्दा अधिक हुनुपर्छ";
                                        }
                                        return null;
                                      },
                                      decoration: InputTheme.getFormField(
                                          hintText: "हालको पासवर्ड"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: TextFormField(
                                      controller: _newPasswordController,
                                      obscureText: true,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "पासवर्ड अनिवार्य छ";
                                        } else if (value.length < 6) {
                                          return "पासवर्ड ६ अङ्क भन्दा अधिक हुनुपर्छ";
                                        }
                                        return null;
                                      },
                                      decoration: InputTheme.getFormField(
                                          hintText: "नयाँ पासवर्ड"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: true,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "पासवर्ड अनिवार्य छ";
                                        } else if (value !=
                                            _newPasswordController.text) {
                                          return "पासवर्ड मिलेन्";
                                        }
                                        return null;
                                      },
                                      decoration: InputTheme.getFormField(
                                          hintText: "फेरी पासवर्ड"),
                                    ),
                                  ),
                                ),
                                BlocBuilder<ChangePasswordBloc,
                                    ChangePasswordState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          context
                                              .read<ChangePasswordBloc>()
                                              .add(ChangePassword(
                                                  currentPassword:
                                                      _passwordController.text,
                                                  password:
                                                      _newPasswordController
                                                          .text,
                                                  confirmPassword:
                                                      _confirmPasswordController
                                                          .text));
                                        }
                                      },
                                      child: Container(
                                        child: customSolidButton(
                                            title: "परिवर्तन गर्नुहोस्"),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
