import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'templates_toggle_state.dart';

class TemplatesToggleCubit extends Cubit<TemplatesToggleState> {
  TemplatesToggleCubit()
      : super(TemplatesToggleState(
            isRandomTemplates: false, isCategoryTemplates: false));
  void init({String type}) {
    if (type == "random")
      emit(TemplatesToggleState(
          isRandomTemplates: true, isCategoryTemplates: false));
    if (type == "category")
      emit(TemplatesToggleState(
          isRandomTemplates: false, isCategoryTemplates: true));
  }

  void randomToggle() => emit(TemplatesToggleState(
      isRandomTemplates: true, isCategoryTemplates: false));
  void categoryToggle() => emit(TemplatesToggleState(
      isRandomTemplates: false, isCategoryTemplates: true));
}
