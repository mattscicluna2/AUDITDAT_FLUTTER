import 'dart:developer';

import 'package:auditdat/db/model/template_section.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateSectionRepo {
  static final TemplateSectionRepo instance = TemplateSectionRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  TemplateSectionRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateSectionTableKeys.tableName} ( 
        ${TemplateSectionTableKeys.id} INTEGER PRIMARY KEY, 
        ${TemplateSectionTableKeys.name} TEXT NOT NULL,
        ${TemplateSectionTableKeys.repeat} INTEGER NOT NULL
        )
      ''';
  }

  Future<TemplateSection> create(TemplateSection section) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        TemplateSectionTableKeys.tableName, section.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return section.copy(id: id);
  }

  Future<TemplateSection?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateSectionTableKeys.tableName,
      columns: TemplateSectionTableKeys.values,
      where: '${TemplateSectionTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplateSection.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<TemplateSection>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateSectionTableKeys.tableName);

    return result.map((json) => TemplateSection.fromJson(json)).toList();
  }

  Future<int> update(TemplateSection section) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      TemplateSectionTableKeys.tableName,
      section.toJson(),
      where: '${TemplateSectionTableKeys.id} = ?',
      whereArgs: [section.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateSectionTableKeys.tableName,
      where: '${TemplateSectionTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInList(List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateSectionTableKeys.tableName,
        where: 'id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: ids,
      );
    } else {
      return await db.delete(
        TemplateSectionTableKeys.tableName,
        where: '',
        whereArgs: [],
      );
    }
  }
}
