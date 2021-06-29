import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile({String token});
}
