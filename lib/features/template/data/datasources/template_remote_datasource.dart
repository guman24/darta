import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/error/exception.dart';
import 'package:sifaris_app/features/template/domain/entities/template_category_entity.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';

abstract class TemplateRemoteSource {
  Future<List<TemplateEntity>> getTempaltes({String token});
  Future<List<TemplateCategoryEntity>> getTemplatesCategory({String token});
  Future<List<TemplateEntity>> getPopularTempates({String token});
}

class ITemplateRemoteSource implements TemplateRemoteSource {
  final http.Client client;
  ITemplateRemoteSource({
    @required this.client,
  });

  @override
  Future<List<TemplateEntity>> getTempaltes({String token}) async {
    Uri _templateURI = Uri.parse(ApiConstants.BASE_URL + "api/v3/templates");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final templateResponse = await http.get(_templateURI, headers: headers);
    if (templateResponse.statusCode == 200) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(
          jsonDecode(templateResponse.body.toString()));
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(mapData['data'] as List);
      if (data != null && data.isNotEmpty) {
        return data.map((e) => TemplateEntity.fromMap(e)).toList();
      } else {
        throw ServerException(message: "No Templates Found");
      }
    } else if (templateResponse.statusCode >= 400 &&
        templateResponse.statusCode < 500) {
      throw ServerException(message: templateResponse.body.toString());
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TemplateCategoryEntity>> getTemplatesCategory(
      {String token}) async {
    Uri _templateURI = Uri.parse(
        ApiConstants.BASE_URL + "api/v3/templates/group_wise_templates");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

    final templateResponse = await http.get(_templateURI, headers: headers);

    if (templateResponse.statusCode == 200) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(
          jsonDecode(templateResponse.body.toString()));
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(mapData['data'] as List);
      if (data != null && data.isNotEmpty) {
        return data.map((e) => TemplateCategoryEntity.fromMap(e)).toList();
      } else {
        throw ServerException(message: "No Templates Found");
      }
    } else if (templateResponse.statusCode >= 400 &&
        templateResponse.statusCode < 500) {
      throw ServerException(message: templateResponse.body.toString());
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TemplateEntity>> getPopularTempates({String token}) async {
    Uri _templateURI =
        Uri.parse(ApiConstants.BASE_URL + "api/v3/templates/popular_templates");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final templateResponse = await http.get(_templateURI, headers: headers);
    if (templateResponse.statusCode == 200) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(
          jsonDecode(templateResponse.body.toString()));
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(mapData['data'] as List);
      if (data != null && data.isNotEmpty) {
        return data.map((e) => TemplateEntity.fromMap(e)).toList();
      } else {
        throw ServerException(message: "No Templates Found");
      }
    } else if (templateResponse.statusCode >= 400 &&
        templateResponse.statusCode < 500) {
      throw ServerException(message: templateResponse.body.toString());
    } else {
      throw ServerException();
    }
  }
}
