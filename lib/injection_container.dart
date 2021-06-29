import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/blocs/gender_cubit.dart';
import 'package:sifaris_app/core/blocs/image_picker/image_picker_bloc.dart';
import 'package:sifaris_app/core/blocs/organization_cubit/organization_cubit.dart';
import 'package:sifaris_app/core/data/datasources/local_datasource.dart';
import 'package:sifaris_app/core/data/datasources/remote_datasource.dart';
import 'package:sifaris_app/core/data/repositories/i_data_repository.dart';
import 'package:sifaris_app/core/domain/repositories/data_repository.dart';
import 'package:sifaris_app/core/domain/usecases/organization_usecase.dart';
import 'package:sifaris_app/core/network/network_info.dart';
import 'package:sifaris_app/core/utils/input_converter.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sifaris_app/features/auth/data/repositories/i_auth_repository.dart';
import 'package:sifaris_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sifaris_app/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:sifaris_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:sifaris_app/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:sifaris_app/features/auth/domain/usecases/password_reset_sent_otp_usecase.dart';
import 'package:sifaris_app/features/auth/domain/usecases/password_reset_usecase.dart';
import 'package:sifaris_app/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:sifaris_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/login/login_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:sifaris_app/features/auth/presentation/blocs/password_reset/password_reset_bloc.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/user_type_toggle.dart';
import 'package:sifaris_app/features/kyc/data/datasources/kyc_remote_datasource.dart';
import 'package:sifaris_app/features/kyc/data/repositories/i_kyc_verification_repository.dart';
import 'package:sifaris_app/features/kyc/domain/repositories/kyc_verification_repository.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/former_ward_usecase.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/individual_documents_usecase.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/user_verify_usecase.dart';
import 'package:sifaris_app/features/kyc/kyc_injection.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/former_ward/former_ward_cubit.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/individual_documents/individual_documents_cubit.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/kyc/kyc_bloc.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/navigate/navigate_cubit.dart';
import 'package:sifaris_app/features/notice/data/datasource/notice_remote_datasource.dart';
import 'package:sifaris_app/features/notice/data/repositories/i_notice_repository.dart';
import 'package:sifaris_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:sifaris_app/features/notice/domain/usecases/get_notice_usecase.dart';
import 'package:sifaris_app/features/notice/presentation/blocs/notice/notice_bloc.dart';
import 'package:sifaris_app/features/notification/notification_injection.dart';

import 'package:sifaris_app/features/paper/paper_injection.dart';

import 'package:sifaris_app/features/profile/presentation/blocs/profile_toggle/profile_toggle_cubit.dart';
import 'package:sifaris_app/features/profile/profile_injection.dart';
import 'package:sifaris_app/features/template/data/datasources/template_remote_datasource.dart';
import 'package:sifaris_app/features/template/data/respositories/i_template_repository.dart';
import 'package:sifaris_app/features/template/domain/respositories/template_repository.dart';
import 'package:sifaris_app/features/template/domain/usecases/all_templates_usecase.dart';
import 'package:sifaris_app/features/template/domain/usecases/category_template_usecase.dart';
import 'package:sifaris_app/features/template/domain/usecases/popular_templates_usecase.dart';
import 'package:sifaris_app/features/template/presentation/blocs/category_template/categorytemplate_bloc.dart';
import 'package:sifaris_app/features/template/presentation/blocs/templates/templates_bloc.dart';
import 'package:sifaris_app/features/template/presentation/blocs/templates_toggle/templates_toggle_cubit.dart';

import 'features/profile/data/datasources/profile_local_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Profile injection
  profileInjectionInit();

  // paper injection
  paperInjection();

