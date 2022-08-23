import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';

class SyncLastUpdatedTableKeys {
  static const String tableName = 'syncs_last_updated';

  static const List<String> values = [name, lastUpdated];

  static const String name = 'name';
  static const String lastUpdated = 'last_updated';
}

class SyncLastUpdated {
  String name;
  String lastUpdated;

  SyncLastUpdated({
    required this.name,
    required this.lastUpdated,
  });

  SyncLastUpdated copy({
    int? id,
    String? name,
    String? lastUpdated,
  }) =>
      SyncLastUpdated(
        name: this.name,
        lastUpdated: this.lastUpdated,
      );

  static SyncLastUpdated fromJson(Map<String, Object?> json) => SyncLastUpdated(
        name: json[SyncLastUpdatedTableKeys.name] as String,
        lastUpdated: json[SyncLastUpdatedTableKeys.lastUpdated] as String,
      );

  Map<String, Object?> toJson() => {
        SyncLastUpdatedTableKeys.name: name,
        SyncLastUpdatedTableKeys.lastUpdated: lastUpdated,
      };
}
