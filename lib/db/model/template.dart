import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';

class TemplateTableKeys {
  static const String tableName = 'templates';

  static const List<String> values = [
    id, categoryId, name, version
  ];

  static const String id = 'id';
  static const String categoryId = 'category_id';
  static const String name = 'name';
  static const String version = 'version';
}

class Template {
  final int? id;
  final int categoryId;
  final String name;
  final String version;

  const Template({
    this.id,
    required this.categoryId,
    required this.name,
    required this.version,
  });

  Template copy({
    int? id,
    String? name,
  }) =>
      Template(
        id: id ?? this.id,
        categoryId: this.categoryId,
        name: this.name,
        version: this.version,
      );

  //Category Relationship
  Future<TemplateCategory> category() async =>
      await TemplateCategoryRepo.instance.get(categoryId);

  static Template fromJson(Map<String, Object?> json) => Template(
    id: json[TemplateTableKeys.id] as int?,
    categoryId: json[TemplateTableKeys.categoryId] as int,
    name: json[TemplateTableKeys.name] as String,
    version: json[TemplateTableKeys.version] as String,
  );

  Map<String, Object?> toJson() => {
    TemplateTableKeys.id: id,
    TemplateTableKeys.categoryId: categoryId,
    TemplateTableKeys.name: name,
    TemplateTableKeys.version: version,
  };
}