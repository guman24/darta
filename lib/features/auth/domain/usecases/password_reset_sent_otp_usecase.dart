import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/auth/domain/repositories/auth_repository.dart';

class PasswordResetSentOtpUseCase
    extends UseCase<Map<String, dynamic>, String> {
  final AuthRepository authRepository;

  PasswordResetSentOtpUseCase(this.authRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String email) {
    return authRepository.passwordResetSentOtp(email: email);
  }
}
