import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';

abstract class AuthLocalDataSource {
  /// Throws [NoLocalDataException] if no cached data is present.

  Future<void> persistSession({SessionModel session});
  Future<SessionModel> getSession();
  Future<void> updateStatus({String status});
  Future<void> clearSession();
  Future<void> saveCurrentPassword({String currentPassword});
  Future<void> saveNewPassword({String newPassword});
  Future<void> saveConfirmNewPassword({String confirmNewPassword});

  Future<void> saveEmail({String email});

  Future<void> saveOtp({String otp});
  Future<String> getOtp();
  Future<Map<String, dynamic>> getFortgotPasswrod();
  Future<void> deleteForgotPasswordAndOtp();
  Future<void> saveForgotPasswordOtp({String otp});
  Future<String> getForgotPasswordOtp();
}

class IAuthLocalDataSource implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  IAuthLocalDataSource({
    @required this.sharedPreferences,
  });
  @override
  Future<SessionModel> getSession() {
    final jsonString = sharedPreferences.getString(PERSISIT_SESSION);
    if (jsonString != null) {
      return Future.value(SessionModel.fromJson(json.decode(jsonString)));
    } else {
      // throw CacheException;
      return null;
    }
  }

  @override
  Future<void> persistSession({SessionModel session}) {
    return sharedPreferences.setString(
        PERSISIT_SESSION, json.encode(session.toJson()));
  }

  @override
  Future<void> updateStatus({String status}) async {
    SessionModel session = await getSession();
    session.verificationEnum = status;
    return Future.value(sharedPreferences.setString(
        PERSISIT_SESSION, json.encode(session.toJson())));
  }

  @override
  Future<void> clearSession() async {
    return Future.value(sharedPreferences.remove(PERSISIT_SESSION));
  }

  @override
  Future<void> saveCurrentPassword({String currentPassword}) async {
    if (currentPassword != null) {
      await sharedPreferences.setString(CURRENT_PASSWORD, currentPassword);
    }
  }

  @override
  Future<void> saveNewPassword({String newPassword}) async {
    if (newPassword != null) {
      await sharedPreferences.setString(NEW_PASSWORD, newPassword);
    }
  }

  @override
  Future<void> saveConfirmNewPassword({String confirmNewPassword}) async {
    if (confirmNewPassword != null) {
      await sharedPreferences.setString(
          NEW_CONFIRM_PASSWORD, confirmNewPassword);
    }
  }

  @override
  Future<Map<String, dynamic>> getFortgotPasswrod() async {
    final password = sharedPreferences.getString("forgotPassword");
    final confirmPassword =
        sharedPreferences.getString("forgotConfirmPassword");
    Map<String, dynamic> passwordMap = {
      "password": password,
      "confirmPassword": confirmPassword
    };
    return passwordMap;
  }

  @override
  Future<void> deleteForgotPasswordAndOtp() async {
    Future.value(sharedPreferences.remove("forgotPassword"));

    Future.value(sharedPreferences.remove("forgotConfirmPassword"));

    Future.value(sharedPreferences.remove("forgotPasswordOtp"));
  }

  @override
  Future<void> saveOtp({String otp}) async {
    await sharedPreferences.setString("forgotPasswordOtp", otp);
  }

  @override
  Future<String> getOtp() async {
    return sharedPreferences.getString("forgotPasswordOtp");
  }

  @override
  Future<String> getForgotPasswordOtp() async {
    return sharedPreferences.getString(FORGOT_PASSWORD_OTP);
  }

  @override
  Future<void> saveForgotPasswordOtp({String otp}) async {
    await sharedPreferences.setString(FORGOT_PASSWORD_OTP, otp);
  }

  @override
  Future<void> saveEmail({String email}) async {
    if (email != null) {
      await sharedPreferences.setString(EMAIL, email);
    }
  }
}
