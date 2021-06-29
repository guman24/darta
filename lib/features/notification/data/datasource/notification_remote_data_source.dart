import 'dart:convert';
import 'dart:io';

import 'package:sifaris_app/core/constants/api_constant.dart';
import 'package:sifaris_app/core/error/exception.dart';
import 'package:sifaris_app/features/notification/domain/entities/notification_entity.dart';
import 'package:http/http.dart' as http;

abstract class NotificationRemoteDataSource {
  Future<List<NotificationEntity>> getNotifications({String token});
}

class INotificationRemoteDataSource implements NotificationRemoteDataSource {
  @override
  Future<List<NotificationEntity>> getNotifications({String token}) async {
    Uri _notificationURL =
        Uri.parse(ApiConstants.BASE_URL + "api/v3/notifications");
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

    var notificationResponse =
        await http.get(_notificationURL, headers: headers);

    if (notificationResponse.statusCode == 200) {
      final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(
          jsonDecode(notificationResponse.body.toString())["array"]);
      final List<NotificationEntity> notifications =
          List<NotificationEntity>.from(
              list.map((e) => NotificationEntity.fromMap(e)).toList());
      if (notifications.isEmpty) {
        throw ServerException(message: "No notifications found");
      }
      return notifications;
    } else if (notificationResponse.statusCode >= 400) {
      throw ServerException(
          message: jsonDecode(notificationResponse.body.toString()));
    } else {
      throw ServerException(message: "Unknown Error");
    }
  }
}
