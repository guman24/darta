import 'package:flutter/material.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/template/domain/entities/template_category_entity.dart';
import 'package:sifaris_app/features/template/domain/respositories/template_repository.dart';

class CategoryTemplateUseCase
    extends UseCase<List<TemplateCategoryEntity>, String> {
  final TemplateRepository templateRepository;
  CategoryTemplateUseCase({
    @required this.templateRepository,
  });
  @override
  Future<Either<Failure, List<TemplateCategoryEntity>>> call(String params) {
    return templateRepository.getTemplatesCategory(token: params);
  }
}
