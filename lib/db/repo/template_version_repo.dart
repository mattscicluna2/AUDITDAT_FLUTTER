import 'package:auditdat/db/model/template_version.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateVersionRepo {
  static final TemplateVersionRepo instance = TemplateVersionRepo._init();
  final UpdatDatabase updatDatabaseInstance = UpdatDatabase.instance;

  TemplateVersionRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateTableKeys.tableName} ( 
        ${TemplateTableKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${TemplateTableKeys.templateId} INTEGER NOT NULL,
        ${TemplateTableKeys.categoryId} INTEGER NOT NULL,
        ${TemplateTableKeys.name} TEXT NOT NULL,
        ${TemplateTableKeys.version} TEXT NOT NULL,
        ${TemplateTableKeys.downloaded} BOOLEAN NOT NULL
        )
      ''';
  }

  Future<TemplateVersion> create(TemplateVersion template) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(TemplateTableKeys.tableName, template.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return template.copy(id: id);
  }

  Future<TemplateVersion> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateTableKeys.tableName,
      columns: TemplateTableKeys.values,
      where: '${TemplateTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplateVersion.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TemplateVersion>> getAllByCategory(int categoryId) async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(
      TemplateTableKeys.tableName,
      columns: TemplateTableKeys.values,
      where: '${TemplateTableKeys.categoryId} = ?',
      whereArgs: [categoryId],
    );

    if (result.isNotEmpty) {
      return result.map((json) => TemplateVersion.fromJson(json)).toList();
    }

    return [];
  }

  Future<List<TemplateVersion>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateTableKeys.tableName);

    return result.map((json) => TemplateVersion.fromJson(json)).toList();
  }

  Future<int> update(TemplateVersion template) async {
    final db = await updatDatabaseInstance.database;

    return db.update(
      TemplateTableKeys.tableName,
      template.toJson(),
      where: '${TemplateTableKeys.id} = ?',
      whereArgs: [template.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateTableKeys.tableName,
      where: '${TemplateTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInListOfCategory(
      int categoryId, List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateTableKeys.tableName,
        where:
            'category_id = ? AND template_id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: [categoryId] + ids,
      );
    } else {
      return await db.delete(
        TemplateTableKeys.tableName,
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );
    }
  }
}
