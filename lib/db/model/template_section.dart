
class TemplateSectionTableKeys {
  static const String tableName = 'template_sections';

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

  static TemplateSection fromJson(Map<String, Object?> json) => TemplateSection(
    id: json[TemplateSectionTableKeys.id] as int,
    name: json[TemplateSectionTableKeys.name] as String,
    repeat: json[TemplateSectionTableKeys.repeat] as bool,
  );

  Map<String, Object?> toJson() => {
    TemplateSectionTableKeys.id: id,
    TemplateSectionTableKeys.name: name,
    TemplateSectionTableKeys.repeat: repeat,
  };
}
