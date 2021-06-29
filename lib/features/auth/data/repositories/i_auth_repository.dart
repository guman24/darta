import 'package:flutter/material.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/error/exception.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/network/network_info.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sifaris_app/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:sifaris_app/features/profile/data/local_profile_model.dart';

class IAuthRepository extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final ProfileLocalDataSource profileLocalDataSource;
  final NetworkInfo networkInfo;

  IAuthRepository({
    @required this.authRemoteDataSource,
    @required this.authLocalDataSource,
    @required this.networkInfo,
    @required this.profileLocalDataSource,
  });

// !LOGIN
  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
      {Map<String, dynamic> data}) async {
    if (await networkInfo.isConncected) {
      try {
        final responseData = await authRemoteDataSource.login(data: data);
        // here we can add login data to local database
        SessionModel sessionModel = new SessionModel(
            token: responseData["token"],
            expiry: responseData["expiry"],
            userId: responseData["user"]["_id"],
            refreshToken: responseData['refresh_token'],
            verificationStatus: responseData['user']['status'],
            verificationEnum: responseData['user']['status'] == 'verified'
                ? VerificationEnum.Verified.toString()
                : VerificationEnum.Unsent.toString());
        // : (responseData['user']['status'] == 'unverified'
        //     ? VerificationEnum.Sent.toString()
        //     : VerificationEnum.Unsent.toString()));
        authLocalDataSource.persistSession(session: sessionModel);
        // here save user details to shared pref
        LocalProfileModel profile = new LocalProfileModel(
          id: responseData['user']['_id'],
          departmentId: responseData['department']['id'],
          departmentName: responseData['department']['name'],
          departmentAddress: responseData['department']['address'],
          departmentNumber: responseData['department']['number'].toString(),
          organizationId: responseData['organization']['id'],
          orgnaizationName: responseData['organization']['name'],
          organizationAddress: responseData['organization']['address'],
          organizationProvince: responseData['organization']['province'],
          firstName: responseData['user']['first_name'],
          lastName: responseData['user']['last_name'],
          email: responseData['user']['email'],
          phone: responseData['user']['phone'],
          addressType: responseData['user']['address_type'],
        );
        profileLocalDataSource.saveProfile(profile: profile);
        return Right(responseData);
      } on ServerException catch (er) {
        return Left(ServerFailure(message: er.message));
      } on FormatException {
        return Left(FormatFailure());
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }

// ! SIGN UP
  @override
  Future<Either<Failure, Map<String, dynamic>>> register(
      {Map<String, dynamic> data}) async {
    if (await networkInfo.isConncected) {
      try {
        final registerResponse = await authRemoteDataSource.signUp(data: data);
        return Right(registerResponse);
      } on ServerException catch (er) {
        return Left(ServerFailure(message: er.message));
      }
    } else {
      return Left(
          ServerFailure(message: "No Internet Connection. Plase try again"));
    }
  }

// ! REFRESH TOKEN
  @override
  Future<Either<Failure, Map<String, dynamic>>> refreshToken(
      {String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final responseData =
            await authRemoteDataSource.refreshToken(token: token);
        return Right(responseData);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message.toString()));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }

// !VERIFY OTP
  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyOtp(
      {Map<String, dynamic> data}) async {
    if (await networkInfo.isConncected) {
      try {
        final verifyResponse = await authRemoteDataSource.verifyOtp(data: data);
        return Right(verifyResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Please try again"));
    }
  }

// ! FORGOT PASSWORD
  @override
  Future<Either<Failure, Map<String, dynamic>>> passwordResetSentOtp(
      {String email}) async {
    if (await networkInfo.isConncected) {
      try {
        final otpResponse =
            await authRemoteDataSource.forgotPasswordSendOtp(email: email);
        return Right(otpResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Please try again"));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      {Map<String, dynamic> data}) async {
    if (await networkInfo.isConncected) {
      try {
        final resetPasswordResponse =
            await authRemoteDataSource.resetPassword(data: data);
        return Right(resetPasswordResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Please try again"));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
      {Map<String, dynamic> data}) async {
    if (await networkInfo.isConncected) {
      try {
        final changePasswordResponse =
            await authRemoteDataSource.changePassword(data: data);
        return Right(changePasswordResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Please try again"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sendOtp({String email}) async {
    if (await networkInfo.isConncected) {
      try {
        final otpResponse = await authRemoteDataSource.sendOtp(email: email);
        return Right(otpResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Please try again"));
    }
  }
}
