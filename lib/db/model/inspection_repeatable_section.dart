class InspectionRepeatableSectionTableKeys {
  static const String tableName = 'inspection_repeatable_sections';

  static const List<String> values = [
    id,
    realId,
    inspectionId,
    repeatableSectionId,
    templateSectionId,
    createdAt,
    synced
  ];

  static const String id = 'id';
  static const String realId = 'real_id';
  static const String inspectionId = 'inspection_id';
  static const String repeatableSectionId = 'repeatable_section_id';
  static const String templateSectionId = 'template_section_id';
  static const String createdAt = 'created_at';
  static const String synced = 'synced';
}

class InspectionRepeatableSection {
  final int? id;
  final int? realId;
  final int inspectionId;
  final int? repeatableSectionId;
  final int templateSectionId;
  final int createdAt;
  final bool synced;

  const InspectionRepeatableSection({
    this.id,
    this.realId,
    required this.inspectionId,
    this.repeatableSectionId,
    required this.templateSectionId,
    required this.createdAt,
    this.synced = false,
  });

  InspectionRepeatableSection copy({
    int? id,
    int? realId,
    int? inspectionId,
    int? repeatableSectionId,
    int? templateSectionId,
    int? createdAt,
    bool? synced,
  }) =>
      InspectionRepeatableSection(
        id: id ?? this.id,
        realId: realId ?? this.realId,
        inspectionId: this.inspectionId,
        repeatableSectionId: repeatableSectionId ?? this.repeatableSectionId,
        templateSectionId: realId ?? this.templateSectionId,
        createdAt: this.createdAt,
        synced: synced ?? this.synced,
      );

  //TODO Relationships

  static InspectionRepeatableSection fromJson(Map<String, Object?> json) =>
      InspectionRepeatableSection(
        id: json[InspectionRepeatableSectionTableKeys.id] as int,
        realId: json[InspectionRepeatableSectionTableKeys.realId] as int?,
        inspectionId:
            json[InspectionRepeatableSectionTableKeys.inspectionId] as int,
        repeatableSectionId:
            json[InspectionRepeatableSectionTableKeys.repeatableSectionId]
                as int?,
        templateSectionId:
            json[InspectionRepeatableSectionTableKeys.templateSectionId] as int,
        createdAt: json[InspectionRepeatableSectionTableKeys.createdAt] as int,
        synced: json[InspectionRepeatableSectionTableKeys.synced] == 1,
      );

  Map<String, Object?> toJson() => {
        InspectionRepeatableSectionTableKeys.id: id,
        InspectionRepeatableSectionTableKeys.realId: realId,
        InspectionRepeatableSectionTableKeys.inspectionId: inspectionId,
        InspectionRepeatableSectionTableKeys.repeatableSectionId:
            repeatableSectionId,
        InspectionRepeatableSectionTableKeys.templateSectionId:
            templateSectionId,
        InspectionRepeatableSectionTableKeys.createdAt: createdAt,
        InspectionRepeatableSectionTableKeys.synced: synced,
      };
}
