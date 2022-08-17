import 'package:auditdat/db/model/template.dart';
import 'package:auditdat/db/repo/template_repo.dart';

class TemplateCategoryTableKeys {
  static const String tableName = 'template_categories';

  static const List<String> values = [
    /// Add all fields
    id, name
  ];

  static const String id = 'id';
  static const String name = 'name';
}

class TemplateCategory {
  final int? id;
  final String name;

  const TemplateCategory({
    this.id,
    required this.name,
  });

  TemplateCategory copy({
    int? id,
    String? name,
  }) =>
      TemplateCategory(
        id: id ?? this.id,
        name: this.name,
      );


  //Category Relationship
  Future<List<Template>?> templates() async =>
      await TemplateRepo.instance.getAllByCategory(id ?? this.id);

  static TemplateCategory fromJson(Map<String, Object?> json) => TemplateCategory(
    id: json[TemplateCategoryTableKeys.id] as int?,
    name: json[TemplateCategoryTableKeys.name] as String,
  );

  Map<String, Object?> toJson() => {
    TemplateCategoryTableKeys.id: id,
    TemplateCategoryTableKeys.name: name,
  };
}