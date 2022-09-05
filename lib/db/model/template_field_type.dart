import 'package:auditdat/db/model/template_response_group.dart';
import 'package:auditdat/db/repo/template_response_group_repo.dart';

class TemplateFieldTypeTableKeys {
  static const String tableName = 'template_field_types';

  static const List<String> values = [id, name];

  static const String id = 'id';
  static const String name = 'name';
}

class TemplateFieldType {
  final int id;
  final String name;

  const TemplateFieldType({
    required this.id,
    required this.name,
  });

  TemplateFieldType copy({
    int? id,
    String? name,
  }) =>
      TemplateFieldType(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  static TemplateFieldType fromJson(Map<String, Object?> json) =>
      TemplateFieldType(
        id: json[TemplateFieldTypeTableKeys.id] as int,
        name: json[TemplateFieldTypeTableKeys.name] as String,
      );

  Map<String, Object?> toJson() => {
        TemplateFieldTypeTableKeys.id: id,
        TemplateFieldTypeTableKeys.name: name,
      };
}
