import 'package:auditdat/db/model/template_response_group.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateResponseGroupRepo {
  static final TemplateResponseGroupRepo instance =
      TemplateResponseGroupRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  TemplateResponseGroupRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateResponseGroupTableKeys.tableName} ( 
        ${TemplateResponseGroupTableKeys.id} INTEGER PRIMARY KEY
        )
      ''';
  }

  Future<TemplateResponseGroup> create(TemplateResponseGroup group) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        TemplateResponseGroupTableKeys.tableName, group.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return group.copy(id: id);
  }

  Future<TemplateResponseGroup?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateResponseGroupTableKeys.tableName,
      columns: TemplateResponseGroupTableKeys.values,
      where: '${TemplateResponseGroupTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplateResponseGroup.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<TemplateResponseGroup>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateResponseGroupTableKeys.tableName);

    return result.map((json) => TemplateResponseGroup.fromJson(json)).toList();
  }

  Future<int> update(TemplateResponseGroup group) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      TemplateResponseGroupTableKeys.tableName,
      group.toJson(),
      where: '${TemplateResponseGroupTableKeys.id} = ?',
      whereArgs: [group.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateResponseGroupTableKeys.tableName,
      where: '${TemplateResponseGroupTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInList(List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateResponseGroupTableKeys.tableName,
        where: 'id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: ids,
      );
    } else {
      return await db.delete(
        TemplateResponseGroupTableKeys.tableName,
        where: '',
        whereArgs: [],
      );
    }
  }
}
