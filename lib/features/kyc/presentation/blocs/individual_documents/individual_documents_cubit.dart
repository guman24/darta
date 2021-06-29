import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/individual_documents_usecase.dart';

part 'individual_documents_state.dart';

class IndividualDocumentsCubit extends Cubit<IndividualDocumentsState> {
  IndividualDocumentsCubit({@required this.individualDocumnetsUseCase})
      : super(IndividualDocumentsState(individualDocs: null, error: null));

  final IndividualDocumnetsUseCase individualDocumnetsUseCase;

  void getIndividualDocuments() async {
    final failOrDocs = await individualDocumnetsUseCase(null);
    print("***final check $failOrDocs");
    failOrDocs.fold((fail) async {
      emit(IndividualDocumentsState(
          individualDocs: null, error: fail.props.single));
    }, (docs) async {
      emit(IndividualDocumentsState(individualDocs: docs, error: null));
    });
  }
}
