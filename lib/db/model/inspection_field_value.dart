import 'package:auditdat/db/model/inspection_repeatable_section.dart';
import 'package:auditdat/db/model/template_field.dart';
import 'package:auditdat/db/repo/inspection_repeatable_section_repo.dart';
import 'package:auditdat/db/repo/template_field_repo.dart';

class InspectionFieldValueTableKeys {
  static const String tableName = 'inspection_field_values';

  static const List<String> values = [
    id,
    realId,
    inspectionId,
    repeatableSectionId,
    value,
    fileId,
    comments,
    createdAt,
    synced
  ];

  static const String id = 'id';
  static const String realId = 'real_id';
  static const String inspectionId = 'inspection_id';
  static const String templateFieldId = 'field_id';
  static const String repeatableSectionId = 'repeatable_section_id';
  static const String value = 'value';
  static const String fileId = 'file_id';
  static const String comments = 'comments';
  static const String createdAt = 'created_at';
  static const String synced = 'synced';
}

class InspectionFieldValue {
  final int? id;
  final int? realId;
  final int inspectionId;
  final int templateFieldId;
  final int? repeatableSectionId;
  final String? value;
  final int? fileId;
  final String? comments;
  final int createdAt;
  final bool synced;

  const InspectionFieldValue({
    this.id,
    this.realId,
    required this.inspectionId,
    required this.templateFieldId,
    this.repeatableSectionId,
    this.value,
    this.fileId,
    required this.comments,
    required this.createdAt,
    this.synced = false,
  });

  InspectionFieldValue copy({
    int? id,
    int? realId,
    int? inspectionId,
    int? templateFieldId,
    int? repeatableSectionId,
    String? value,
    int? fileId,
    String? comments,
    int? createdAt,
    bool? synced,
  }) =>
      InspectionFieldValue(
        id: id ?? this.id,
        realId: realId ?? this.realId,
        inspectionId: this.inspectionId,
        templateFieldId: this.templateFieldId,
        repeatableSectionId: repeatableSectionId ?? this.repeatableSectionId,
        value: value ?? this.value,
        fileId: fileId ?? this.fileId,
        comments: comments ?? this.comments,
        createdAt: this.createdAt,
        synced: synced ?? this.synced,
      );

  //TODO Relationships
  Future<TemplateField?> templateField() async =>
      await (TemplateFieldRepo.instance.get(templateFieldId));

  Future<InspectionRepeatableSection?> repeatableSection() async =>
      await (InspectionRepeatableSectionRepo.instance.get(repeatableSectionId));

  static InspectionFieldValue fromJson(Map<String, Object?> json) =>
      InspectionFieldValue(
        id: json[InspectionFieldValueTableKeys.id] as int,
        realId: json[InspectionFieldValueTableKeys.realId] as int?,
        inspectionId: json[InspectionFieldValueTableKeys.inspectionId] as int,
        templateFieldId:
            json[InspectionFieldValueTableKeys.templateFieldId] as int,
        repeatableSectionId:
            json[InspectionFieldValueTableKeys.repeatableSectionId] as int,
        value: json[InspectionFieldValueTableKeys.value] as String,
        fileId: json[InspectionFieldValueTableKeys.fileId] as int,
        comments: json[InspectionFieldValueTableKeys.comments] as String,
        createdAt: json[InspectionFieldValueTableKeys.createdAt] as int,
        synced: json[InspectionFieldValueTableKeys.synced] == 1,
      );

  Map<String, Object?> toJson() => {
        InspectionFieldValueTableKeys.id: id,
        InspectionFieldValueTableKeys.realId: realId,
        InspectionFieldValueTableKeys.inspectionId: inspectionId,
        InspectionFieldValueTableKeys.templateFieldId: templateFieldId,
        InspectionFieldValueTableKeys.repeatableSectionId: repeatableSectionId,
        InspectionFieldValueTableKeys.value: value,
        InspectionFieldValueTableKeys.fileId: fileId,
        InspectionFieldValueTableKeys.comments: comments,
        InspectionFieldValueTableKeys.createdAt: createdAt,
        InspectionFieldValueTableKeys.synced: synced,
      };
}
