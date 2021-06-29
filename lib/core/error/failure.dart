import 'package:equatable/equatable.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

// General Failures
class ServerFailure extends Failure {
  final String message;
  ServerFailure({
    this.message = SERVER_FAILURE_MESSAGE,
  });
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => throw UnimplementedError();
}

class FormatFailure extends Failure {
  @override
  List<Object> get props => throw UnimplementedError();
}
