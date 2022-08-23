import 'dart:convert';

import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/template_repo.dart';

class TemplateCategoryTableKeys {
  static const String tableName = 'template_categories';

  static const List<String> values = [
    /// Add all fields
    id, name
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String deleted = 'deleted';
}

class TemplateCategory {
  final int id;
  final String name;
  final bool? deleted;

  const TemplateCategory({
    required this.id,
    required this.name,
    this.deleted = false,
  });

  TemplateCategory copy({
    int? id,
    String? name,
  }) =>
      TemplateCategory(
          id: id ?? this.id, name: this.name, deleted: this.deleted);

  //Category Relationship
  Future<List<TemplateVersion>?> templates() async =>
      await TemplateRepo.instance.getAllByCategory(id);

  static TemplateCategory fromJson(Map<String, Object?> json) =>
      TemplateCategory(
        id: json[TemplateCategoryTableKeys.id] as int,
        name: json[TemplateCategoryTableKeys.name] as String,
        deleted: json[TemplateCategoryTableKeys.deleted] as bool?,
      );

  Map<String, Object?> toJson() => {
        TemplateCategoryTableKeys.id: id,
        TemplateCategoryTableKeys.name: name,
      };

  static List<TemplateCategory> decode(String categories) =>
      (json.decode(categories) as List<dynamic>)
          .map<TemplateCategory>((item) => TemplateCategory.fromJson(item))
          .toList();
}
