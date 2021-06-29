import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';
import 'package:sifaris_app/features/template/domain/respositories/template_repository.dart';

class AllTemplatesUseCase extends UseCase<List<TemplateEntity>, String> {
  final TemplateRepository templateRepository;
  AllTemplatesUseCase({
    @required this.templateRepository,
  });

  @override
  Future<Either<Failure, List<TemplateEntity>>> call(String params) {
    return templateRepository.getTemplates(token: params);
  }
}
