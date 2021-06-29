import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/data/models/organization_model.dart';
import 'package:sifaris_app/core/error/exception.dart';

abstract class RemoteDataSource {
  Future<List<OrganizationModel>> getOrganization();
}

class IRemoteDataSouce implements RemoteDataSource {
  final http.Client client;
  IRemoteDataSouce({
    @required this.client,
  });

  @override
  Future<List<OrganizationModel>> getOrganization() async {
    Uri orgURL = Uri.parse(ApiConstants.BASE_URL + "api/v3/signup/new");
    final orgResponse = await http.get(orgURL);

    if (orgResponse.statusCode == 200) {
      Map<String, dynamic> map =
          Map<String, dynamic>.from(jsonDecode(orgResponse.body.toString()));
      List<OrganizationModel> organizations = List<OrganizationModel>.from(
          (map['organization'] as List)
              .map((e) => OrganizationModel.fromMap(e))
              .toList());
      return organizations;
    } else if (orgResponse.statusCode == 400) {
      Map<String, dynamic> mapData =
          Map<String, dynamic>.from(jsonDecode(orgResponse.body.toString()));
      throw ServerException(message: mapData['message']);
    } else {
      throw ServerException();
    }
  }
}
