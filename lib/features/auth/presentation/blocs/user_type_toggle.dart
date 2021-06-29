import 'package:flutter_bloc/flutter_bloc.dart';

class UserTypeToggleCubit extends Cubit<String> {
  UserTypeToggleCubit() : super("Permanent");

  void changeType({String value}) {
    emit(value);
  }
}
