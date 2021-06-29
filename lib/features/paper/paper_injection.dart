import 'package:get_it/get_it.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/get_verification_details_usecase.dart';
import 'package:sifaris_app/features/paper/data/repositories/I_paper_repository.dart';
import 'package:sifaris_app/features/paper/domain/repositories/paper_repository.dart';
import 'package:sifaris_app/features/paper/domain/usecases/get_paper_usecase.dart';
import 'package:sifaris_app/features/paper/domain/usecases/paper_request_usecase.dart';
import 'package:sifaris_app/features/paper/presentation/blocs/get_papers/get_papers_bloc.dart';
import 'package:sifaris_app/features/paper/presentation/blocs/paper_create/papercreate_bloc.dart';
import 'package:sifaris_app/features/paper/presentation/blocs/paper_create/verification_user_data/get_verification_data_bloc.dart';

import 'data/datasources/paper_remote_datasource.dart';

final sl = GetIt.instance;

Future<void> paperInjection() async {
  // ! USECASES
  sl.registerLazySingleton(() => PaperRequestUseCase(paperRepository: sl()));
  sl.registerLazySingleton(
      () => VerificationDetailsUseCase(kycVerificationRepository: sl()));
  sl.registerLazySingleton(() => GetPapersUseCase(sl()));

  // ! REPOSITORIES
  sl.registerLazySingleton<PaperRepository>(
      () => IPaperRepository(networkInfo: sl(), paperRemoteDataSource: sl()));

  // ! BLOCS
  sl.registerFactory(() => PaperCreateBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetVerificationDataBloc(sl(), sl()));
  sl.registerLazySingleton(() => GetPapersBloc(sl(), sl(), sl()));

  // ! DATA SOURCES
  sl.registerLazySingleton<PaperRemoteDataSource>(
      () => IPaperRemoteDataSource(client: sl()));
}
