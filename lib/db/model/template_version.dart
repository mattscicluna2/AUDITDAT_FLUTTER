import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';

class TemplateVersionTableKeys {
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
    int? templateId,
    int? categoryId,
    String? name,
    String? version,
    bool? downloaded,
  }) =>
      TemplateVersion(
        id: id ?? this.id,
        templateId: templateId ?? this.templateId,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        version: version ?? this.version,
        downloaded: downloaded ?? this.downloaded,
      );

  //Category Relationship
  Future<TemplateCategory?> category() async =>
      await TemplateCategoryRepo.instance.get(categoryId);

  static TemplateVersion fromJson(Map<String, Object?> json) => TemplateVersion(
        id: json[TemplateVersionTableKeys.id] as int,
        templateId: json[TemplateVersionTableKeys.templateId] as int,
        categoryId: json[TemplateVersionTableKeys.categoryId] as int,
        name: json[TemplateVersionTableKeys.name] as String,
        version: json[TemplateVersionTableKeys.version] as String,
        downloaded:
            json[TemplateVersionTableKeys.downloaded] == 1 ? true : false,
      );

  Map<String, Object?> toJson() => {
        TemplateVersionTableKeys.id: id,
        TemplateVersionTableKeys.templateId: templateId,
        TemplateVersionTableKeys.categoryId: categoryId,
        TemplateVersionTableKeys.name: name,
        TemplateVersionTableKeys.version: version,
        TemplateVersionTableKeys.downloaded: downloaded ? 1 : 0,
      };
}
