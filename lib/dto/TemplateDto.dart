import 'dart:convert';

class TemplateDto {
  final int id;
  final int categoryId;
  final CurrentVersionDto currentVersion;
  final bool deleted;

  const TemplateDto(
      {required this.id,
      required this.categoryId,
      required this.currentVersion,
      required this.deleted})
      : assert(id != null);

  factory TemplateDto.fromJson(dynamic json) {
    return TemplateDto(
        id: json['id'],
        categoryId: json['category_id'],
        currentVersion: CurrentVersionDto(
            id: json['current_version']['id'],
            name: json['current_version']['name'],
            shareable: json['current_version']['shareable'] == 1,
            version: json['current_version']['version'],
            templateId: json['current_version']['template_id']),
        deleted: json['deleted']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'currentVersion': currentVersion.toJson(),
      'deleted': deleted,
    };
  }

  static List<TemplateDto> decode(String templates) =>
      (json.decode(templates) as List<dynamic>)
          .map<TemplateDto>((item) => TemplateDto.fromJson(item))
          .toList();
}

class CurrentVersionDto {
  final int id;
  final int templateId;
  final String name;
  final bool shareable;
  final String version;

  const CurrentVersionDto({
    required this.id,
    required this.templateId,
    required this.name,
    required this.shareable,
    required this.version,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'templateId': templateId,
      'name': name,
      'shareable': shareable,
      'version': version,
    };
  }
}
