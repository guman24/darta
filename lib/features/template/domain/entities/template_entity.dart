import 'dart:convert';

import 'package:equatable/equatable.dart';

class TemplateEntity extends Equatable {
  final String id;
  final String title;
  final String icon;
  final String color;
  final List<String> applicant;
  final List<String> newAttributes;
  final String information;
  final List<String> requiredDocuments;
  final List<String> requiredSifarisDocuments;
  TemplateEntity({
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

  @override
  List<Object> get props => null;

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

  factory TemplateEntity.fromMap(Map<String, dynamic> map) {
    return TemplateEntity(
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

  factory TemplateEntity.fromMapForPaper(Map<String, dynamic> map) {
    return TemplateEntity(
      title: map['template']['title'],
      icon: map['template']['icon'],
      color: map['template']['color'],
    );
  }

  factory TemplateEntity.fromAnotherMap(Map<String, dynamic> map) {
    return TemplateEntity(
      id: map['id'],
      title: map['शीर्षक'],
      icon: map['आइकन'],
      color: map['रंग'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateEntity.fromJson(String source) =>
      TemplateEntity.fromMap(json.decode(source));
}
