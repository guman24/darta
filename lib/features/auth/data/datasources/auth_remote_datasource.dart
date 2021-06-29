import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/error/exception.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({Map<String, dynamic> data});
  Future<Map<String, dynamic>> signUp({Map<String, dynamic> data});
  Future<Map<String, dynamic>> refreshToken({String token});
  Future<Map<String, dynamic>> verifyOtp({Map<String, dynamic> data});
  Future<Map<String, dynamic>> sendOtp({String email});

  Future<Map<String, dynamic>> forgotPasswordSendOtp({String email});

  Future<String> resetPassword({Map<String, dynamic> data});

  Future<String> changePassword({Map<String, dynamic> data});
}

class IAuthRemoteDataSource implements AuthRemoteDataSource {
  final http.Client client;

  IAuthRemoteDataSource({@required this.client});
  @override
  Future<Map<String, dynamic>> login({Map<String, dynamic> data}) async {
    Uri loginUrl = Uri.parse(ApiConstants.BASE_URL + "api/signin");
    print("Login data $data");
    final loginResponse = await client.post(
      loginUrl,
      // headers: {'Content-Type': 'application/json'},
      body: data,
    );
    if (loginResponse.statusCode == 200) {
      Map<String, dynamic> mapData =
          Map<String, dynamic>.from(jsonDecode(loginResponse.body.toString()));
      return mapData;
    } else if (loginResponse.statusCode == 400) {
      Map<String, dynamic> mapData =
          Map<String, dynamic>.from(jsonDecode(loginResponse.body.toString()));
      throw ServerException(message: mapData['message']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> signUp({Map<String, dynamic> data}) async {
    Uri signUpUrl = Uri.parse(ApiConstants.BASE_URL + "api/v3/signup");
    final signUpResponse = await http.post(signUpUrl, body: data);
    print("***register ${signUpResponse.body}");
    if (signUpResponse.statusCode == 200) {
      Map<String, dynamic> mapData =
          Map<String, dynamic>.from(jsonDecode(signUpResponse.body.toString()));
      if (mapData['message'].toString().contains("User Signup Successful.")) {
        return mapData;
      }
      if (mapData["status_code"] >= 400 && mapData["status_code"] < 500) {
        print("throw this");
        throw ServerException(message: mapData['message'].toString());
      } else if (mapData['status_code'] >= 400 &&
          mapData['status_code'] < 500) {
        throw ServerException(message: mapData['message']);
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> refreshToken({String token}) async {
    Uri refreshTokenUrl =
        Uri.parse(ApiConstants.BASE_URL + "api/refresh_token");
    final refreshTokenResponse =
        await http.post(refreshTokenUrl, body: {"refresh_token": token});
    if (refreshTokenResponse.statusCode == 200) {
      Map<String, dynamic> map = Map<String, dynamic>.from(
          jsonDecode(refreshTokenResponse.body.toString()));

      return map;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> verifyOtp({Map<String, dynamic> data}) async {
    Uri _verifyURL =
        Uri.parse(ApiConstants.BASE_URL + "api/v3/signup/verify_otp");
    final verifyResponse = await http.post(_verifyURL,
        body: {'otp': data['otp'], 'user_id': data['user_id']});
    if (verifyResponse.statusCode == 200) {
      Map<String, dynamic> map =
          Map<String, dynamic>.from(jsonDecode(verifyResponse.body.toString()));
      print("** map $map");
      return map;
    }
    throw ServerException();
  }

  @override
  Future<Map<String, dynamic>> sendOtp({String email}) async {
    Uri _sentOtp =
        Uri.parse(ApiConstants.BASE_URL + "api/v3/signup/verify_otp");
    final otpResponse = await http.post(_sentOtp, body: {"email": email});
    if (otpResponse.statusCode == 200) {
      Map<String, dynamic> map =
          Map<String, dynamic>.from(jsonDecode(otpResponse.body.toString()));
      return map;
    } else if (otpResponse.statusCode == 400) {
      Map<String, dynamic> mapData =
          Map<String, dynamic>.from(jsonDecode(otpResponse.body.toString()));
      throw ServerException(message: mapData['error']);
    }
    throw ServerException();
  }

  @override
  Future<String> resetPassword({Map<String, dynamic> data}) async {
    Uri _resetPasswordURL = Uri.parse(ApiConstants.BASE_URL + "api/passwords");
    print("data ***$data");
    final resetPasswordResponse =
        await http.post(_resetPasswordURL, body: data);
    if (resetPasswordResponse.statusCode == 200) {
      Map<String, dynamic> map = Map<String, dynamic>.from(
          jsonDecode(resetPasswordResponse.body.toString()));
      return map['message'];
    } else if (resetPasswordResponse.statusCode >= 400 &&
        resetPasswordResponse.statusCode < 500) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(
          jsonDecode(resetPasswordResponse.body.toString()));
      throw ServerException(message: mapData['message']);
    }
    throw ServerException();
  }

  @override
  Future<String> changePassword({Map<String, dynamic> data}) async {
    Uri _changePasswordURL =
        Uri.parse(ApiConstants.BASE_URL + "api/passwords/change");
    final headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${data["token"]}'
    };

    final changePasswordResponse =
        await http.post(_changePasswordURL, headers: headers, body: data);
    if (changePasswordResponse.statusCode == 200) {
      Map<String, dynamic> map = Map<String, dynamic>.from(
          jsonDecode(changePasswordResponse.body.toString()));
      return map['message'];
    } else if (changePasswordResponse.statusCode >= 400 &&
        changePasswordResponse.statusCode < 500) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(
          jsonDecode(changePasswordResponse.body.toString()));
      throw ServerException(message: mapData['message']);
    }
    throw ServerException();
  }

  @override
  Future<Map<String, dynamic>> forgotPasswordSendOtp({String email}) async {
    Uri _resetPasswordSentOtpUrl =
        Uri.parse(ApiConstants.BASE_URL + "api/passwords/forgot");
    final resetPasswordSentOtpResponse =
        await http.post(_resetPasswordSentOtpUrl, body: {
      "email": email,
    });
    if (resetPasswordSentOtpResponse.statusCode == 200) {
      Map<String, dynamic> map = Map<String, dynamic>.from(
          jsonDecode(resetPasswordSentOtpResponse.body.toString()));
      return map;
    } else if (resetPasswordSentOtpResponse.statusCode >= 400 &&
        resetPasswordSentOtpResponse.statusCode < 500) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(
          jsonDecode(resetPasswordSentOtpResponse.body.toString()));
      throw ServerException(message: mapData['error']);
    }
    throw ServerException();
  }
}
