import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUseCase extends UseCase<String, Map<String, dynamic>> {
  final AuthRepository authRepository;

  ChangePasswordUseCase(this.authRepository);
  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> params) {
    return authRepository.changePassword(data: params);
  }
}
