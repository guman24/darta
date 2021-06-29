import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/template/domain/entities/template_category_entity.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';

abstract class TemplateRepository {
  Future<Either<Failure, List<TemplateEntity>>> getTemplates({String token});
  Future<Either<Failure, List<TemplateCategoryEntity>>> getTemplatesCategory(
      {String token});
  Future<Either<Failure, List<TemplateEntity>>> getPopularTemplates(
      {String token});
}