// notification injection
  notificationInjection();

  // kyc injection
  kycInjection();

  //! features
  // Blocs
  sl.registerFactory(() => LoginBloc(loginUseCase: sl(), fcm: sl()));
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GenderCubit());
  sl.registerLazySingleton(() => UserTypeToggleCubit());
  sl.registerLazySingleton(() => OrganizationCubit(organizationUseCase: sl()));
  sl.registerLazySingleton(
      () => RegisterBloc(signupUseCase: sl(), otpVerifyUseCase: sl()));
  sl.registerLazySingleton(() => ImagePickerBloc());
  sl.registerLazySingleton(() => TemplatesToggleCubit());
  sl.registerLazySingleton(() => ProfileToggleCubit());
  sl.registerLazySingleton(() => TemplatesBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => CategorytemplateBloc(
      authLocalDataSource: sl(), categoryTemplateUseCase: sl()));
  sl.registerLazySingleton(() => NavigateCubit());
  sl.registerLazySingleton(() => FormerWardCubit(sl(), sl()));
  sl.registerLazySingleton(() => PasswordResetBloc(sl(), sl()));
  sl.registerLazySingleton(() => ChangePasswordBloc(sl(), sl()));
  sl.registerLazySingleton(() => NoticeBloc(sl(), sl()));

  sl.registerLazySingleton(
      () => IndividualDocumentsCubit(individualDocumnetsUseCase: sl()));
  // usecases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => OrganizationUseCase(dataRepository: sl()));
  sl.registerLazySingleton(() => OtpVerifyUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => AllTemplatesUseCase(templateRepository: sl()));
  sl.registerLazySingleton(
      () => CategoryTemplateUseCase(templateRepository: sl()));
  // sl.registerLazySingleton(() => GetProfileUseCase(profileRepository: sl()));
  sl.registerLazySingleton(
      () => FormerWardUseCase(kycVerificationRepository: sl()));
  // sl.registerLazySingleton(
  //     () => VerificationDetailsUseCase(kycVerificationRepository: sl()));
  // sl.registerLazySingleton(() => PaperRequestUseCase(paperRepository: sl()));
  sl.registerLazySingleton(
      () => PopularTemplatesUseCase(templateRepository: sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => PasswordResetSentOtpUseCase(sl()));
  sl.registerLazySingleton(() => PasswordResetUseCase(sl()));
  sl.registerLazySingleton(() => GetNoticeUseCase(sl()));

  sl.registerLazySingleton(() => IndividualDocumnetsUseCase(sl()));

  //! core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => INetworkInfo(sl()));

  // !Repository
  sl.registerLazySingleton<AuthRepository>(() => IAuthRepository(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
      profileLocalDataSource: sl(),
      networkInfo: sl()));
  sl.registerLazySingleton<DataRepository>(
      () => IDataRepository(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TemplateRepository>(
      () => ITemplateRepository(networkInfo: sl(), templateRemoteSource: sl()));
  // sl.registerLazySingleton<ProfileRepository>(() =>
  //     IProfileRepository(networkInfo: sl(), profileRemoteDataSource: sl()));

  // sl.registerLazySingleton<PaperRepository>(
  //     () => IPaperRepository(networkInfo: sl(), paperRemoteDataSource: sl()));
  sl.registerLazySingleton<NoticeRepository>(
      () => INoticeRepository(noticeRemoteDataSource: sl(), networkInfo: sl()));
  // !Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => IAuthRemoteDataSource(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => IAuthLocalDataSource(sharedPreferences: sl()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => IRemoteDataSouce(client: sl()));
  sl.registerLazySingleton<TemplateRemoteSource>(
      () => ITemplateRemoteSource(client: sl()));
  // sl.registerLazySingleton<ProfileRemoteDataSource>(
  //     () => IProfileRemoteDataSource(client: sl()));
  sl.registerLazySingleton<ProfileLocalDataSource>(
      () => IProfileLocalDataSource(sharedPreferences: sl()));

  sl.registerLazySingleton<NoticeRemoteDataSource>(
      () => INoticeRemoteDataSource(client: sl()));

  sl.registerLazySingleton<LocalDataResource>(() => ILocalDataSource(sl()));

  //! external
  final sharedPreferences = await SharedPreferences.getInstance();
  final fcm = FirebaseMessaging.instance;
  sl.registerLazySingleton(() => fcm);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
