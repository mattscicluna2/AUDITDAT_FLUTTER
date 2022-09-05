import 'package:auditdat/db/model/template_check.dart';
import 'package:auditdat/db/model/template_field.dart';
import 'package:auditdat/db/model/template_page.dart';
import 'package:auditdat/db/model/template_section.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/template_check_repo.dart';
import 'package:auditdat/db/repo/template_field_repo.dart';
import 'package:auditdat/db/repo/template_page_repo.dart';
import 'package:auditdat/db/repo/template_section_repo.dart';
import 'package:auditdat/db/repo/template_version_repo.dart';

class TemplateComponentTableKeys {
  static const String tableName = 'template_components';

  static const List<String> values = [
    id,
    templateVersionId,
    pageId,
    parentSectionId,
    sectionId,
    checkId,
    fieldId,
    note,
    index
  ];

  static const String id = 'id';
  static const String templateVersionId = 'version_id';
  static const String pageId = 'page_id';
  static const String parentSectionId = 'parent_section_id';
  static const String sectionId = 'section_id';
  static const String checkId = 'check_id';
  static const String fieldId = 'field_id';
  static const String note = 'note';
  static const String index = 'position';
}

class TemplateComponent {
  final int id;
  final int templateVersionId;
  final int pageId;
  final int? parentSectionId;
  final int? sectionId;
  final int? checkId;
  final int? fieldId;
  final String? note;
  final int index;

  const TemplateComponent({
    required this.id,
    required this.templateVersionId,
    required this.pageId,
    this.parentSectionId,
    this.sectionId,
    this.checkId,
    this.fieldId,
    this.note,
    required this.index,
  });

  TemplateComponent copy({
    int? id,
  }) =>
      TemplateComponent(
        id: id ?? this.id,
        templateVersionId: templateVersionId,
        pageId: pageId,
        parentSectionId: parentSectionId,
        sectionId: sectionId,
        checkId: checkId,
        fieldId: fieldId,
        note: note,
        index: index,
      );


  Future<TemplateVersion?> version() async =>
      await TemplateVersionRepo.instance.get(templateVersionId);

  Future<TemplatePage?> page() async =>
      await TemplatePageRepo.instance.get(pageId);

  Future<TemplateSection?> parentSection() async =>
      parentSectionId != null ? await TemplateSectionRepo.instance.get(parentSectionId!): null;

  Future<TemplateSection?> section() async =>
      sectionId != null ? await TemplateSectionRepo.instance.get(sectionId!): null;

  Future<TemplateField?> field() async =>
      fieldId != null ? await TemplateFieldRepo.instance.get(fieldId!): null;

  Future<TemplateCheck?> check() async =>
      checkId != null ? await TemplateCheckRepo.instance.get(checkId!): null;


  static TemplateComponent fromJson(Map<String, Object?> json) => TemplateComponent(
    id: json[TemplateComponentTableKeys.id] as int,
    templateVersionId: json[TemplateComponentTableKeys.templateVersionId] as int,
    pageId: json[TemplateComponentTableKeys.pageId] as int,
    parentSectionId: json[TemplateComponentTableKeys.parentSectionId] as int?,
    sectionId: json[TemplateComponentTableKeys.sectionId] as int?,
    checkId: json[TemplateComponentTableKeys.checkId] as int?,
    fieldId: json[TemplateComponentTableKeys.fieldId] as int?,
    note: json[TemplateComponentTableKeys.note] as String?,
    index: json[TemplateComponentTableKeys.index] as int,
  );

  Map<String, Object?> toJson() => {
    TemplateComponentTableKeys.id: id,
    TemplateComponentTableKeys.templateVersionId: templateVersionId,
    TemplateComponentTableKeys.parentSectionId: parentSectionId,
    TemplateComponentTableKeys.sectionId: sectionId,
    TemplateComponentTableKeys.checkId: checkId,
    TemplateComponentTableKeys.fieldId: fieldId,
    TemplateComponentTableKeys.note: note,
    TemplateComponentTableKeys.index: index,
  };
}
