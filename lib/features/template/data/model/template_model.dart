import 'dart:convert';

import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';

class TemplateModel extends TemplateEntity {
  final String id;
  final String title;
  final String icon;
  final String color;
  final List<String> applicant;
  final List<String> newAttributes;
  final String information;
  final List<String> requiredDocuments;
  final List<String> requiredSifarisDocuments;
  TemplateModel({
    this.id,
    this.title,
    this.icon,
    this.color,
    this.applicant,
    this.newAttributes,
    this.information,
    this.requiredDocuments,
    this.requiredSifarisDocuments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'color': color,
      'applicant': applicant,
      'newAttributes': newAttributes,
      'information': information,
      'requiredDocuments': requiredDocuments,
      'requiredSifarisDocuments': requiredSifarisDocuments,
    };
  }

  factory TemplateModel.fromMap(Map<String, dynamic> map) {
    return TemplateModel(
      id: map['id'],
      title: map['शीर्षक'],
      icon: map['आइकन'],
      color: map['रंग'],
      applicant: List<String>.from(map['applicant']),
      newAttributes: List<String>.from(map['नयाँ क्षेत्र']),
      information: map['जानकारी'],
      requiredDocuments: List<String>.from(map['आवश्यक कागजातहरू']),
      requiredSifarisDocuments:
          List<String>.from(map['आवश्यक सिफारिस कागजातहरू']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateModel.fromJson(String source) =>
      TemplateModel.fromMap(json.decode(source));
}
