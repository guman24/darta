import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/error/exception.dart';

import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';

abstract class NoticeRemoteDataSource {
  Future<List<NoticeEntity>> getNotices({String token});
}

class INoticeRemoteDataSource implements NoticeRemoteDataSource {
  final http.Client client;
  INoticeRemoteDataSource({
    @required this.client,
  });

  @override
  Future<List<NoticeEntity>> getNotices({String token}) async {
    Uri _noticeURI = Uri.parse(ApiConstants.BASE_URL + "api/v3/information/");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    var noticeResponse = await http.get(_noticeURI, headers: headers);
    if (noticeResponse.statusCode == 200) {
      final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(
          jsonDecode(noticeResponse.body.toString())['informations']);
      final List<NoticeEntity> notices = List<NoticeEntity>.from(
          list.map((e) => NoticeEntity.fromMap(e)).toList());
      if (notices.isEmpty) {
        throw ServerException(message: "नोटिस फेला परेन");
      }
      return notices;
    } else if (noticeResponse.statusCode >= 400) {
      throw ServerException(
          message: jsonDecode(noticeResponse.body.toString()));
    } else {
      throw ServerException();
    }
  }
}
