import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sifaris_app/core/blocs/image_picker/image_picker_bloc.dart';

import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/custom_scaffold_messenger.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';
import 'package:path/path.dart' as path;
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/navigate/navigate_cubit.dart';

import 'package:sifaris_app/features/paper/presentation/blocs/paper_create/papercreate_bloc.dart';
import 'package:sifaris_app/features/paper/presentation/blocs/paper_create/verification_user_data/get_verification_data_bloc.dart';
import 'package:sifaris_app/features/paper/presentation/pages/paper_preview_page.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';
import 'package:sifaris_app/injection.dart';

class PaperCreatePage extends StatefulWidget {
  final TemplateEntity templateEntity;
  const PaperCreatePage({
    Key key,
    @required this.templateEntity,
  }) : super(key: key);
  @override
  _PaperCreatePageState createState() => _PaperCreatePageState();
}

class _PaperCreatePageState extends State<PaperCreatePage> {
  UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<PaperCreateBloc>()),
              BlocProvider(
                  create: (_) => getIt<GetVerificationDataBloc>()
                    ..add(GetVerificationUserDataEvent())),
              BlocProvider(
                create: (_) => NavigateCubit(),
              ),
            ],
            child: BlocListener<NavigateCubit, NavigateState>(
              listener: (context, state) {
                if (state.index < 0) {
                  Navigator.pop(context);
                }
              },
              child: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          AppColors.blueColor,
                          AppColors.primaryRed,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.business,
                            size: 50.0,
                            color: AppColors.white,
                          ),
                          Text(
                            widget.templateEntity.title,
                            style: AppTextTheme.normalStyle,
                          )
                        ],
                      ),
                    ),
                    BlocBuilder<NavigateCubit, NavigateState>(
                      builder: (context, navState) {
                        return GestureDetector(
                          onTap: () {
                            context.read<NavigateCubit>()
                              ..onPreviousPage(value: navState.index);
                          },
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            margin: EdgeInsets.only(top: 10.0, left: 20.0),
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        );
                      },
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minHeight: SizeConfig.screenHeight,
                          minWidth: double.infinity,
                          maxHeight: double.infinity),
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      // child: BlocConsumer<PaperCreateBloc, PaperCreateState>(
                      //   listener: (context, state) {
                      //     print("****$state");
                      //     if (state is PaperRequstLoading) {
                      //       showCustomSnack(
                      //           context: context,
                      //           type: SnackBarMessegeType.PROGRESS.toString(),
                      //           messege: "Loading..");
                      //     }
                      //     if (state is PaperCreateRequestFail) {
                      //       showCustomSnack(
                      //           context: context,
                      //           type: SnackBarMessegeType.ERROR.toString(),
                      //           messege: state.failMessage);
                      //     }
                      //     if (state is PaperCreateRequestSuccess) {
                      //       showCustomSnack(
                      //           context: context,
                      //           type: SnackBarMessegeType.INFO.toString(),
                      //           messege: state.successMessage);
                      //       Future.delayed(Duration(seconds: 2));
                      //       Navigator.pushAndRemoveUntil(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (_) => PaperPreviewPage()),
                      //           (route) => false);
                      //     }

                      //     if (state is PaperCreateProfileFailedState) {
                      //       print("Fail state ");
                      //       showCustomSnack(
                      //           context: context,
                      //           type: "error",
                      //           messege: state.errorMessage);
                      //     }
                      //     if (state is PaperUserDetailLoadingState) {
                      //       return Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     }
                      //     if (state is PaperGetUserDetailState) {
                      //       user = state.profile;
                      //     }
                      //     if (state is PaperCreateProfileFailedState) {
                      //       return Text(state.errorMessage);
                      //     }
                      //   },
                      //   builder: (context, state) {
                      //     if (state is PaperGetUserDetailState) {
                      //       return PaperCreateStepper(
                      //         template: widget.templateEntity,
                      //         userEntity: user,
                      //       );
                      //     } else {
                      //       return Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     }
                      //   },
                      // ),
                      child: BlocBuilder<GetVerificationDataBloc,
                          GetVerificationDataState>(
                        builder: (context, state) {
                          if (state is GetVerificationDataSuccessState) {
                            UserEntity user = state.user;
                            return PaperCreateStepper(
                                template: widget.templateEntity,
                                userEntity: user);
                          }
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [CircularProgressIndicator()]);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaperCreateStepper extends StatefulWidget {
  final TemplateEntity template;
  final UserEntity userEntity;
  const PaperCreateStepper(
      {Key key, @required this.template, @required this.userEntity})
      : super(key: key);

  @override
  _PaperCreateStepperState createState() => _PaperCreateStepperState();
}

class _PaperCreateStepperState extends State<PaperCreateStepper> {
  TemplateEntity get template => widget.template;
  GlobalKey<FormState> _newAttributeKey = GlobalKey<FormState>();
  Map<String, dynamic> attributeFormData = Map();
  Map<String, dynamic> userData = Map();

  // List<String> paperDocs = [];

  List<DocumentEntity> documents = [];

  Widget _newAttributesWidget() {
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        switch (state.index) {
          case 0:
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Form(
                child: Column(
                  children: [
                    Text(
                      "थप जानकारी",
                      style: AppTextTheme.subtitleStyle.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Form(
                      key: _newAttributeKey,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: template.newAttributes.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "${widget.template.newAttributes[index]} अनिवार्य छ";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  attributeFormData[widget
                                      .template.newAttributes[index]] = value;
                                },
                                decoration: InputTheme.getFormField(
                                    hintText: template.newAttributes[index]),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (_newAttributeKey.currentState.validate()) {
                            _newAttributeKey.currentState.save();
                            context.read<NavigateCubit>()
                              ..onNextPage(value: state.index);
                          }
                        },
                        child: customSolidButton(title: "अर्को"))
                  ],
                ),
              ),
            );
            break;
          case 1:
            return _uploadFileWidget();
            break;
          default:
            return Container();
        }
      },
    );
  }

  Widget _uploadFileWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        children: [
          Text(
            "तस्वीर अपलोड गर्नुहोस्",
            style: AppTextTheme.subtitleStyle.copyWith(
              color: AppColors.blueColor,
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return BlocProvider(
                  create: (_) => ImagePickerBloc(),
                  child: BlocConsumer<ImagePickerBloc, ImagePickerState>(
                    listener: (context, state) {
                      if (state is ImagePickerSuccess) {
                        String dir = path.dirname(state.image.path);
                        String ext =
                            state.image.path.split('/').last.split('.').last;
                        String newUrl =
                            path.join(dir, "${documents[index].title}.$ext");
                        File f = File(state.image.path).copySync(newUrl);
                        documents[index].url = f.path;
                        // paperDocs.add(f.path);
                      }
                      if (state is ImagePickerEmpty) {
                        documents[index].url = null;

                        // paperDocs.removeWhere((element) =>
                        //     element.contains(documents[index].title));
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            documents[index].url == null
                                ? Container(
                                    height: SizeConfig.screenHeight * 0.13,
                                    width: SizeConfig.screenWidth * 0.5,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        pickImage(
                                            context: context,
                                            imagePickerBloc: context
                                                .read<ImagePickerBloc>());
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.solidImages,
                                            color: AppColors.blueColor,
                                            size: 40.0,
                                          ),
                                          Positioned(
                                            top: 30.0,
                                            right: 30.0,
                                            child: Icon(
                                              FontAwesomeIcons.plusCircle,
                                              color: AppColors.blueColor,
                                              size: 20.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    // child: Text("hello"),
                                    decoration:
                                        InputTheme.getInputBoxDecoration(),
                                  )
                                : Container(
                                    height: SizeConfig.screenHeight * 0.13,
                                    width: SizeConfig.screenWidth * 0.5,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 5.0),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          right: 2,
                                          bottom: 0,
                                          top: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: documents[index]
                                                      .url
                                                      .contains("http")
                                                  ? Image.network(
                                                      documents[index].url)
                                                  : Image.file(
                                                      File(
                                                          documents[index].url),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            right: 0,
                                            top: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                context.read<ImagePickerBloc>()
                                                  ..add(ImageDeleted());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(1.0),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.whiteGrayColor,
                                                  border: Border.all(
                                                      color: AppColors.white),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  FontAwesomeIcons.times,
                                                  size: 20.0,
                                                  color: AppColors.grayColor,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                            Text(
                              documents[index].title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppTextTheme.generalStyle.copyWith(
                                color: AppColors.textColor,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
          SizedBox(
            height: 20.0,
          ),
          BlocListener<PaperCreateBloc, PaperCreateState>(
            listener: (context, state) {
              if (state is PaperRequstLoading) {
                showCustomSnack(
                    context: context,
                    type: SnackBarMessegeType.PROGRESS.toString(),
                    messege: "Loading...");
              } else if (state is PaperCreateRequestSuccess) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                showCustomSnack(
                    context: context,
                    type: SnackBarMessegeType.INFO.toString(),
                    messege: state.successMessage);
                Future.delayed(Duration(seconds: 1));
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PaperPreviewPage(
                              templateEntity: template,
                            )),
                    (route) => true);
              } else if (state is PaperCreateRequestFail) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                showCustomSnack(
                    context: context,
                    type: SnackBarMessegeType.ERROR.toString(),
                    messege: state.failMessage);
              }
            },
            child: BlocBuilder<PaperCreateBloc, PaperCreateState>(
              builder: (context, state) {
                return GestureDetector(
                    onTap: () {
                      if (template.requiredDocuments.length ==
                          documents.length) {
                        userData['template_id'] = template.id;
                        BlocProvider.of<PaperCreateBloc>(context)
                          ..add(PaperCreateRequestEvent(
                            newAttributes: attributeFormData,
                            documents: documents,
                            data: userData,
                          ));
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(builder: (_) => PaperPreviewPage()),
                        //     (route) => true);
                      } else {
                        showCustomSnack(
                            context: context,
                            type: "error",
                            messege: "तस्वीर अनिवार्य छ ।");
                      }
                    },
                    child: customSolidButton(title: "बुझाउनुहोस्"));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDocs();
    _getUserData();
  }

  void getDocs() {
    template.requiredDocuments.forEach((doc) {
      documents.add(DocumentEntity(title: doc, url: null));
    });
    documents.forEach((element) {
      widget.userEntity.personalDocs.forEach((file) {
        if (file.title == element.title && file.url != null) {
          documents[documents
              .indexWhere((element) => element.title == file.title)] = file;
        }
      });
    });
  }

  void _getUserData() {
    if (widget.userEntity != null) {
      Map<String, dynamic> user = widget.userEntity.anotherToMap();
      template.applicant.forEach((data) {
        userData[data] = user['$data'];
      });
    } else {
      userData = Map();
    }
  }

  void loadDocs() {
    documents.forEach((doc) {
      widget.userEntity.personalDocs.forEach((element) {
        // ignore: unrelated_type_equality_checks
        if (doc == element.title) {
          if (element.url != null) {
            doc.url = element.url;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaperCreateBloc, PaperCreateState>(
      builder: (context, state) {
        return template.newAttributes.isNotEmpty
            ? _newAttributesWidget()
            : _uploadFileWidget();
      },
    );
  }

  void pickImage({BuildContext context, ImagePickerBloc imagePickerBloc}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10.0),
                ),
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.photo,
                    color: AppColors.blueColor.withOpacity(0.6),
                  ),
                  title: Text(
                    "Photo Gallery",
                    style: AppTextTheme.subtitleStyle.copyWith(
                      color: AppColors.blueColor,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    imagePickerBloc..add(GalleryImagePicked());
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppColors.blueColor.withOpacity(0.6),
                  ),
                  title: Text(
                    "Camera",
                    style: AppTextTheme.subtitleStyle.copyWith(
                      color: AppColors.blueColor,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    imagePickerBloc..add(CameraImagePicked());
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }
}
