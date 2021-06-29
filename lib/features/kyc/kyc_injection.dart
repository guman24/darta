import 'package:get_it/get_it.dart';
import 'package:sifaris_app/features/kyc/data/repositories/i_kyc_verification_repository.dart';
import 'package:sifaris_app/features/kyc/domain/repositories/kyc_verification_repository.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/get_verification_details_usecase.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/kyc/kyc_bloc.dart';
import 'package:sifaris_app/features/kyc/presentation/blocs/verification_user_data/verification_user_detail_bloc.dart';

import 'data/datasources/kyc_remote_datasource.dart';
import 'domain/usecases/user_verify_usecase.dart';

final sl = GetIt.instance;

Future<void> kycInjection() async {
  // ! USECASES
  // sl.registerLazySingleton(
  //     () => VerificationDetailsUseCase(kycVerificationRepository: sl()));
  sl.registerLazySingleton(() => UserVerifyUseCase(sl()));

  // ! BLOCS
  sl.registerLazySingleton(() => KycBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => VerificationUserDetailBloc(
      authLocalDataSource: sl(), verificationDetailsUseCase: sl()));

  // !DATA RESOURCES
  sl.registerLazySingleton<KycRemoteDataSource>(
      () => IKycRemoteDataSource(client: sl()));

  // ! REPOSITORIES
  sl.registerLazySingleton<KycVerificationRepository>(() =>
      IKycVerificationRepository(
          kycRemoteDataSource: sl(),
          networkInfo: sl(),
          coreRemoteDataSource: sl()));
}
