import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/error/exception.dart';
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/domain/entities/former_ward_entity.dart';

abstract class KycRemoteDataSource {
  Future<String> kycVerify(
      {Map<String, dynamic> data,
      String token,
      List<DocumentEntity> files,
      String userPhotoURL});
  Future<List<FormerWardEntity>> getFormerWards({String token});

  Future<UserEntity> getVerificationDetails({String token});
}

class IKycRemoteDataSource implements KycRemoteDataSource {
  final http.Client client;
  IKycRemoteDataSource({
    @required this.client,
  });

  @override
  Future<String> kycVerify(
      {Map<String, dynamic> data,
      String token,
      List<DocumentEntity> files,
      String userPhotoURL}) async {
    Uri _kycURL = Uri.parse(
        ApiConstants.BASE_URL + "api/v3/citizen_details_verifications");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

    var request = http.MultipartRequest('POST', _kycURL);
    request.headers.addAll(headers);
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    request.files.add(await http.MultipartFile.fromPath(
        'profile_image', userPhotoURL.toString()));
    // if (!files.isEmpty) {
    //   files.forEach((file) async {
    //     request.files.add(await http.MultipartFile.fromPath(
    //         'files[${file.title}]', file.url));
    //   });
    // }

    if (files.isNotEmpty) {
      files.forEach((file) {
        if (file.url != null) {
          request.files.add(
              http.MultipartFile.fromString("files[${file.title}]", file.url));
        }
      });
    }

    var result = await request.send();
    final kycResponse = await http.Response.fromStream(result);

    if (kycResponse.statusCode == 200) {
      Map<String, dynamic> mapData =
          Map<String, dynamic>.from(jsonDecode(kycResponse.body.toString()));
      if (mapData['error'].toString().contains("Please upload")) {
        throw ServerException(message: mapData['error']);
      }
      return mapData['message'].toString();
    } else if (kycResponse.statusCode >= 400 && kycResponse.statusCode < 500) {
      Map<String, dynamic> error =
          Map<String, dynamic>.from(jsonDecode(kycResponse.body.toString()));
      if (error != null && error.containsKey('Error')) {
        throw ServerException(message: error['Error']);
      }
      throw ServerException(message: kycResponse.body.toString());
    } else {
      throw ServerException(message: kycResponse.body.toString());
    }
  }

  @override
  Future<List<FormerWardEntity>> getFormerWards({String token}) async {
    Uri _formerURI =
        Uri.parse(ApiConstants.BASE_URL + "api/v3/former_municipalities");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final formerWardResponse = await http.get(_formerURI, headers: headers);
    if (formerWardResponse.statusCode == 200) {
      Map<String, dynamic> map = Map<String, dynamic>.from(
          jsonDecode(formerWardResponse.body.toString()));
      List<FormerWardEntity> formerWards = List<FormerWardEntity>.from(
          (map['array'] as List)
              .map((e) => FormerWardEntity.fromMap(e))
              .toList());
      return formerWards;
    } else {
      Map<String, dynamic> err = Map<String, dynamic>.from(
          jsonDecode(formerWardResponse.body.toString()));
      if (err != null && err.containsKey("message")) {
        throw ServerException(message: err['message']);
      } else {
        throw ServerException(message: "Unknown error");
      }
    }
  }

  @override
  Future<UserEntity> getVerificationDetails({String token}) async {
    Uri _uri = Uri.parse(
        ApiConstants.BASE_URL + "api/v3/citizen_details_verifications/new");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final response = await http.get(_uri, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> map =
          Map<String, dynamic>.from(jsonDecode(response.body.toString()));

      List<Map<String, dynamic>> documentsList =
          List<Map<String, dynamic>>.from(map['personal_documents'] as List);
      print(documentsList is List);
      List<DocumentEntity> documents = [];
      documentsList.forEach((element) {
        documents.add(DocumentEntity.fromMap(element));
      });
      UserEntity user = new UserEntity();
      if (map.containsKey("citizen_details")) {
        user = UserEntity.fromMap(map['citizen_details']);
        print("user is here $user");
        return user.copyWith(
          message: map['message'],
          personalDocs: documents,
        );
      } else {
        return user.copyWith(message: map['message'], personalDocs: documents);
      }
      // return UserEntity.fromMap(map);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(message: response.body.toString());
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      throw ServerException(message: response.body.toString());
    } else {
      throw ServerException(message: "Unknown Error");
    }
  }
}
