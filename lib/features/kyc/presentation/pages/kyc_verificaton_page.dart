import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;

import 'package:sifaris_app/core/blocs/image_picker/image_picker_bloc.dart';
import 'package:sifaris_app/core/blocs/organization_cubit/organization_cubit.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/utils/app_text_theme.dart';
import 'package:sifaris_app/core/utils/custom_button.dart';
import 'package:sifaris_app/core/utils/custom_scaffold_messenger.dart';
import 'package:sifaris_app/core/utils/custom_widget.dart';
import 'package:sifaris_app/core/utils/date.dart';
import 'package:sifaris_app/core/utils/input_theme.dart';
import 'package:sifaris_app/core/utils/size_config.dart';

import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/address/address_cubit.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/former_ward/former_ward_cubit.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/individual_documents/individual_documents_cubit.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/kyc/kyc_bloc.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/navigate/navigate_cubit.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/verification_user_data/verification_user_detail_bloc.dart';
import 'package:sifaris_app/features/paper/presentation/blocs/paper_create/verification_user_data/get_verification_data_bloc.dart';
import 'package:sifaris_app/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:sifaris_app/features/profile/data/local_profile_model.dart';

import '../../../../injection.dart';
import '../../../../injection_container.dart';

class KycVerificationPage extends StatefulWidget {
  @override
  _KycVerificationPageState createState() => _KycVerificationPageState();
}

class _KycVerificationPageState extends State<KycVerificationPage> {
  LocalProfileModel profile = new LocalProfileModel();
  UserEntity user = UserEntity();
  @override
  void initState() {
    super.initState();
    // getUserDetails();
  }

