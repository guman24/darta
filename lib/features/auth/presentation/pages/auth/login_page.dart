import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/core/blocs/password_toggle_bloc.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/custom_scaffold_messenger.dart';
import 'package:sifaris_app/core/utils/custom_widget.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';

import 'package:sifaris_app/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/forgot_password_page.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/register_page.dart';
import 'package:sifaris_app/injection_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, dynamic> formData = Map();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  PasswordToggleBloc passwordToggleBloc;

  @override
  void initState() {
    super.initState();
    passwordToggleBloc = PasswordToggleBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(loginUseCase: sl(), fcm: sl()),
      child: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: topContainer(),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.32),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      constraints: BoxConstraints(
                        // minHeight: SizeConfig.screenHeight * 0.6,
                        maxHeight: SizeConfig.screenHeight * 0.7,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0))),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "साईन ईन",
                                  style: AppTextTheme.titleStyle.copyWith(
                                    color: AppColors.blueColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 5.0),
                                child: TextFormField(
                                    controller: _emailController,
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.emailAddress,
                                    style: AppTextTheme.normalStyle.copyWith(
                                      color: Colors.black,
                                    ),
                                    decoration: InputTheme.getFormField(
                                        hintText: "ईमेल",
                                        icon: Icon(Icons.person))),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 5.0),
                                child: StreamBuilder(
                                    stream: passwordToggleBloc
                                        .stateVisibilityStream,
                                    initialData: false,
                                    builder: (context, snapshot) {
                                      return TextFormField(
                                          style:
                                              AppTextTheme.normalStyle.copyWith(
                                            color: Colors.black,
                                          ),
                                          obscureText: !snapshot.data,
                                          controller: _passwordController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
                                                  icon: Icon(
                                                      Icons.vpn_key_rounded))
                                              .copyWith(
                                                  suffixIcon: IconButton(
                                                      icon: Icon(snapshot
                                                                  .data ==
                                                              true
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off),
                                                      onPressed: () {
                                                        passwordToggleBloc
                                                            .eventVisibilitySink
                                                            .add("Toggle");
                                                      })));
                                    }),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginLoading) {
                                    return showCustomSnack(
                                        type: SnackBarMessegeType.PROGRESS
                                            .toString(),
                                        messege:
                                            "प्रतीक्षा गर्नुहोस् लगइन हुँदैछ... ",
                                        context: context);
                                  }
                                  if (state is LoginSuccess) {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    context.read<AuthCubit>()..loggedIn();
                                  }
                                  if (state is LoginFail) {
                                    return showCustomSnack(
                                        type: SnackBarMessegeType.ERROR
                                            .toString(),
                                        messege: state.message,
                                        context: context);
                                  }
                                },
                                builder: (context, state) {
                                  return GestureDetector(
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          Map<String, dynamic> formData = Map();
                                          formData['email'] =
                                              _emailController.text;
                                          formData['password'] =
                                              _passwordController.text;
                                          context.read<LoginBloc>()
                                            ..add(PerformLogin(data: formData));
                                        } else {
                                          return showCustomSnack(
                                              context: context,
                                              type: SnackBarMessegeType.ERROR
                                                  .toString(),
                                              messege:
                                                  "सबै जानकारी अनिवार्य छ ।");
                                        }
                                      },
                                      child:
                                          customSolidButton(title: "साईन ईन"));
                                },
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ForgotPasswordPage()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Text(
                                    "पासवर्ड विर्सनुभयो?",
                                    style: AppTextTheme.normalStyle.copyWith(
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => RegisterPage()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "खाता छैन?",
                                        style:
                                            AppTextTheme.normalStyle.copyWith(
                                          color: AppColors.grayColor,
                                        )),
                                    TextSpan(
                                        text: " खाता खोल्नुहोस्",
                                        style:
                                            AppTextTheme.normalStyle.copyWith(
                                          color: AppColors.blueColor,
                                        )),
                                  ])),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // child: Form(
      //   key: _formKey,
      //   child: Column(
      //     children: [
      //       TextFormField(
      //         autovalidateMode: AutovalidateMode.onUserInteraction,
      //         validator: (value) {
      //           if (value.isEmpty) {
      //             return "Required";
      //           }
      //           return null;
      //         },
      //         onSaved: (value) {
      //           formData["email"] = value;
      //         },
      //         decoration: InputDecoration(hintText: "Email"),
      //       ),
      //       TextFormField(
      //         autovalidateMode: AutovalidateMode.onUserInteraction,
      //         validator: (value) {
      //           if (value.isEmpty) {
      //             return "Required";
      //           }
      //           return null;
      //         },
      //         onSaved: (value) {
      //           formData["password"] = value;
      //         },
      //         decoration: InputDecoration(hintText: "Password"),
      //       ),
      //       BlocConsumer<LoginBloc, LoginState>(

      //         builder: (context, state) {
      //           return MaterialButton(
      //             color: Colors.blue,
      //             onPressed: () {
      //               if (_formKey.currentState.validate()) {
      //                 _formKey.currentState.save();
      //                 context.read<LoginBloc>()
      //                   ..add(PerformLogin(data: formData));
      //               }
      //             },
      //             child: Text("Login"),
      //           );
      //         },
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
