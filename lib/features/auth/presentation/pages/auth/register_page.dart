import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sifaris_app/core/blocs/gender_cubit.dart';
import 'package:sifaris_app/core/blocs/organization_cubit/organization_cubit.dart';
import 'package:sifaris_app/core/blocs/password_toggle_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/custom_radio.dart';
import 'package:sifaris_app/core/utils/custom_scaffold_messenger.dart';
import 'package:sifaris_app/core/utils/custom_widget.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/user_type_toggle.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/login_page.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/otp_page.dart';
import 'package:sifaris_app/injection.dart';
import 'package:sifaris_app/injection_container.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GenderCubit()),
        BlocProvider(
          create: (_) => UserTypeToggleCubit(),
        ),
        BlocProvider(create: (_) => sl<OrganizationCubit>()..loadDepartments()),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            topContainer(),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.36,
              ),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "साइन अप",
                        style: AppTextTheme.titleStyle.copyWith(
                          color: AppColors.blueColor,
                        ),
                      ),
                    ),
                    BlocProvider(
                        create: (_) => RegisterBloc(
                              signupUseCase: sl(),
                              otpVerifyUseCase: sl(),
                            ),
                        // create: (_) => getIt<RegisterBloc>(),
                        child: RegisterStepper()),
                    // SizedBox(
                    //   height: SizeConfig.screenHeight * 0.05,
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "खाता छ? ",
                              style: AppTextTheme.normalStyle.copyWith(
                                color: AppColors.grayColor,
                              )),
                          TextSpan(
                              text: "प्रवेश गर्नुहोस्",
                              style: AppTextTheme.normalStyle.copyWith(
                                color: AppColors.blueColor,
                              ))
                        ])),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterStepper extends StatefulWidget {
  @override
  _RegisterStepperState createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  int _currentIndex = 0;
  String userType = "";
  String userGender;
  TextEditingController _firstNameController = TextEditingController();

  TextEditingController _middleNameController = TextEditingController();
  TextEditingController __castController = TextEditingController();
  TextEditingController __emailController = TextEditingController();
  TextEditingController __phoneController = TextEditingController();
  TextEditingController _citizenshipNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _nameFormKey = GlobalKey();
  GlobalKey<FormState> _emailFormKey = GlobalKey();
  GlobalKey<FormState> _citizenWardFormKey = GlobalKey();
  GlobalKey<FormState> _passwordFormKey = GlobalKey();

  PasswordToggleBloc passwordToggleBloc;
  PasswordToggleBloc confirmPasswordToggleBloc;

  final Map<String, dynamic> formData = Map();

  void onNextPage() {
    if (_currentIndex < 5) {
      setState(() {
        _currentIndex = _currentIndex + 1;
      });
    } else {
      context.read<RegisterBloc>()..add(PerformRegister(formData: formData));
    }
  }

  void onPreviousPage() {
    setState(() {
      _currentIndex = _currentIndex - 1;
    });
  }

  void initState() {
    super.initState();
    passwordToggleBloc = PasswordToggleBloc();
    confirmPasswordToggleBloc = PasswordToggleBloc();
  }

  Widget userTypeWidget() {
    return Column(
      children: [
        Text(
          "तपाईको बासिन्दाको प्रकार छान्नुहोस्",
          style: AppTextTheme.normalStyle.copyWith(
            color: AppColors.black,
          ),
        ),
        BlocBuilder<UserTypeToggleCubit, String>(
          buildWhen: (previous, current) => current != previous,
          builder: (context, state) {
            userType = state;
            print("state $state => $userType");
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return _permanentDialog();
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: InputTheme.getInputBoxDecoration(),
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            size: 50.0,
                            color: AppColors.blueColor,
                          ),
                          Text(
                            "स्थाई",
                            style: AppTextTheme.normalStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return _tempDialog();
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      decoration: InputTheme.getInputBoxDecoration(),
                      child: Column(
                        children: [
                          Icon(
                            Icons.home_work,
                            size: 50.0,
                            color: AppColors.primaryRed,
                          ),
                          Text(
                            "अस्थायी",
                            style: AppTextTheme.normalStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.1,
        ),
      ],
    );
  }

  Widget _permanentDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: ListTile(
              title: Text(
                "तपाईको बसोबासको प्रकार स्थायी हो?",
                style: AppTextTheme.normalStyle.copyWith(
                  color: AppColors.textColor,
                ),
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: AppColors.primaryRed,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          "होईन",
                          style: AppTextTheme.generalStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        formData["address_type"] = "Permanent";
                        Navigator.pop(context);
                        onNextPage();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          "हो",
                          style: AppTextTheme.generalStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tempDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: ListTile(
              title: Text(
                "तपाईको बसोबासको प्रकार अस्थायी हो?",
                style: AppTextTheme.normalStyle.copyWith(
                  color: AppColors.textColor,
                ),
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: AppColors.primaryRed,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          "होईन",
                          style: AppTextTheme.generalStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        formData["address_type"] = "Temporary";
                        Navigator.pop(context);
                        onNextPage();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          "हो",
                          style: AppTextTheme.generalStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
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
      ),
    );
  }

  Widget nameWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      constraints: BoxConstraints(
        maxHeight: SizeConfig.screenHeight * 0.5,
      ),
      child: Form(
        key: _nameFormKey,
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: _firstNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "पहिलो नाम अनिवार्य छ ।";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  decoration: InputTheme.getFormField(hintText: "पहिलो नाम"),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: _middleNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  decoration: InputTheme.getFormField(hintText: "बीचको नाम"),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: __castController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "थर अनिवार्य छ ।";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  decoration: InputTheme.getFormField(hintText: "थर"),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: GestureDetector(
                  onTap: () {
                    if (_nameFormKey.currentState.validate()) {
                      formData['first_name'] = _firstNameController.text;
                      formData['last_name'] = __castController.text;
                      onNextPage();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: AppColors.primaryRed,
                          ),
                          Text("All Fields are required"),
                        ],
                      )));
                    }
                  },
                  child: customSolidButton(title: "अर्को")),
            ),
          ],
        ),
      ),
    );
  }

  Widget genderWidget() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "लिङ्ग छनौट गर्नुहोस्",
              style: AppTextTheme.normalStyle.copyWith(
                color: AppColors.black,
              ),
            ),
            BlocBuilder<GenderCubit, String>(
              buildWhen: (previous, current) => current != previous,
              builder: (context, state) {
                userGender = state;
                return Container(
                  decoration: InputTheme.getInputBoxDecoration(),
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.01),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CustomRadioButton(
                        label: "पुरुष",
                        value: "Male",
                        groupValue: state,
                        onTap: (value) => context.read<GenderCubit>()
                          ..changeGender(value: "Male"),
                      ),
                      Divider(),
                      CustomRadioButton(
                        label: "महिला",
                        value: "Female",
                        groupValue: state,
                        onTap: (value) => context.read<GenderCubit>()
                          ..changeGender(value: "Female"),
                      ),
                      Divider(),
                      CustomRadioButton(
                        label: "अन्य",
                        value: "Others",
                        groupValue: state,
                        onTap: (value) => context.read<GenderCubit>()
                          ..changeGender(value: "Others"),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            GestureDetector(
                onTap: () {
                  if (userGender != null) {
                    formData['gender'] = userGender;
                    onNextPage();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: AppColors.primaryRed,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("लिङ्ग छनौट अनिवार्य छ ।")
                      ],
                    )));
                  }
                },
                child: customSolidButton(title: "अर्को")),
          ],
        ));
  }

  Widget emailPhoneWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _emailFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: __emailController,
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
              decoration: InputTheme.getFormField(hintText: "ईमेल"),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: __phoneController,
              validator: (value) {
                if (value.isEmpty) {
                  return "फोन नम्बर अनिवार्य छ";
                } else if (value.length != 10) {
                  return "फोन नम्बर मिलेन";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              keyboardType: TextInputType.number,
              decoration: InputTheme.getFormField(hintText: "फोन नम्बर"),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
                onTap: () {
                  if (_emailFormKey.currentState.validate()) {
                    formData['email'] = __emailController.text;
                    formData['phone'] = __phoneController.text;
                    onNextPage();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: AppColors.primaryRed,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("सबै जानकारी अनिवार्य छ ।")
                      ],
                    )));
                  }
                },
                child: customSolidButton(title: "अर्को")),
          ],
        ),
      ),
    );
  }

  Widget citizenshipWardWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: BlocBuilder<OrganizationCubit, OrganizationState>(
        builder: (context, state) {
          return Form(
            key: _citizenWardFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _citizenshipNumberController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "नागरिकता नम्बर अनिवार्य छ";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                      InputTheme.getFormField(hintText: "नागरिकता नम्बर"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                state.departments != null
                    ? DropdownButtonFormField(
                        value: state.departments[0].id.toString(),
                        items: state.departments
                            .map((e) => DropdownMenuItem(
                                value: e.id.toString(), child: Text(e.name)))
                            .toList(),
                        onSaved: (value) {
                          print("depa value $value");
                          formData['department_id'] = value;
                        },
                        onChanged: (value) {},
                        decoration:
                            InputTheme.getFormField(hintText: 'वार्ड नम्बर'),
                      )
                    : CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      if (_citizenWardFormKey.currentState.validate()) {
                        _citizenWardFormKey.currentState.save();
                        formData['organization_id'] = state.organizationId;
                        formData['citizenship_number'] =
                            _citizenshipNumberController.text;
                        onNextPage();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: AppColors.primaryRed,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("सबै जानकारी अनिवार्य छ ।")
                          ],
                        )));
                      }
                    },
                    child: customSolidButton(title: "अर्को"))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget passwordWidget() {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => OtpPage(
                        otpFormData: state.response,
                      )));
        }
        if (state is RegisterLoading) {
          return showCustomSnack(
              type: "progress", messege: "Loading", context: context);
        }
        if (state is RegisterFail) {
          return showCustomSnack(
            context: context,
            type: "error",
            messege: state.failure.props.single,
          );
        }
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _passwordFormKey,
            child: Column(
              children: [
                StreamBuilder(
                    stream: passwordToggleBloc.stateVisibilityStream,
                    initialData: false,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: !snapshot.data,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "पासवर्ड अनिवार्य छ";
                          } else if (value.length < 6) {
                            return "पासवर्ड ६ अङ्क भन्दा अधिक हुनुपर्छ";
                          }
                          return null;
                        },
                        decoration: InputTheme.getFormField(
                          hintText: "पासवर्ड",
                        ).copyWith(
                            suffixIcon: IconButton(
                                icon: Icon(snapshot.data == true
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  passwordToggleBloc.eventVisibilitySink
                                      .add("Toggle");
                                })),
                      );
                    }),
                SizedBox(
                  height: 20.0,
                ),
                StreamBuilder(
                    stream: confirmPasswordToggleBloc.stateVisibilityStream,
                    initialData: false,
                    builder: (context, snapshot) {
                      return TextFormField(
                        obscureText: !snapshot.data,
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
                        decoration:
                            InputTheme.getFormField(hintText: "फेरी पासवर्ड")
                                .copyWith(
                                    suffixIcon: IconButton(
                                        icon: Icon(snapshot.data == true
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          confirmPasswordToggleBloc
                                              .eventVisibilitySink
                                              .add("Toggle");
                                        })),
                      );
                    }),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                    onTap: () {
                      if (_passwordFormKey.currentState.validate()) {
                        formData['password'] = _passwordController.text;
                        onNextPage();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: AppColors.primaryRed,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("सबै जानकारी अनिवार्य छ ।")
                          ],
                        )));
                      }
                    },
                    child: customSolidButton(title: "अर्को"))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return userTypeWidget();
        break;
      case 1:
        return nameWidget();
        break;
      case 2:
        return genderWidget();
        break;
      case 3:
        return emailPhoneWidget();
        break;
      case 4:
        return citizenshipWardWidget();
        break;
      case 5:
        return passwordWidget();
        break;
      default:
        return Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
    UserTypeToggleCubit().close();
  }
}
