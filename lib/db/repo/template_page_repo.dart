import 'dart:developer';

import 'package:auditdat/db/model/template_page.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplatePageRepo {
  static final TemplatePageRepo instance = TemplatePageRepo._init();
  final UpdatDatabase updatDatabaseInstance = UpdatDatabase.instance;

  TemplatePageRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplatePageTableKeys.tableName} ( 
        ${TemplatePageTableKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${TemplatePageTableKeys.templateVersionId} INTEGER NOT NULL,
        ${TemplatePageTableKeys.name} TEXT NOT NULL,
        ${TemplatePageTableKeys.mainPage} INTEGER NOT NULL,
        ${TemplatePageTableKeys.index} INTEGER NOT NULL
        )
      ''';
  }

  Future<TemplatePage> create(TemplatePage page) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        TemplatePageTableKeys.tableName, page.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return page.copy(id: id);
  }

  Future<TemplatePage?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplatePageTableKeys.tableName,
      columns: TemplatePageTableKeys.values,
      where: '${TemplatePageTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplatePage.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<TemplatePage>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplatePageTableKeys.tableName);

    return result.map((json) => TemplatePage.fromJson(json)).toList();
  }

  Future<int> update(TemplatePage page) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      TemplatePageTableKeys.tableName,
      page.toJson(),
      where: '${TemplatePageTableKeys.id} = ?',
      whereArgs: [page.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplatePageTableKeys.tableName,
      where: '${TemplatePageTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInList(List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplatePageTableKeys.tableName,
        where: 'id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: ids,
      );
    } else {
      return await db.delete(
        TemplatePageTableKeys.tableName,
        where: '',
        whereArgs: [],
      );
    }
  }
}
