import 'package:get_it/get_it.dart';
import 'package:sifaris_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:sifaris_app/features/profile/data/repositories/i_profile_repository.dart';
import 'package:sifaris_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:sifaris_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:sifaris_app/features/profile/presentation/blocs/profile/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> profileInjectionInit() async {
  sl.registerLazySingleton(() => GetProfileUseCase(profileRepository: sl()));
  sl.registerLazySingleton<ProfileRepository>(() =>
      IProfileRepository(networkInfo: sl(), profileRemoteDataSource: sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => IProfileRemoteDataSource(client: sl()));
  sl.registerLazySingleton(
      () => ProfileBloc(authLocalDataSource: sl(), getProfileUseCase: sl()));
}
