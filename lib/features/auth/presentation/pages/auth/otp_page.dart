import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/custom_scaffold_messenger.dart';
import 'package:sifaris_app/core/utils/custom_widget.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/login_page.dart';

import '../../../../../injection_container.dart';

class OtpPage extends StatefulWidget {
  final Map<String, dynamic> otpFormData;
  const OtpPage({
    Key key,
    @required this.otpFormData,
  }) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  Map<String, dynamic> data = Map();
  final GlobalKey<FormState> _otpFormKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    data['otp'] = widget.otpFormData['otp_code'] ?? "";
    data['user_id'] = widget.otpFormData['id'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterBloc>(),
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterVerifyOtpLoading) {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Row(
              //   children: [CircularProgressIndicator(), Text("Loading")],
              // )));
              showCustomSnack(
                  context: context,
                  type: SnackBarMessegeType.PROGRESS.toString(),
                  messege: "otp प्रमाणिकरण  हुँदैछ");
            }
            if (state is RegisterVerifyOtpFail) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              showCustomSnack(
                  context: context,
                  type: SnackBarMessegeType.ERROR.toString(),
                  messege: state.failure.props.single);
            }
            if (state is RegisterVerifyOtp) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              showCustomSnack(
                  context: context,
                  type: SnackBarMessegeType.INFO.toString(),
                  messege: state.message);
              Future.delayed(Duration(seconds: 2));
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            }
          },
          child: Container(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: topContainer(),
                ),
                Positioned(
                    top: SizeConfig.screenHeight * 0.36,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: SizeConfig.screenHeight * 0.64,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0))),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "प्रमाणिकरण",
                              style: AppTextTheme.titleStyle.copyWith(
                                color: AppColors.blueColor,
                              ),
                            ),
                          ),
                          Positioned(
                            top: SizeConfig.screenHeight * 0.08,
                            child: Container(
                              height: 40.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: AppColors.grayColor.withOpacity(0.35),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: AppColors.blueColor,
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text(
                                        "0:30s",
                                        style:
                                            AppTextTheme.generalStyle.copyWith(
                                          color: AppColors.blueColor,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: SizeConfig.screenHeight * 0.15,
                            left: 0,
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 50.0),
                              child: Form(
                                child: Column(
                                  children: [
                                    Text(
                                      data['otp'] ?? "",
                                      style: AppTextTheme.titleStyle.copyWith(
                                        color: AppColors.blueColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "अंकको कोड तपाईको उपकरणमा पठाइएको छ",
                                      style:
                                          AppTextTheme.subtitleStyle.copyWith(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Form(
                                      key: _otpFormKey,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "कोड अनिवार्य छ ।";
                                          } else if (value.length != 6) {
                                            return "कोडको ढाँचा मिलेन";
                                          }
                                          return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: _otpController,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        decoration: InputTheme.getFormField(
                                            hintText: "यहाँ कोड लेख्नुहोस्"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40.0,
                                    ),
                                    BlocBuilder<RegisterBloc, RegisterState>(
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (_otpFormKey.currentState
                                                .validate()) {
                                              Map<String, dynamic> _data = {
                                                "otp": _otpController.text,
                                                'user_id': data['user_id']
                                              };
                                              context.read<RegisterBloc>()
                                                ..add(PerformOtpVerification(
                                                    verifyData: _data));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Row(
                                                children: [
                                                  Icon(
                                                    Icons.error,
                                                    color: AppColors.primaryRed,
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text("कोड अनिवार्य छ ।")
                                                ],
                                              )));
                                            }
                                          },
                                          child: customSolidButton(
                                              title: "बुझाउनुहोस्"),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        "फेरि पठाउनुहोस्",
                                        style: AppTextTheme.generalStyle
                                            .copyWith(
                                                color: AppColors.blueColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
