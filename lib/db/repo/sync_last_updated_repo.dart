import 'package:auditdat/db/auditdat_database.dart';
import 'package:auditdat/db/model/sync_last_updated.dart';
import 'package:sqflite/sqflite.dart';

class SyncLastUpdatedRepo {
  static final SyncLastUpdatedRepo instance = SyncLastUpdatedRepo._init();
  final UpdatDatabase updatDatabaseInstance = UpdatDatabase.instance;

  SyncLastUpdatedRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${SyncLastUpdatedTableKeys.tableName} ( 
        ${SyncLastUpdatedTableKeys.name} TEXT PRIMARY KEY,
        ${SyncLastUpdatedTableKeys.lastUpdated} TEXT NOT NULL
        )
      ''';
  }

  Future<SyncLastUpdated> create(SyncLastUpdated sync) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        SyncLastUpdatedTableKeys.tableName, sync.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return sync.copy(id: id);
  }

  Future<SyncLastUpdated?> get(String name) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      SyncLastUpdatedTableKeys.tableName,
      columns: SyncLastUpdatedTableKeys.values,
      where: '${SyncLastUpdatedTableKeys.name} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return SyncLastUpdated.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> update(SyncLastUpdated sync) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      SyncLastUpdatedTableKeys.tableName,
      sync.toJson(),
      where: '${SyncLastUpdatedTableKeys.name} = ?',
      whereArgs: [sync.name],
    );
  }
}
