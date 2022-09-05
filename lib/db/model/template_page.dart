
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/template_version_repo.dart';

class TemplatePageTableKeys {
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
  static const String index = 'position';
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
    id: json[TemplatePageTableKeys.id] as int,
    templateVersionId: json[TemplatePageTableKeys.templateVersionId] as int,
    name: json[TemplatePageTableKeys.name] as String,
    mainPage: json[TemplatePageTableKeys.mainPage] as bool,
    index: json[TemplatePageTableKeys.index] as int,
  );

  Map<String, Object?> toJson() => {
    TemplatePageTableKeys.id: id,
    TemplatePageTableKeys.templateVersionId: templateVersionId,
    TemplatePageTableKeys.name: name,
    TemplatePageTableKeys.mainPage: mainPage,
    TemplatePageTableKeys.index: index,
  };
}
