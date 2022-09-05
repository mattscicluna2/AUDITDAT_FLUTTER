
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';
import 'package:auditdat/db/repo/template_repo.dart';

class TemplateTableKeys {
  static const String tableName = 'template_pages';

  static const List<String> values = [
    id,
    templateVersionId,
    name,
    mainPage,
    index
  ];

  static const String id = 'id';
  static const String templateVersionId = 'version_id';
  static const String name = 'name';
  static const String mainPage = 'main_page';
  static const String index = 'index';
}

class TemplatePage {
  final int id;
  final int templateVersionId;
  final String name;
  final bool mainPage;
  final int index;

  const TemplatePage({
    required this.id,
    required this.templateVersionId,
    required this.name,
    required this.mainPage,
    required this.index,
  });

  TemplatePage copy({
    int? id,
  }) =>
      TemplatePage(
        id: id ?? this.id,
        templateVersionId: templateVersionId,
        name: name,
        mainPage: mainPage,
        index: index,
      );

  //Category Relationship
  Future<TemplateVersion?> version() async =>
      await TemplateVersionRepo.instance.get(templateVersionId);

  static TemplatePage fromJson(Map<String, Object?> json) => TemplatePage(
    id: json[TemplateTableKeys.id] as int,
    templateVersionId: json[TemplateTableKeys.templateVersionId] as int,
    name: json[TemplateTableKeys.name] as String,
    mainPage: json[TemplateTableKeys.mainPage] as bool,
    index: json[TemplateTableKeys.index] as int,
  );

  Map<String, Object?> toJson() => {
    TemplateTableKeys.id: id,
    TemplateTableKeys.templateVersionId: templateVersionId,
    TemplateTableKeys.name: name,
    TemplateTableKeys.mainPage: mainPage,
    TemplateTableKeys.index: index,
  };
}
