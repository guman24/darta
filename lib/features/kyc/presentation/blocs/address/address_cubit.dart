import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressState(permanent: false, temporary: false));

  void sameAsPermanent(bool value) =>
      emit(AddressState(permanent: value, temporary: false));
  void sameAsTemporary(bool value) =>
      emit(AddressState(permanent: false, temporary: value));
}
