import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(null);

  void startCounter(int count) {
    while (count >= 0) {
      emit(count);
      Future.delayed(Duration(seconds: 1));
      count--;
    }
  }
}
