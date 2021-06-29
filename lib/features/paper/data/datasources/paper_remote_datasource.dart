import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/error/exception.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';

abstract class PaperRemoteDataSource {
  Future<String> paperCreateRequest(
      {Map<String, dynamic> data,
      String token,
      List<DocumentEntity> documents,
      Map<String, dynamic> newAttributes});

  Future<List<PaperEntity>> getPapers({String token});
}

class IPaperRemoteDataSource implements PaperRemoteDataSource {
  final http.Client client;
  IPaperRemoteDataSource({
    @required this.client,
  });
  @override
  Future<String> paperCreateRequest(
      {Map<String, dynamic> data,
      String token,
      List<DocumentEntity> documents,
      Map<String, dynamic> newAttributes}) async {
    print("user data *** $data");
    Uri paperRequestURI = Uri.parse(ApiConstants.BASE_URL + "api/v3/papers");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    var request = http.MultipartRequest('POST', paperRequestURI);
    request.headers.addAll(headers);
    // request.fields['template_id'] = "60bda14ffd89785a602e4710";
    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value;
      }
    });
    if (newAttributes != null) {
      newAttributes.forEach((key, value) {
        request.fields[key] = value;
      });
    }

    // if (documents.isNotEmpty) {
    //   documents.forEach((file) async {
    //     request.files.add(await http.MultipartFile.fromPath(
    //         'files[${file.title}]', file.url));
    //   });
    // }
    if (documents.isNotEmpty) {
      documents.forEach((file) {
        request.files.add(
            http.MultipartFile.fromString("files[${file.title}]", file.url));
      });
    }
    var result = await request.send();
    var createResponse = await http.Response.fromStream(result);
    print(createResponse.statusCode);
    if (createResponse.statusCode == 200) {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(jsonDecode(createResponse.body.toString()));
      return data['message'].toString();
    } else if (createResponse.statusCode >= 500 &&
        createResponse.statusCode < 600) {
      throw ServerException(message: createResponse.body.toString());
    } else if (createResponse.statusCode >= 400 &&
        createResponse.statusCode < 500) {
      Map<String, dynamic> error =
          Map<String, dynamic>.from(jsonDecode(createResponse.body.toString()));
      // throw ServerException(message: error['message'].toString());

      if (error != null) {
        throw ServerException(message: error['message'].toString());
      }
      throw ServerException(
          message: jsonDecode(createResponse.body.toString())['error']);
    } else {
      throw ServerException(message: "Unknown Error");
    }
  }

  @override
  Future<List<PaperEntity>> getPapers({String token}) async {
    Uri _paperURL = Uri.parse(ApiConstants.BASE_URL + "api/v3/papers");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

    final paperResponse = await http.get(_paperURL, headers: headers);
    final Map<String, dynamic> data =
        Map<String, dynamic>.from(jsonDecode(paperResponse.body.toString()));
    if (paperResponse.statusCode == 200) {
      final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(
          jsonDecode(paperResponse.body.toString())['data']);
      final List<PaperEntity> papers = List<PaperEntity>.from(
          list.map((e) => PaperEntity.fromMap(e)).toList());
      if (papers.length > 0) {
        return papers;
      } else {
        throw ServerException(message: "No Papers Found");
      }
    } else if (paperResponse.statusCode >= 400) {
      throw ServerException(message: jsonDecode(paperResponse.body.toString()));
    } else {
      throw ServerException(message: "Unknown Error");
    }
  }
}
