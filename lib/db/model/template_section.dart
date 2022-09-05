
class TemplateTableKeys {
  static const String tableName = 'template_fields';

  static const List<String> values = [
    id,
    name,
    repeat,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String repeat = 'repeat';
}

class TemplateSection {
  final int id;
  final String name;
  final bool repeat;

  const TemplateSection({
    required this.id,
    required this.name,
    required this.repeat,
  });

  TemplateSection copy({
    int? id,
  }) =>
      TemplateSection(
        id: id ?? this.id,
        name: name,
        repeat: repeat,
      );

  //TODO Relationships; Response Group

  static TemplateSection fromJson(Map<String, Object?> json) => TemplateSection(
    id: json[TemplateTableKeys.id] as int,
    name: json[TemplateTableKeys.name] as String,
    repeat: json[TemplateTableKeys.repeat] as bool,
  );

  Map<String, Object?> toJson() => {
    TemplateTableKeys.id: id,
    TemplateTableKeys.name: name,
    TemplateTableKeys.repeat: repeat,
  };
}
