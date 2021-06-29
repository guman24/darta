import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/blocs/count_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/email_cubit.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/enums.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/forgot_password_reset_cubit.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/otp_cubit.dart';
import 'package:sifaris_app/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:sifaris_app/injection.dart';

class ForgotPasswordWidgets {
  final Widget widget;

  ForgotPasswordWidgets({@required this.widget});
}

class FirstWidget extends StatefulWidget {
  @override
  _FirstWidgetState createState() => _FirstWidgetState();
}

class _FirstWidgetState extends State<FirstWidget> {
  var _selectedGender = CredentialType.PHONE;
  final _localProfileSource = getIt<ProfileLocalDataSource>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("खाता पुष्टि गर्नका लागि कोड कहाँ पठाउनु पर्छ?",
            style: AppTextTheme.generalStyle.copyWith(
              color: AppColors.textColor.withOpacity(0.6),
              fontSize: 16.0,
              height: 1.5,
              fontWeight: FontWeight.w800,
            )),
        Padding(
          padding: EdgeInsets.all(20.0),
          // child: Card(
          //   elevation: 4.0,
          //   margin: EdgeInsets.symmetric(horizontal: 20.0),
          //   child: FutureBuilder(
          //       future: _localProfileSource.getProfile(),
          //       builder: (context, snapshot) {
          //         return Column(
          //           children: [
          //             RadioListTile(
          //                 selected: _selectedGender == CredentialType.PHONE
          //                     ? true
          //                     : false,
          //                 activeColor: AppColors.blueColor,
          //                 title: Text("फोन मार्फत पुष्टि गर्नुहोस्"),
          //                 subtitle: Text("+**********78"),
          //                 value: CredentialType.PHONE,
          //                 groupValue: _selectedGender,
          //                 onChanged: (newValue) =>
          //                     setState(() => _selectedGender = newValue)),
          //             RadioListTile(
          //                 selected: _selectedGender == CredentialType.EMAIL
          //                     ? true
          //                     : false,
          //                 title: Text("ईमेल मार्फत पुष्टि गर्नुहोस्"),
          //                 subtitle: Text("aaron.willis@mail.com"),
          //                 value: CredentialType.EMAIL,
          //                 groupValue: _selectedGender,
          //                 onChanged: (newValue) =>
          //                     setState(() => _selectedGender = newValue)),
          //           ],
          //         );
          //       }),
          // )
          // ,
          child: SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: BlocBuilder<EmailCubit, String>(
              builder: (context, state) {
                return TextFormField(
                  validator: (value) {
                    String p =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    if (value.isEmpty) {
                      return "ईमेल अनिवार्य छ";
                    } else if (!RegExp(p).hasMatch(value)) {
                      return "ईमेलको ढाँचा मिलेन";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTextTheme.normalStyle.copyWith(
                    color: Colors.black,
                  ),
                  controller: _emailController,
                  decoration: InputTheme.getFormField(hintText: "Email"),
                  onChanged: (value) {
                    context.read<EmailCubit>()..emailValidate(value);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SecondWidget extends StatefulWidget {
  @override
  _SecondWidgetState createState() => _SecondWidgetState();
}

class _SecondWidgetState extends State<SecondWidget> {
  final _otpController = TextEditingController();
  final sharedPreferences = getIt<SharedPreferences>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Countdown(
          seconds: 30,
          interval: Duration(seconds: 1),
          build: (context, time) => Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: time == 0
                    ? AppColors.primaryRed.withOpacity(0.2)
                    : AppColors.primaryBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.watch_later,
                    color: time == 0
                        ? AppColors.primaryRed
                        : AppColors.primaryBlue,
                  ),
                  Text(
                    '0.${time.toInt().toString()} s',
                    style: TextStyle(
                      color: time == 0
                          ? AppColors.primaryRed
                          : AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )),
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "६ अंकको कोड तपाईको फोनमा पठाइएको छ",
              style: AppTextTheme.normalStyle.copyWith(
                color: AppColors.blueColor,
                fontSize: 16.0,
              ),
            )),
        SizedBox(
          width: SizeConfig.screenWidth * 0.7,
          child: BlocBuilder<OtpCubit, String>(
            builder: (context, state) {
              // _otpController.text =
              //     sharedPreferences.getString(FORGOT_PASSWORD_OTP);
              return TextFormField(
                controller: _otpController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return "कोड अनिवार्य छ";
                  } else if (value.length < 6) {
                    return "कोड ६ अङ्क हुनुपर्छ";
                  }
                  return null;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                ],
                onChanged: (value) {
                  context.read<OtpCubit>()..validateOtp(value);
                },
                decoration:
                    InputTheme.getFormField(hintText: "यहाँ कोड लेख्नुहोस्")
                        .copyWith(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0)),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text("फेरि पठाउनुहोस्",
                style: AppTextTheme.generalStyle.copyWith(
                  color: AppColors.blueColor,
                )),
          ),
        )
      ],
    );
  }
}

class ThirdWidget extends StatefulWidget {
  @override
  _ThirdWidgetState createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends State<ThirdWidget> {
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<ForgotPasswordResetCubit, Map<String, dynamic>>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "तपाईको पासवर्ड के राख्न चाहनुहुन्छ?",
                  style: AppTextTheme.normalStyle.copyWith(
                    color: AppColors.blueColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 8.0),
              //   child: SizedBox(
              //     width: SizeConfig.screenWidth * 0.7,
              //     child: TextFormField(
              //         controller: _currentPasswordController,
              //         autovalidateMode: AutovalidateMode.onUserInteraction,
              //         validator: (value) {
              //           if (value.isEmpty) {
              //             return "पासवर्ड अनिवार्य छ";
              //           } else if (value.length < 6) {
              //             return "पासवर्ड ६ अङ्क भन्दा अधिक हुनुपर्छ";
              //           }
              //           return null;
              //         },
              //         onChanged: (value) {
              //           // getIt<AuthLocalDataSource>()
              //           //     .saveForgotPassword(password: value);
              //         },
              //         decoration:
              //             InputTheme.getFormField(hintText: "अहिलेको पासवर्ड *")
              //                 .copyWith(
              //                     contentPadding: EdgeInsets.symmetric(
              //                         vertical: 0.0, horizontal: 10.0))),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: SizeConfig.screenWidth * 0.7,
                  child: TextFormField(
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "पासवर्ड अनिवार्य छ";
                        } else if (value.length < 6) {
                          return "पासवर्ड ६ अङ्क भन्दा अधिक हुनुपर्छ";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // getIt<AuthLocalDataSource>()
                        //     .saveForgotPassword(password: value);
                      },
                      decoration:
                          InputTheme.getFormField(hintText: "नयाँ पासवर्ड *")
                              .copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0))),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: SizeConfig.screenWidth * 0.7,
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "पासवर्ड अनिवार्य छ";
                      } else if (value.length < 6) {
                        return "पासवर्ड ६ अङ्क भन्दा अधिक हुनुपर्छ";
                      } else if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        return "पासवर्ड मिलेन्";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context
                          .read<ForgotPasswordResetCubit>()
                          .validatePassword(_passwordController.text, value);
                    },
                    decoration:
                        InputTheme.getFormField(hintText: "फेरी पासवर्ड *")
                            .copyWith(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0)),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

List<ForgotPasswordWidgets> widgets = [
  ForgotPasswordWidgets(widget: FirstWidget()),
  ForgotPasswordWidgets(widget: SecondWidget()),
  ForgotPasswordWidgets(widget: ThirdWidget())
];
