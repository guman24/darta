import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/domain/entities/former_ward_entity.dart';

abstract class KycVerificationRepository {
  Future<Either<Failure, String>> kycVerify(
      {Map<String, dynamic> data,
      String token,
      List<DocumentEntity> files,
      String userPhotoURl});
  Future<Either<Failure, List<FormerWardEntity>>> getFormerWards(
      {String token});
  Future<Either<Failure, UserEntity>> getVerificationDetails({String token});
  Future<Either<Failure, List<String>>> getIndividualDocuments();
}
