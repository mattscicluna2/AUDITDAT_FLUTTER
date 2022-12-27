import 'dart:convert';

class InspectionStatusTableKeys {
  static const String tableName = 'inspection_statuses';

  static const List<String> values = [id, name];

  static const String id = 'id';
  static const String name = 'name';
  static const String colour = 'colour';
}

abstract class InspectionStatuses {
  static String NEW = "New";
  static String IN_PROGRESS = "In Progress";
  static String READY_TO_PUBLISH = "Ready to Publish";
  static String PUBLISHED = "Published";
}

class InspectionStatus {
  final int id;
  final String name;
  final String colour;

  const InspectionStatus({
    required this.id,
    required this.name,
    required this.colour,
  });

  InspectionStatus copy({
    int? id,
    String? name,
    String? colour,
  }) =>
      InspectionStatus(id: id ?? this.id, name: this.name, colour: this.colour);

  static InspectionStatus fromJson(Map<String, Object?> json) =>
      InspectionStatus(
        id: json[InspectionStatusTableKeys.id] as int,
        name: json[InspectionStatusTableKeys.name] as String,
        colour: json[InspectionStatusTableKeys.colour] as String,
      );

  Map<String, Object?> toJson() => {
        InspectionStatusTableKeys.id: id,
        InspectionStatusTableKeys.name: name,
        InspectionStatusTableKeys.colour: colour,
      };

  static List<InspectionStatus> decode(String categories) =>
      (json.decode(categories) as List<dynamic>)
          .map<InspectionStatus>((item) => InspectionStatus.fromJson(item))
          .toList();
}
