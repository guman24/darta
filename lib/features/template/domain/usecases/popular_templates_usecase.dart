import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';
import 'package:sifaris_app/features/template/domain/respositories/template_repository.dart';

class PopularTemplatesUseCase extends UseCase<List<TemplateEntity>, String> {
  final TemplateRepository templateRepository;
  PopularTemplatesUseCase({
    @required this.templateRepository,
  });

  @override
  Future<Either<Failure, List<TemplateEntity>>> call(String params) {
    return templateRepository.getPopularTemplates(token: params);
  }
}
