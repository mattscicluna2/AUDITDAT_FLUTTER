import 'dart:developer';

import 'package:auditdat/db/model/template_field.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateFieldRepo {
  static final TemplateFieldRepo instance = TemplateFieldRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  TemplateFieldRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateFieldTableKeys.tableName} ( 
        ${TemplateFieldTableKeys.id} INTEGER PRIMARY KEY, 
        ${TemplateFieldTableKeys.name} TEXT NOT NULL,
        ${TemplateFieldTableKeys.typeId} INTEGER NOT NULL,
        ${TemplateFieldTableKeys.required} INTEGER NOT NULL,
        ${TemplateFieldTableKeys.mediaRequired} INTEGER NOT NULL
        )
      ''';
  }

  Future<TemplateField> create(TemplateField field) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(TemplateFieldTableKeys.tableName, field.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return field.copy(id: id);
  }

  Future<TemplateField?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateFieldTableKeys.tableName,
      columns: TemplateFieldTableKeys.values,
      where: '${TemplateFieldTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplateField.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<TemplateField>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateFieldTableKeys.tableName);

    return result.map((json) => TemplateField.fromJson(json)).toList();
  }

  Future<int> update(TemplateField field) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      TemplateFieldTableKeys.tableName,
      field.toJson(),
      where: '${TemplateFieldTableKeys.id} = ?',
      whereArgs: [field.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateFieldTableKeys.tableName,
      where: '${TemplateFieldTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInList(List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateFieldTableKeys.tableName,
        where: 'id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: ids,
      );
    } else {
      return await db.delete(
        TemplateFieldTableKeys.tableName,
        where: '',
        whereArgs: [],
      );
    }
  }
}
