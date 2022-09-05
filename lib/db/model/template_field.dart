class TemplateFieldTableKeys {
  static const String tableName = 'template_fields';

  static const List<String> values = [
    id,
    name,
    typeId,
    required,
    mediaRequired,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String typeId = 'type_id';
  static const String required = 'required';
  static const String mediaRequired = 'media_required';
}

class TemplateField {
  final int id;
  final String name;
  final int typeId;
  final bool required;
  final bool mediaRequired;

  const TemplateField({
    required this.id,
    required this.name,
    required this.typeId,
    required this.required,
    required this.mediaRequired,
  });

  TemplateField copy({
    int? id,
  }) =>
      TemplateField(
        id: id ?? this.id,
        name: name,
        typeId: typeId,
        required: required,
        mediaRequired: mediaRequired,
      );

  //TODO Relationships; Type

  static TemplateField fromJson(Map<String, Object?> json) => TemplateField(
        id: json[TemplateFieldTableKeys.id] as int,
        name: json[TemplateFieldTableKeys.name] as String,
        typeId: json[TemplateFieldTableKeys.typeId] as int,
        required: json[TemplateFieldTableKeys.required] as bool,
        mediaRequired: json[TemplateFieldTableKeys.mediaRequired] as bool,
      );

  Map<String, Object?> toJson() => {
        TemplateFieldTableKeys.id: id,
        TemplateFieldTableKeys.name: name,
        TemplateFieldTableKeys.typeId: typeId,
        TemplateFieldTableKeys.required: required ? 1 : 0,
        TemplateFieldTableKeys.mediaRequired: mediaRequired ? 1 : 0,
      };
}
