import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.loginUseCase, @required this.fcm})
      : assert(loginUseCase != null),
        assert(fcm != null),
        super(LoginInitial());

  final LoginUseCase loginUseCase;
  final FirebaseMessaging fcm;
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    final fcmToken = await fcm.getToken();

    if (event is PerformLogin) {
      yield LoginLoading();
      final failOrLogin = await loginUseCase(LoginParams(
          email: event.data['email'],
          password: event.data['password'],
          fcm: fcmToken));
      yield* failOrLogin.fold((failure) async* {
        yield LoginFail(message: _mapFailureToMessage(failure));
      }, (login) async* {
        yield LoginSuccess();
      });
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.props.single;
        break;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
        break;
      case FormatFailure:
        return FORMAT_FAILURE_MESSAGE;
        break;
      default:
        return "Unexpected Error";
    }
  }
}
