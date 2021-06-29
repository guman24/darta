import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> login(
      {Map<String, dynamic> data});
  Future<Either<Failure, Map<String, dynamic>>> register(
      {Map<String, dynamic> data});
  Future<Either<Failure, Map<String, dynamic>>> verifyOtp(
      {Map<String, dynamic> data});
  Future<Either<Failure, Map<String, dynamic>>> refreshToken({String token});

  Future<Either<Failure, Map<String, dynamic>>> sendOtp({String email});
  Future<Either<Failure, Map<String, dynamic>>> passwordResetSentOtp(
      {String email});
  Future<Either<Failure, String>> resetPassword({Map<String, dynamic> data});

  Future<Either<Failure, String>> changePassword({Map<String, dynamic> data});
}
