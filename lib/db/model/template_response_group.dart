import 'package:auditdat/db/model/template_response.dart';
import 'package:auditdat/db/repo/template_response_repo.dart';

class TemplateResponseGroupTableKeys {
  static const String tableName = 'template_response_groups';

  static const List<String> values = [
    id,
  ];

  static const String id = 'id';
}

class TemplateResponseGroup {
  final int id;

  const TemplateResponseGroup({
    required this.id,
  });

  TemplateResponseGroup copy({
    int? id,
  }) =>
      TemplateResponseGroup(
        id: id ?? this.id,
      );

  Future<List<TemplateResponse>> responses() async =>
      await TemplateResponseRepo.instance.getAllByGroupId(id);

  static TemplateResponseGroup fromJson(Map<String, Object?> json) =>
      TemplateResponseGroup(
        id: json[TemplateResponseGroupTableKeys.id] as int,
      );

  Map<String, Object?> toJson() => {
        TemplateResponseGroupTableKeys.id: id,
      };
}
