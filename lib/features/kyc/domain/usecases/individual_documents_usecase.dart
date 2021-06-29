import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/kyc/domain/repositories/kyc_verification_repository.dart';

class IndividualDocumnetsUseCase extends UseCase<List<String>, NoParams> {
  final KycVerificationRepository kycVerificationRepository;

  IndividualDocumnetsUseCase(this.kycVerificationRepository);
  @override
  Future<Either<Failure, List<String>>> call(NoParams noParams) {
    return kycVerificationRepository.getIndividualDocuments();
  }
}
