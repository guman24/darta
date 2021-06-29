import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/injection.dart';

class EmailCubit extends Cubit<String> {
  EmailCubit() : super(null);

  final AuthLocalDataSource _localDataSource = getIt<AuthLocalDataSource>();

  void emailValidate(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (email != null && RegExp(p).hasMatch(email)) {
      _localDataSource.saveEmail(email: email);
      emit(email);
    } else {
      emit(null);
    }
  }
}
