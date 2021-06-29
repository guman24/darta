import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';
import 'package:sifaris_app/features/paper/domain/repositories/paper_repository.dart';

class GetPapersUseCase extends UseCase<List<PaperEntity>, String> {
  final PaperRepository paperRepository;

  GetPapersUseCase(this.paperRepository);
  @override
  Future<Either<Failure, List<PaperEntity>>> call(String params) {
    return paperRepository.getPapers(token: params);
  }
}
