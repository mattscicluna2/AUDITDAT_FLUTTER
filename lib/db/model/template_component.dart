import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/template_repo.dart';

class TemplateTableKeys {
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
  static const String index = 'index';
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

  //Category Relationship
  Future<TemplateVersion?> version() async =>
      await TemplateVersionRepo.instance.get(templateVersionId);

  //TODO Relationships; Page, section parentsection check, field

  static TemplateComponent fromJson(Map<String, Object?> json) => TemplateComponent(
    id: json[TemplateTableKeys.id] as int,
    templateVersionId: json[TemplateTableKeys.templateVersionId] as int,
    pageId: json[TemplateTableKeys.pageId] as int,
    parentSectionId: json[TemplateTableKeys.parentSectionId] as int,
    sectionId: json[TemplateTableKeys.sectionId] as int,
    checkId: json[TemplateTableKeys.checkId] as int,
    fieldId: json[TemplateTableKeys.fieldId] as int,
    note: json[TemplateTableKeys.note] as String,
    index: json[TemplateTableKeys.index] as int,
  );

  Map<String, Object?> toJson() => {
    TemplateTableKeys.id: id,
    TemplateTableKeys.templateVersionId: templateVersionId,
    TemplateTableKeys.parentSectionId: parentSectionId,
    TemplateTableKeys.sectionId: sectionId,
    TemplateTableKeys.checkId: checkId,
    TemplateTableKeys.fieldId: fieldId,
    TemplateTableKeys.note: note,
    TemplateTableKeys.index: index,
  };
}
