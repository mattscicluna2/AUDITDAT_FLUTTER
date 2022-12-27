import 'dart:developer';

import 'package:auditdat/db/model/template_check.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateCheckRepo {
  static final TemplateCheckRepo instance = TemplateCheckRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  TemplateCheckRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateCheckTableKeys.tableName} ( 
        ${TemplateCheckTableKeys.id} INTEGER PRIMARY KEY, 
        ${TemplateCheckTableKeys.name} TEXT NOT NULL,
        ${TemplateCheckTableKeys.responseGroupId} INTEGER NOT NULL,
        ${TemplateCheckTableKeys.required} INTEGER NOT NULL,
        ${TemplateCheckTableKeys.mediaRequired} INTEGER NOT NULL
        )
      ''';
  }

  Future<TemplateCheck> create(TemplateCheck check) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(TemplateCheckTableKeys.tableName, check.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return check.copy(id: id);
  }

  Future<TemplateCheck?> get(int id) async {
    log("Get Check");
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateCheckTableKeys.tableName,
      columns: TemplateCheckTableKeys.values,
      where: '${TemplateCheckTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      log("Got Check");

      return TemplateCheck.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<TemplateCheck>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateCheckTableKeys.tableName);

    return result.map((json) => TemplateCheck.fromJson(json)).toList();
  }

  Future<int> update(TemplateCheck check) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      TemplateCheckTableKeys.tableName,
      check.toJson(),
      where: '${TemplateCheckTableKeys.id} = ?',
      whereArgs: [check.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateCheckTableKeys.tableName,
      where: '${TemplateCheckTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInList(List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateCheckTableKeys.tableName,
        where: 'id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: ids,
      );
    } else {
      return await db.delete(
        TemplateCheckTableKeys.tableName,
        where: '',
        whereArgs: [],
      );
    }
  }
}