  Future getUserDetails() async {
    return await sl<ProfileLocalDataSource>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                sl<IndividualDocumentsCubit>()..getIndividualDocuments()),
        BlocProvider(create: (_) => sl<OrganizationCubit>()..loadDepartments()),
        BlocProvider(
          create: (_) => NavigateCubit(),
        ),
        BlocProvider(create: (_) => getIt<KycBloc>()),
        BlocProvider(
            create: (_) => getIt<VerificationUserDetailBloc>()
              ..add(GetUserVerificationDetailEvent())),
      ],
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<NavigateCubit, NavigateState>(
              listener: (context, state) {
                if (state.index < 0) {
                  Navigator.pop(context);
                }
              },
            ),
            // BlocListener<KycBloc, KycState>(listener: (context, state) {

            // })
          ],
          child: BlocBuilder<NavigateCubit, NavigateState>(
            builder: (context, state) {
              return Container(
                child: Stack(
                  children: [
                    topContainer(),
                    BlocBuilder<VerificationUserDetailBloc,
                        VerificationUserDetailState>(
                      builder: (context, state) {
                        if (state is VerificationUserDetailLoadedState) {
                          user = state.userData;
                          return CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Container(
                                  height: SizeConfig.screenHeight * 0.64,
                                  width: SizeConfig.screenWidth,
                                  constraints: BoxConstraints(
                                      minHeight: SizeConfig.screenHeight * 0.6,
                                      maxHeight: SizeConfig.screenHeight * 0.7),
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.screenHeight * 0.36),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          topLeft: Radius.circular(20.0))),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 0,
                                        child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text(
                                            "प्रमाणिकरण",
                                            style: AppTextTheme.titleStyle
                                                .copyWith(
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: FutureBuilder(
                                            future: getUserDetails(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return KycVerificationSettper(
                                                    profile: snapshot.data,
                                                    user: user);
                                              } else {
                                                return Text("Empty");
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<NavigateCubit>()
                          ..onPreviousPage(value: state.index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        margin: EdgeInsets.only(top: 50.0, left: 20.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class KycVerificationSettper extends StatefulWidget {
  final LocalProfileModel profile;
  final UserEntity user;
  const KycVerificationSettper({
    Key key,
    @required this.profile,
    @required this.user,
  }) : super(key: key);
  @override
  _KycVerificationSettperState createState() => _KycVerificationSettperState();
}

class _KycVerificationSettperState extends State<KycVerificationSettper> {
  final TextEditingController _citizenshipNumberController =
      TextEditingController();

  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _husbandWifeNameController =
      TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  final TextEditingController _sProvinceController = TextEditingController();
  final TextEditingController _sMuncipalityController = TextEditingController();
  final TextEditingController _sWardController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _midNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final GlobalKey<FormState> _citizenWardFormKey = GlobalKey();
  final GlobalKey<FormState> _parentFormKey = GlobalKey();
  final GlobalKey<FormState> _birthDateFormKey = GlobalKey();
  final GlobalKey<FormState> _secondAddressFormKey = GlobalKey();
  final GlobalKey<FormState> _formerAddressFormKey = GlobalKey();
  final GlobalKey<FormState> _nameFormKey = GlobalKey();
  List<DocumentEntity> citizenshipFiles;

  final Map<String, dynamic> formData = Map();
  List<String> citizenDocs = [];
  List<DocumentEntity> docs = [];
  String userPhotoUrl;

  Future<LocalProfileModel> getUserDetails() async {
    return await sl<ProfileLocalDataSource>().getProfile();
  }

  @override
  void initState() {
    super.initState();
    _citizenshipNumberController.text = widget.user.citizenshipNumber ?? "";
    formData['user_id'] = widget.profile.id;
    formData['applicant_phone'] = widget.profile.phone;

    _firstNameController.text =
        widget.user.firstName ?? (widget.profile.firstName ?? "");
    _midNameController.text =
        widget.user.middleName ?? (widget.profile.middleName ?? "");
    _lastNameController.text =
        widget.user.lastName ?? (widget.profile.lastName ?? "");
    docs = widget.user.personalDocs ?? [];
    _fatherNameController.text = widget.user.fatherName ?? "";
    _motherNameController.text = widget.user.motherName ?? "";
    citizenshipFiles = widget.user.personalDocs ?? [];
    userPhotoUrl = widget.user.photoURL ?? null;
    _setSecondAddress();
    if (widget.user.birthDate != null) {
      _getSpliDate();
    }
  }

  void _setSecondAddress() {
    if (widget.profile.addressType == "Permanent") {
      _sProvinceController.text = widget.user.temporaryProvince ?? "";
      _sMuncipalityController.text = widget.user.temporaryMunicipality ?? "";
      _sWardController.text = widget.user.temporaryWard ?? "";
    } else {
      _sProvinceController.text = widget.user.permanentProvince ?? "";
      _sMuncipalityController.text = widget.user.permanentMunicipality ?? "";
      _sWardController.text = widget.user.permanentWard ?? "";
    }
  }

  void _getSpliDate() {
    List<String> date = splitDate(widget.user.birthDate);
    _dayController.text = date[2];
    _monthController.text = date[1];
    _yearController.text = date[0];
  }

  Widget _citizenWardWidget({LocalProfileModel profile}) {
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: Form(
            key: _citizenWardFormKey,
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      "तपाईंको नागरिकता विवरण राख्नुहोस्",
                      style: AppTextTheme.normalStyle.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: TextFormField(
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
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  flex: 0,
                  child: DropdownButtonFormField(
                    value: districts[0],
                    items: districts
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    decoration: InputTheme.getFormField(
                        hintText: "नागरिकता जारी जिल्ला *"),
                    onChanged: (value) {
                      formData['citizenship_issue_district'] = value;
                    },
                  ),
                ),
                // Expanded(
                //   child: BlocBuilder<OrganizationCubit, OrganizationState>(
                //     builder: (context, state) {
                //       return state.departments != null
                //           ? DropdownButtonFormField(
                //               // value: state.departments[0].id.toString(),
                //               value: profile.departmentId,
                //               items: state.departments
                //                   .map((e) => DropdownMenuItem(
                //                       value: e.id.toString(),
                //                       child: Text(e.name)))
                //                   .toList(),
                //               onSaved: (value) {
                //                 formData['department_id'] = value;
                //               },
                //               onChanged: (value) {},
                //               decoration: InputTheme.getFormField(
                //                   hintText: 'वार्ड नम्बर'),
                //             )
                //           : Center(child: CircularProgressIndicator());
                //     },
                //   ),
                // ),

                Expanded(
                  flex: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                        onTap: () {
                          if (_citizenWardFormKey.currentState.validate()) {
                            _citizenWardFormKey.currentState.save();
                            formData["citizenship_number"] =
                                _citizenshipNumberController.text;
                            context.read<NavigateCubit>()
                              ..onNextPage(value: state.index);
                          } else {
                            showCustomSnack(
                                context: context,
                                type: SnackBarMessegeType.ERROR.toString(),
                                messege: "नागरिकता नम्बर अनिवार्य छ");
                          }
                        },
                        child: customSolidButton(title: "अर्को")),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _citizenshipDocsWidget() {
    int _docLength = 0;
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: Text(
                  "तपाईंको नागरिकताको तस्वीर अपलोड गर्नुहोस्",
                  style: AppTextTheme.normalStyle
                      .copyWith(color: AppColors.blueColor),
                ),
              ),
              Expanded(child: BlocBuilder<IndividualDocumentsCubit,
                  IndividualDocumentsState>(builder: (context, state) {
                if (state.individualDocs != null) {
                  _docLength = state.individualDocs.length;
                  state.individualDocs.forEach((element) {
                    citizenshipFiles.add(DocumentEntity(
                      title: element,
                      url: null,
                    ));
                  });
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.individualDocs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.0),
                      itemBuilder: (context, index) {
                        return BlocProvider(
                          create: (_) => ImagePickerBloc(),
                          child:
                              BlocConsumer<ImagePickerBloc, ImagePickerState>(
                            listener: (context, state) {
                              if (state is ImagePickerSuccess) {
                                String dir = path.dirname(state.image.path);
                                String ext = state.image.path
                                    .split('/')
                                    .last
                                    .split('.')
                                    .last;
                                String newUrl = path.join(dir,
                                    "${citizenshipFiles[index].title}.$ext");
                                File f =
                                    File(state.image.path).copySync(newUrl);
                                citizenshipFiles[index].url = f.path;
                              }
                              if (state is ImagePickerEmpty) {
                                citizenshipFiles[index].url = null;
                              }
                            },
                            builder: (context, state) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  citizenshipFiles[index].url == null
                                      ? Container(
                                          height:
                                              SizeConfig.screenHeight * 0.13,
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
                                          decoration: InputTheme
                                              .getInputBoxDecoration(),
                                        )
                                      : Container(
                                          height:
                                              SizeConfig.screenHeight * 0.13,
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
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: citizenshipFiles[
                                                                index]
                                                            .url
                                                            .contains("http")
                                                        ? Image.network(
                                                            citizenshipFiles[
                                                                    index]
                                                                .url)
                                                        : Image.file(
                                                            File(
                                                                citizenshipFiles[
                                                                        index]
                                                                    .url),
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
                                                      context.read<
                                                          ImagePickerBloc>()
                                                        ..add(ImageDeleted());
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(1.0),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .whiteGrayColor,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .white),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        FontAwesomeIcons.times,
                                                        size: 20.0,
                                                        color:
                                                            AppColors.grayColor,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                  Text(
                                    citizenshipFiles[index].title,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: AppTextTheme.generalStyle.copyWith(
                                      color: AppColors.textColor,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
              Expanded(
                flex: 0,
                child: GestureDetector(
                  onTap: () {
                    citizenDocs = [];
                    citizenshipFiles.forEach((element) {
                      if (element.url != null) {
                        citizenDocs.add(element.url);
                      }
                    });
                    print(
                        "citizendocs len ${citizenDocs.length} =>${citizenshipFiles.length}");
                    if (citizenDocs.length == _docLength) {
                      context.read<NavigateCubit>()
                        ..onNextPage(value: state.index);
                    } else {
                      showCustomSnack(
                          type: SnackBarMessegeType.ERROR.toString(),
                          context: context,
                          messege: " तस्वीर अनिवार्य छ ।");
                    }
                  },
                  child: customSolidButton(title: "अर्को"),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _nameWidget() {
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: Form(
            key: _nameFormKey,
            child: Column(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "पहिलो नाम अनिवार्य छ ।";
                      }
                      return null;
                    },
                    // enabled: false,
                    // initialValue: widget.profile.firstName,
                    style: AppTextTheme.normalStyle.copyWith(
                      color: Colors.black,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    decoration:
                        InputTheme.getFormField(hintText: "पहिलो नाम *"),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _midNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    // initialValue: "",
                    // enabled: false,
                    style: AppTextTheme.normalStyle.copyWith(
                      color: Colors.black,
                    ),
                    decoration: InputTheme.getFormField(hintText: "बीचको नाम"),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "थर अनिवार्य छ ।";
                      }
                      return null;
                    },

                    // enabled: false,
                    // initialValue: widget.profile.lastName,
                    style: AppTextTheme.normalStyle.copyWith(
                      color: Colors.black,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    decoration: InputTheme.getFormField(hintText: "थर *"),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                      onTap: () {
                        // _onNextPage();
                        formData['first_name'] = widget.profile.firstName;

                        formData['last_name'] = widget.profile.lastName;

                        context.read<NavigateCubit>()
                          ..onNextPage(value: state.index);
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: customSolidButton(title: "अर्को"))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _photoWidget() {
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        return BlocProvider(
          create: (_) => ImagePickerBloc(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "तपाईंको प्रोफाइल तस्वीर अपलोड गर्नुहोस्",
                      style: AppTextTheme.normalStyle.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocConsumer<ImagePickerBloc, ImagePickerState>(
                    listener: (context, state) {
                      if (state is ImagePickerSuccess) {
                        String dir = path.dirname(state.image.path);
                        String ext =
                            state.image.path.split('/').last.split('.').last;
                        String newUrl = path.join(dir, "profile.$ext");
                        File f = File(state.image.path).copySync(newUrl);
                        userPhotoUrl = f.path;
                      }

                      if (state is ImagePickerEmpty) {
                        setState(() {
                          userPhotoUrl = null;
                        });
                      }
                    },
                    builder: (context, state) {
                      return Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              color: AppColors.grayColor.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: userPhotoUrl != null
                                ? Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: userPhotoUrl.contains("http")
                                              ? NetworkImage(userPhotoUrl)
                                              : FileImage(File(userPhotoUrl)),
                                          fit: BoxFit.cover,
                                        )),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 120.0,
                                    color: AppColors.white,
                                  ),
                          ),
                          userPhotoUrl != null
                              ? Positioned(
                                  top: 0.0,
                                  right: 0,
                                  left: 90.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<ImagePickerBloc>()
                                        ..add(ImageDeleted());
                                    },
                                    child: Container(
                                        width: 25.0,
                                        height: 25.0,
                                        margin: EdgeInsets.only(right: 10.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColors.grayColor,
                                                  offset: Offset(0, 0))
                                            ]),
                                        child: Icon(
                                          Icons.cancel,
                                          color: AppColors.white,
                                        )),
                                  ),
                                )
                              : Positioned(
                                  top: 60.0,
                                  right: 0,
                                  left: 90.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      pickImage(
                                          context: context,
                                          imagePickerBloc:
                                              context.read<ImagePickerBloc>());
                                    },
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          color: AppColors.grayColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.white,
                                          )),
                                      child: Icon(
                                        Icons.camera_alt,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                      onTap: () {
                        // _onNextPage();
                        if (userPhotoUrl != null) {
                          context.read<NavigateCubit>()
                            ..onNextPage(value: state.index);
                        } else {
                          showCustomSnack(
                              context: context,
                              type: SnackBarMessegeType.ERROR.toString(),
                              messege: "प्रोफाइल तस्वीर अनिवार्य छ ।");
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: customSolidButton(title: "अर्को"))),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _birthDateWidget() {
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _birthDateFormKey,
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "तपाईको जन्मदिन कहिले हो?",
                      style: AppTextTheme.normalStyle.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              Text(
                                "दिन",
                                style: AppTextTheme.generalStyle
                                    .copyWith(color: AppColors.black),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.whiteGrayColor,
                                  ),
                                  child: TextFormField(
                                    controller: _dayController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "--",
                                        hintStyle:
                                            AppTextTheme.subtitleStyle.copyWith(
                                          color: AppColors.black,
                                          wordSpacing: 2.0,
                                          letterSpacing: 3.0,
                                        )),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              Text(
                                "महिना",
                                style: AppTextTheme.generalStyle
                                    .copyWith(color: AppColors.black),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.whiteGrayColor,
                                  ),
                                  child: TextFormField(
                                    controller: _monthController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "--",
                                        hintStyle:
                                            AppTextTheme.subtitleStyle.copyWith(
                                          color: AppColors.black,
                                          wordSpacing: 2.0,
                                          letterSpacing: 3.0,
                                        )),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              Text(
                                "बर्ष",
                                style: AppTextTheme.generalStyle
                                    .copyWith(color: AppColors.black),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.whiteGrayColor,
                                  ),
                                  child: TextFormField(
                                    controller: _yearController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "----",
                                        hintStyle:
                                            AppTextTheme.subtitleStyle.copyWith(
                                          color: AppColors.black,
                                          wordSpacing: 2.0,
                                          letterSpacing: 3.0,
                                        )),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                      onTap: () {
                        if (_dayController.text.isNotEmpty &&
                            _monthController.text.isNotEmpty &&
                            _yearController.text.isNotEmpty) {
                          formData['dob'] = _yearController.text +
                              '-' +
                              _monthController.text +
                              '-' +
                              _dayController.text;
                          context.read<NavigateCubit>()
                            ..onNextPage(value: state.index);
                        } else {
                          showCustomSnack(
                              type: "error",
                              messege: "जन्मदिन अनिवार्य छ ।",
                              context: context);
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: customSolidButton(title: "अर्को"))),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _parentWidget() {
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _parentFormKey,
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "तपाईंको परिवारको विवरण राख्नुहोस्",
                      style: AppTextTheme.normalStyle.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _fatherNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "बुवाको नाम अनिवार्य छ";
                      }
                      return null;
                    },
                    decoration:
                        InputTheme.getFormField(hintText: "बुवाको नाम *"),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _motherNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "आमाको नाम अनिवार्य छ";
                      }
                      return null;
                    },
                    decoration:
                        InputTheme.getFormField(hintText: "आमाको नाम *"),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _husbandWifeNameController,
                    decoration:
                        InputTheme.getFormField(hintText: "पति/पत्नी नाम"),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                      onTap: () {
                        if (_parentFormKey.currentState.validate()) {
                          formData['father_name'] = _fatherNameController.text;
                          formData['mother_name'] = _motherNameController.text;
                          context.read<NavigateCubit>()
                            ..onNextPage(value: state.index);
                        } else {
                          showCustomSnack(
                              context: context,
                              type: SnackBarMessegeType.ERROR.toString(),
                              messege: "जानकारी अनिवार्य छ ।");
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: customSolidButton(title: "अर्को"))),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _firstAddressWidget({LocalProfileModel profile}) {
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: Text(
                  profile.addressType == "permanent"
                      ? "स्थाई ठेगाना"
                      : "अस्थायी ठेगाना",
                  style: AppTextTheme.normalStyle.copyWith(
                    color: AppColors.blueColor,
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: PROVINCE,
                  enabled: false,
                  decoration: InputTheme.getFormField(hintText: "प्रदेश *"),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: profile.orgnaizationName,
                  enabled: false,
                  decoration:
                      InputTheme.getFormField(hintText: "गा.पा. । न.पा. *"),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: profile.departmentName,
                  enabled: false,
                  decoration:
                      InputTheme.getFormField(hintText: "वार्ड नम्बर *"),
                ),
              ),
              Expanded(
                flex: 0,
                child: GestureDetector(
                    onTap: () {
                      if (profile.addressType == "permanent") {
                        formData['permanent_province'] = PROVINCE;
                        formData['permanent_municipality'] =
                            profile.orgnaizationName;
                        formData['permanent_ward'] = profile.departmentName;
                      } else {
                        formData['temporary_province'] = PROVINCE;
                        formData['temporary_municipality'] =
                            profile.orgnaizationName;
                        formData['temporary_ward'] = profile.departmentName;
                      }
                      context.read<NavigateCubit>()
                        ..onNextPage(value: state.index);
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: customSolidButton(title: "अर्को"))),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _secondAddressWidget({LocalProfileModel secondProfile}) {
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        String _address =
            secondProfile.addressType == "permanent" ? "स्थायी" : "अस्थायी";
        return BlocProvider(
            create: (_) => AddressCubit(),
            child: BlocBuilder<AddressCubit, AddressState>(
              builder: (context, addressState) {
                return Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _secondAddressFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                secondProfile.addressType == "permanent"
                                    ? "अस्थायी ठेगाना"
                                    : "स्थायी ठेगाना",
                                style: AppTextTheme.normalStyle.copyWith(
                                  color: AppColors.blueColor,
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 0,
                                child: Checkbox(
                                  value:
                                      secondProfile.addressType == "permanent"
                                          ? addressState.permanent
                                          : addressState.temporary,
                                  onChanged: (value) {
                                    // print("Hey");
                                    context.read<AddressCubit>()
                                      ..sameAsPermanent(value);
                                    if (value) {
                                      _sProvinceController.text = PROVINCE;
                                      _sMuncipalityController.text =
                                          secondProfile.orgnaizationName;
                                      _sWardController.text =
                                          secondProfile.departmentName;
                                    } else {
                                      _sProvinceController.text = "";
                                      _sMuncipalityController.text = "";
                                      _sWardController.text = "";
                                    }
                                  },
                                )),
                            Expanded(
                                flex: 0,
                                child: Text("$_address अनुसार फाराम भर्नुहोस्"))
                          ]),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _sProvinceController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "प्रदेश अनिवार्य छ";
                              }
                              return null;
                            },
                            decoration:
                                InputTheme.getFormField(hintText: "प्रदेश *"),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _sMuncipalityController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "गा.पा. । न.पा.  अनिवार्य छ";
                              }
                              return null;
                            },
                            decoration: InputTheme.getFormField(
                                hintText: "गा.पा. । न.पा. *"),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _sWardController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "वार्ड नम्बर  अनिवार्य छ";
                              }
                              return null;
                            },
                            decoration: InputTheme.getFormField(
                                hintText: "वार्ड नम्बर *"),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: GestureDetector(
                              onTap: () {
                                if (_secondAddressFormKey.currentState
                                    .validate()) {
                                  if (secondProfile.addressType ==
                                      "permanent") {
                                    formData['temporary_province'] =
                                        _sProvinceController.text;
                                    formData['temporary_municipality'] =
                                        _sMuncipalityController.text;
                                    formData['temporary_ward'] =
                                        _sWardController.text;
                                  } else {
                                    formData['permanent_province'] =
                                        _sProvinceController.text;

                                    formData['permanent_municipality'] =
                                        _sMuncipalityController.text;
                                    formData['permanent_ward'] =
                                        _sWardController.text;
                                  }
                                  context.read<NavigateCubit>()
                                    ..onNextPage(value: state.index);
                                } else {
                                  showCustomSnack(
                                      type:
                                          SnackBarMessegeType.ERROR.toString(),
                                      context: context,
                                      messege: "$_address  ठेगाना अनिवार्य छ");
                                }
                              },
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: customSolidButton(title: "अर्को"))),
                        )
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    );
  }

  Widget _formerAddressWidget() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formerAddressFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "सबिकाको ठेगाना",
                      style: AppTextTheme.normalStyle.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: BlocProvider(
                create: (_) => FormerWardCubit(sl(), sl())..loadFormerWards(),
                child: BlocBuilder<FormerWardCubit, FormerWardState>(
                  builder: (context, formerState) {
                    return formerState.loading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              DropdownButtonFormField(
                                decoration: InputTheme.getFormField(
                                    hintText: "गा.पा. । न.पा. "),
                                value: formerState.formerWards[0].id.toString(),
                                items: formerState.formerWards
                                    .map((e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(e.title),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  context.read<FormerWardCubit>()
                                    ..changeWards(
                                        former: formerState.formerWards,
                                        id: value.toString());
                                },
                                onSaved: (value) {
                                  formData['former_municipality'] = value;
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              DropdownButtonFormField(
                                decoration: InputTheme.getFormField(
                                    hintText: "वार्ड नम्बर "),
                                value: formerState.wards[0],
                                items: formerState.wards
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e.toString())))
                                    .toList(),
                                onChanged: (value) {},
                                onSaved: (value) {
                                  formData['former_ward'] = value;
                                },
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
            Expanded(
                flex: 0,
                child: BlocConsumer<KycBloc, KycState>(
                  listener: (context, state) {
                    if (state is KycVerifyLoading) {
                      showCustomSnack(
                          type: SnackBarMessegeType.PROGRESS.toString(),
                          context: context,
                          messege: "प्रमाणिकरणको लागि प्रतीक्षा गर्नुहोस्");
                    }
                    if (state is KycSuccess) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      showCustomSnack(
                          type: SnackBarMessegeType.INFO.toString(),
                          context: context,
                          messege: state.message);
                      Future.delayed(Duration(seconds: 1));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => DashBoardPage()),
                          (route) => false);
                    }
                    if (state is KycFailure) {
                      showCustomSnack(
                          type: SnackBarMessegeType.ERROR.toString(),
                          context: context,
                          messege: state.failMessage.length > 50
                              ? state.failMessage.substring(0, 50)
                              : state.failMessage);
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                        onTap: () {
                          _formerAddressFormKey.currentState.save();
                          formData['user_id'] = widget.profile.id;

                          context.read<KycBloc>()
                            ..add(PerformKycVerification(
                              data: formData,
                              files: citizenshipFiles,
                              userPhotoUrl: userPhotoUrl,
                            ));
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: customSolidButton(title: "बुझाउनुहोस्")));
                  },
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LocalProfileModel profile = snapshot.data;
            return BlocListener<NavigateCubit, NavigateState>(
              listener: (context, state) {},
              child: BlocBuilder<NavigateCubit, NavigateState>(
                builder: (context, state) {
                  switch (state.index) {
                    case 0:
                      return _citizenWardWidget(profile: snapshot.data);
                      break;
                    case 1:
                      return _citizenshipDocsWidget();
                      break;
                    case 2:
                      return _nameWidget();
                      break;
                    case 3:
                      return _photoWidget();
                      break;
                    case 4:
                      return _birthDateWidget();
                      break;
                    case 5:
                      return _parentWidget();
                      break;
                    case 6:
                      return _firstAddressWidget(profile: profile);
                      break;
                    case 7:
                      return _secondAddressWidget(secondProfile: profile);
                      break;
                    case 8:
                      return _formerAddressWidget();
                      break;
                  }
                  return Container();
                },
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
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
