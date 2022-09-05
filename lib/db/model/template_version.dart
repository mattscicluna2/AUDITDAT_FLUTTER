import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';

class TemplateTableKeys {
  static const String tableName = 'template_versions';

  static const List<String> values = [
    id,
    categoryId,
    name,
    version,
    templateId,
    downloaded,
  ];

  static const String id = 'id';
  static const String categoryId = 'category_id';
  static const String templateId = 'template_id';
  static const String name = 'name';
  static const String version = 'version';
  static const String downloaded = 'downloaded';
}

class TemplateVersion {
  final int id;
  final int templateId;
  final int categoryId;
  final String name;
  final String version;
  final bool downloaded;

  const TemplateVersion({
    required this.id,
    required this.templateId,
    required this.categoryId,
    required this.name,
    required this.version,
    this.downloaded = false,
  });

  TemplateVersion copy({
    int? id,
  }) =>
      TemplateVersion(
        id: id ?? this.id,
        templateId: templateId,
        categoryId: categoryId,
        name: name,
        version: version,
        downloaded: downloaded,
      );

  //Category Relationship
  Future<TemplateCategory?> category() async =>
      await TemplateCategoryRepo.instance.get(categoryId);

  static TemplateVersion fromJson(Map<String, Object?> json) => TemplateVersion(
        id: json[TemplateTableKeys.id] as int,
        templateId: json[TemplateTableKeys.templateId] as int,
        categoryId: json[TemplateTableKeys.categoryId] as int,
        name: json[TemplateTableKeys.name] as String,
        version: json[TemplateTableKeys.version] as String,
        downloaded: json[TemplateTableKeys.downloaded] == 1 ? true : false,
      );

  Map<String, Object?> toJson() => {
        TemplateTableKeys.id: id,
        TemplateTableKeys.templateId: templateId,
        TemplateTableKeys.categoryId: categoryId,
        TemplateTableKeys.name: name,
        TemplateTableKeys.version: version,
        TemplateTableKeys.downloaded: downloaded,
      };
}
