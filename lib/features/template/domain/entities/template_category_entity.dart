import 'dart:convert';

import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';

class TemplateCategoryEntity {
  final String categoryName;
  final List<TemplateEntity> templates;
  TemplateCategoryEntity({
    this.categoryName,
    this.templates,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'templates': templates?.map((x) => x.toMap())?.toList(),
    };
  }

  factory TemplateCategoryEntity.fromMap(Map<String, dynamic> map) {
    return TemplateCategoryEntity(
      categoryName: map['category_name'],
      templates: List<TemplateEntity>.from(
          map['template_list']?.map((x) => TemplateEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateCategoryEntity.fromJson(String source) =>
      TemplateCategoryEntity.fromMap(json.decode(source));
}
