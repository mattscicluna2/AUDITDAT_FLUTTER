import 'package:auditdat/db/model/template_response.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateResponseRepo {
  static final TemplateResponseRepo instance = TemplateResponseRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  TemplateResponseRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateResponseTableKeys.tableName} ( 
        ${TemplateResponseTableKeys.id} INTEGER PRIMARY KEY,
        ${TemplateResponseTableKeys.groupId} INTEGER NOT NULL,
        ${TemplateResponseTableKeys.response} TEXT NOT NULL,
        ${TemplateResponseTableKeys.colour} TEXT NOT NULL,
        ${TemplateResponseTableKeys.fail} INTEGER NOT NULL,
        ${TemplateResponseTableKeys.score} INTEGER NOT NULL,
        ${TemplateResponseTableKeys.index} INTEGER NOT NULL
        )
      ''';
  }

  Future<TemplateResponse> create(TemplateResponse response) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        TemplateResponseTableKeys.tableName, response.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return response.copy(id: id);
  }

  Future<TemplateResponse?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateResponseTableKeys.tableName,
      columns: TemplateResponseTableKeys.values,
      where: '${TemplateResponseTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplateResponse.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<TemplateResponse>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateResponseTableKeys.tableName);

    return result.map((json) => TemplateResponse.fromJson(json)).toList();
  }

  Future<int> update(TemplateResponse response) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      TemplateResponseTableKeys.tableName,
      response.toJson(),
      where: '${TemplateResponseTableKeys.id} = ?',
      whereArgs: [response.id],
    );
  }

  Future<List<TemplateResponse>> getAllByGroupId(int groupId) async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(
      TemplateResponseTableKeys.tableName,
      columns: TemplateResponseTableKeys.values,
      where: '${TemplateResponseTableKeys.groupId} = ?',
      whereArgs: [groupId],
    );

    if (result.isNotEmpty) {
      return result.map((json) => TemplateResponse.fromJson(json)).toList();
    }

    return [];
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateResponseTableKeys.tableName,
      where: '${TemplateResponseTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInList(List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateResponseTableKeys.tableName,
        where: 'id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: ids,
      );
    } else {
      return await db.delete(
        TemplateResponseTableKeys.tableName,
        where: '',
        whereArgs: [],
      );
    }
  }
}
