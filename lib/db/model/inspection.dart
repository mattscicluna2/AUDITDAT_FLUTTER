import 'package:auditdat/db/model/inspection_check.dart';
import 'package:auditdat/db/model/inspection_field_value.dart';
import 'package:auditdat/db/model/inspection_status.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/inspection_check_repo.dart';
import 'package:auditdat/db/repo/inspection_field_value_repo.dart';
import 'package:auditdat/db/repo/inspection_status_repo.dart';
import 'package:auditdat/db/repo/template_version_repo.dart';

class InspectionTableKeys {
  static const String tableName = 'inspections';

  static const List<String> values = [
    id,
    realId,
    templateVersionId,
    reportDate,
    customerId,
    siteId,
    statusId,
    createdAt,
    synced
  ];

  static const String id = 'id';
  static const String realId = 'real_id';
  static const String templateVersionId = 'template_version_id';
  static const String reportDate = 'report_date';
  static const String customerId = 'customer_id';
  static const String siteId = 'site_id';
  static const String statusId = 'status_id';
  static const String createdAt = 'created_at';
  static const String synced = 'synced';
}

class Inspection {
  final int? id;
  final int? realId;
  final int templateVersionId;
  final String? reportDate;
  final int? siteId;
  final int? customerId;
  final int statusId;
  final int createdAt;
  final bool synced;

  const Inspection({
    this.id,
    this.realId,
    required this.templateVersionId,
    this.reportDate,
    this.siteId,
    this.customerId,
    required this.statusId,
    required this.createdAt,
    this.synced = false,
  });

  Inspection copy({
    int? id,
    int? realId,
    int? templateVersionId,
    String? reportDate,
    int? siteId,
    int? customerId,
    int? statusId,
    String? createdAt,
    bool? synced,
  }) =>
      Inspection(
        id: id ?? this.id,
        realId: realId ?? this.realId,
        templateVersionId: templateVersionId ?? this.templateVersionId,
        reportDate: reportDate ?? this.reportDate,
        siteId: siteId ?? this.siteId,
        customerId: customerId ?? this.customerId,
        statusId: statusId ?? this.statusId,
        createdAt: this.createdAt,
        synced: synced ?? this.synced,
      );

  //Relationships
  Future<List<InspectionCheck>> checks() async =>
      await InspectionCheckRepo.instance.getAll(id!);

  Future<List<InspectionFieldValue>> fields() async =>
      await InspectionFieldValueRepo.instance.getAll(id!);

  Future<TemplateVersion?> templateVersion() async =>
      await TemplateVersionRepo.instance.get(templateVersionId);

  Future<InspectionStatus?> status() async =>
      await InspectionStatusRepo.instance.get(statusId);

  static Inspection fromJson(Map<String, Object?> json) => Inspection(
        id: json[InspectionTableKeys.id] as int,
        realId: json[InspectionTableKeys.realId] as int?,
        templateVersionId: json[InspectionTableKeys.templateVersionId] as int,
        reportDate: json[InspectionTableKeys.reportDate] as String?,
        siteId: json[InspectionTableKeys.siteId] as int?,
        customerId: json[InspectionTableKeys.customerId] as int?,
        statusId: json[InspectionTableKeys.statusId] as int,
        createdAt: json[InspectionTableKeys.createdAt] as int,
        synced: json[InspectionTableKeys.synced] == 1,
      );

  Map<String, Object?> toJson() => {
        InspectionTableKeys.id: id,
        InspectionTableKeys.realId: realId,
        InspectionTableKeys.templateVersionId: templateVersionId,
        InspectionTableKeys.reportDate: reportDate,
        InspectionTableKeys.siteId: siteId,
        InspectionTableKeys.customerId: customerId,
        InspectionTableKeys.statusId: statusId,
        InspectionTableKeys.createdAt: createdAt,
        InspectionTableKeys.synced: synced,
      };
}
