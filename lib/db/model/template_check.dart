
class TemplateTableKeys {
  static const String tableName = 'template_fields';

  static const List<String> values = [
    id,
    name,
    responseGroupId,
    required,
    mediaRequired,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String responseGroupId = 'response_group_id';
  static const String required = 'required';
  static const String mediaRequired = 'media_required';
}

class TemplateCheck {
  final int id;
  final String name;
  final int responseGroupId;
  final bool required;
  final bool mediaRequired;

  const TemplateCheck({
    required this.id,
    required this.name,
    required this.responseGroupId,
    required this.required,
    required this.mediaRequired,
  });

  TemplateCheck copy({
    int? id,
  }) =>
      TemplateCheck(
        id: id ?? this.id,
        name: name,
        responseGroupId: responseGroupId,
        required: required,
        mediaRequired: mediaRequired,
      );

  //TODO Relationships; Response Group

  static TemplateCheck fromJson(Map<String, Object?> json) => TemplateCheck(
    id: json[TemplateTableKeys.id] as int,
    name: json[TemplateTableKeys.name] as String,
    responseGroupId: json[TemplateTableKeys.responseGroupId] as int,
    required: json[TemplateTableKeys.required] as bool,
    mediaRequired: json[TemplateTableKeys.mediaRequired] as bool,
  );

  Map<String, Object?> toJson() => {
    TemplateTableKeys.id: id,
    TemplateTableKeys.name: name,
    TemplateTableKeys.responseGroupId: responseGroupId,
    TemplateTableKeys.required: required,
    TemplateTableKeys.mediaRequired: mediaRequired,
  };
}
