import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';

import 'package:sifaris_app/features/profile/data/local_profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<void> saveProfile({LocalProfileModel profile});
  Future<LocalProfileModel> getProfile();
  Future<void> clearProfile();
}

class IProfileLocalDataSource implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;
  IProfileLocalDataSource({
    @required this.sharedPreferences,
  });

  @override
  Future<LocalProfileModel> getProfile() async {
    final jsonString = sharedPreferences.getString(USER_PREF);
    print("**json $jsonString");
    if (jsonString != null) {
      return Future.value(LocalProfileModel.fromJson(json.decode(jsonString)));
    } else {
      // throw CacheException;
      return null;
    }
  }

  @override
  Future<void> saveProfile({LocalProfileModel profile}) {
    return sharedPreferences.setString(USER_PREF, json.encode(profile));
  }

  @override
  Future<void> clearProfile() {
    return Future.value(sharedPreferences.remove(USER_PREF));
  }
}
