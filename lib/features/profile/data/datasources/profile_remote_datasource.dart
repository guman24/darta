import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/error/exception.dart';

import 'package:sifaris_app/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileEntity> getProfile({String token});
}

class IProfileRemoteDataSource implements ProfileRemoteDataSource {
  final http.Client client;
  IProfileRemoteDataSource({
    @required this.client,
  });

  @override
  Future<ProfileEntity> getProfile({String token}) async {
    Uri _profileUri = Uri.parse(ApiConstants.BASE_URL + "api/v3/users/profile");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final profileResponse = await http.get(_profileUri, headers: headers);
    final Map<String, dynamic> data =
        Map<String, dynamic>.from(jsonDecode(profileResponse.body.toString()));
    if (profileResponse.statusCode == 200) {
      final Map<String, dynamic> map = Map<String, dynamic>.from(
          jsonDecode(profileResponse.body.toString()));
      ProfileEntity profileEntity = ProfileEntity.fromMap(map);
      return profileEntity;
    } else if (profileResponse.statusCode > 400 &&
        profileResponse.statusCode <= 600) {
      throw ServerException(message: data['error']);
    } else {
      throw ServerException();
    }
  }
}
