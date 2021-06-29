import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';

class PaperEntity extends Equatable {
  PaperEntity({
    this.id,
    this.data,
    this.nepaliDate,
    this.nepaliMonthName,
    this.nepaliMonth,
    this.nepaliYear,
    this.groupId,
    this.photoFileName,
    this.status,
    this.templateEntity,
  });

  @override
  List<Object> get props => [];

  final String id;
  final String data;
  final String nepaliDate;
  final String nepaliMonthName;
  final String nepaliMonth;
  final String nepaliYear;
  final String groupId;
  final String photoFileName;
  final String status;
  final TemplateEntity templateEntity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'nepaliDate': nepaliDate,
      'nepaliMonthName': nepaliMonthName,
      'nepaliMonth': nepaliMonth,
      'nepaliYear': nepaliYear,
      'groupId': groupId,
      'photoFileName': photoFileName,
      'status': status,
      'template': templateEntity.toMap(),
    };
  }

  factory PaperEntity.fromMap(Map<String, dynamic> map) {
    return PaperEntity(
      id: map['id'],
      data: map['data'],
      nepaliDate: map['nepali_date'],
      nepaliMonthName: map['nepali_month_name'],
      nepaliMonth: map['nepali_month'],
      nepaliYear: map['nepali_year'],
      groupId: map['group_id'],
      photoFileName: map['photo_file_name'],
      status: map['status'],
      templateEntity: TemplateEntity.fromMapForPaper(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaperEntity.fromJson(String source) =>
      PaperEntity.fromMap(json.decode(source));
}
