import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';

abstract class PaperRepository {
  Future<Either<Failure, String>> paperCreate({
    Map<String, dynamic> data,
    String token,
    List<DocumentEntity> documents,
    Map<String, dynamic> newAttributes,
  });
  Future<Either<Failure, List<PaperEntity>>> getPapers({
    String token,
  });
}
