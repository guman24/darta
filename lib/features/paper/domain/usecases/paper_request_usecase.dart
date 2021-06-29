import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/paper/domain/repositories/paper_repository.dart';

class PaperRequestUseCase extends UseCase<String, PaperRequstParams> {
  final PaperRepository paperRepository;
  PaperRequestUseCase({
    @required this.paperRepository,
  });
  @override
  Future<Either<Failure, String>> call(PaperRequstParams params) {
    return paperRepository.paperCreate(
        data: params.data,
        documents: params.documents,
        token: params.token,
        newAttributes: params.newAttributes);
  }
}

class PaperRequstParams {
  final Map<String, dynamic> data;
  final Map<String, dynamic> newAttributes;
  final List<DocumentEntity> documents;
  final String token;
  PaperRequstParams({
    @required this.data,
    @required this.newAttributes,
    @required this.documents,
    @required this.token,
  });
}
