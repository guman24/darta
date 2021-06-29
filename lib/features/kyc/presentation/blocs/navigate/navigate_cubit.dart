import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'navigate_state.dart';

class NavigateCubit extends Cubit<NavigateState> {
  NavigateCubit() : super(NavigateState(index: 0));

  void onNextPage({int value}) {
    value = value + 1;
    emit(NavigateState(index: value));
  }

  void onPreviousPage({int value}) {
    value = value - 1;
    emit(NavigateState(index: value));
  }
}
