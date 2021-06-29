import 'package:flutter_bloc/flutter_bloc.dart';

class GenderCubit extends Cubit<String> {
  GenderCubit() : super("Male");

  void changeGender({String value}) {
    emit(value);
  }

  void init({String value}) {
    emit(value);
  }
}
