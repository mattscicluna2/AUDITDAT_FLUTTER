import 'package:auditdat/db/model/inspection.dart';
import 'package:auditdat/db/model/inspection_repeatable_section.dart';
import 'package:auditdat/db/model/template_check.dart';
import 'package:auditdat/db/model/template_response.dart';
import 'package:auditdat/db/repo/inspection_repeatable_section_repo.dart';
import 'package:auditdat/db/repo/inspection_repo.dart';
import 'package:auditdat/db/repo/template_check_repo.dart';
import 'package:auditdat/db/repo/template_response_repo.dart';

class InspectionCheckTableKeys {
  static const String tableName = 'inspection_checks';

  static const List<String> values = [
    id,
    realId,
    inspectionId,
    templateCheckId,
    repeatableSectionId,
    notApplicable,
    responseId,
    comments,
    createdAt,
    synced
  ];

  static const String id = 'id';
  static const String realId = 'real_id';
  static const String inspectionId = 'inspection_id';
  static const String templateCheckId = 'check_id';
  static const String repeatableSectionId = 'repeatable_section_id';
  static const String notApplicable = 'not_applicable';
  static const String responseId = 'response_id';
  static const String comments = 'comments';
  static const String createdAt = 'created_at';
  static const String synced = 'synced';
}

class InspectionCheck {
  final int? id;
  final int? realId;
  final int inspectionId;
  final int templateCheckId;
  final int? repeatableSectionId;
  final bool notApplicable;
  final int? responseId;
  final String? comments;
  final int createdAt;
  final bool synced;

  const InspectionCheck({
    this.id,
    this.realId,
    required this.inspectionId,
    required this.templateCheckId,
    this.repeatableSectionId,
    required this.notApplicable,
    this.responseId,
    this.comments,
    required this.createdAt,
    this.synced = false,
  });

  InspectionCheck copy({
    int? id,
    int? realId,
    int? inspectionId,
    int? templateCheckId,
    int? repeatableSectionId,
    bool? notApplicable,
    int? responseId,
    String? comments,
    int? createdAt,
    bool? synced,
  }) =>
      InspectionCheck(
        id: id ?? this.id,
        realId: realId ?? this.realId,
        inspectionId: this.inspectionId,
        templateCheckId: this.templateCheckId,
        repeatableSectionId: repeatableSectionId ?? this.repeatableSectionId,
        notApplicable: notApplicable ?? this.notApplicable,
        responseId: responseId ?? this.responseId,
        comments: comments ?? this.comments,
        createdAt: this.createdAt,
        synced: synced ?? this.synced,
      );

  //Relationships
  Future<Inspection?> inspection() async =>
      await (InspectionRepo.instance.get(inspectionId));

  Future<TemplateCheck?> templateCheck() async =>
      await (TemplateCheckRepo.instance.get(templateCheckId));

  Future<InspectionRepeatableSection?> repeatableSection() async =>
      await (InspectionRepeatableSectionRepo.instance.get(repeatableSectionId));

  Future<TemplateResponse?> response() async =>
      await (TemplateResponseRepo.instance.get(responseId));

  static InspectionCheck fromJson(Map<String, Object?> json) => InspectionCheck(
        id: json[InspectionCheckTableKeys.id] as int,
        realId: json[InspectionCheckTableKeys.realId] as int?,
        inspectionId: json[InspectionCheckTableKeys.inspectionId] as int,
        templateCheckId: json[InspectionCheckTableKeys.templateCheckId] as int,
        repeatableSectionId:
            json[InspectionCheckTableKeys.repeatableSectionId] as int?,
        notApplicable: json[InspectionCheckTableKeys.notApplicable] == 1,
        responseId: json[InspectionCheckTableKeys.responseId] as int?,
        comments: json[InspectionCheckTableKeys.comments] as String?,
        createdAt: json[InspectionCheckTableKeys.createdAt] as int,
        synced: json[InspectionCheckTableKeys.synced] == 1,
      );

  Map<String, Object?> toJson() => {
        InspectionCheckTableKeys.id: id,
        InspectionCheckTableKeys.realId: realId,
        InspectionCheckTableKeys.inspectionId: inspectionId,
        InspectionCheckTableKeys.templateCheckId: templateCheckId,
        InspectionCheckTableKeys.repeatableSectionId: repeatableSectionId,
        InspectionCheckTableKeys.notApplicable: notApplicable,
        InspectionCheckTableKeys.responseId: responseId,
        InspectionCheckTableKeys.comments: comments,
        InspectionCheckTableKeys.createdAt: createdAt,
        InspectionCheckTableKeys.synced: synced,
      };
}
