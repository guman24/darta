import 'package:sifaris_app/core/constants/text_constant.dart';

class ServerException implements Exception {
  final String message;
  ServerException({
    this.message = SERVER_FAILURE_MESSAGE,
  });
}

class CacheException implements Exception {
  final String message;
  CacheException({
    this.message = CACHE_FAILURE_MESSAGE,
  });
}
