import 'package:auditdat/db/model/template_version.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateVersionRepo {
  static final TemplateVersionRepo instance = TemplateVersionRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  TemplateVersionRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateVersionTableKeys.tableName} ( 
        ${TemplateVersionTableKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${TemplateVersionTableKeys.templateId} INTEGER NOT NULL,
        ${TemplateVersionTableKeys.categoryId} INTEGER NOT NULL,
        ${TemplateVersionTableKeys.name} TEXT NOT NULL,
        ${TemplateVersionTableKeys.version} TEXT NOT NULL,
        ${TemplateVersionTableKeys.downloaded} INTEGER NOT NULL
        )
      ''';
  }

  Future<TemplateVersion> create(TemplateVersion template) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        TemplateVersionTableKeys.tableName, template.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return template.copy(id: id);
  }

  Future<TemplateVersion> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateVersionTableKeys.tableName,
      columns: TemplateVersionTableKeys.values,
      where: '${TemplateVersionTableKeys.id} = ?',
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
      TemplateVersionTableKeys.tableName,
      columns: TemplateVersionTableKeys.values,
      where: '${TemplateVersionTableKeys.categoryId} = ?',
      // limit: 1,
      groupBy: TemplateVersionTableKeys.templateId,
      having: 'max(${TemplateVersionTableKeys.version})',
      whereArgs: [categoryId],
    );

    if (result.isNotEmpty) {
      return result.map((json) => TemplateVersion.fromJson(json)).toList();
    }

    return [];
  }

  Future<List<TemplateVersion>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateVersionTableKeys.tableName);

    return result.map((json) => TemplateVersion.fromJson(json)).toList();
  }

  Future<int> update(TemplateVersion template) async {
    final db = await updatDatabaseInstance.database;

    return db.update(
      TemplateVersionTableKeys.tableName,
      template.toJson(),
      where: '${TemplateVersionTableKeys.id} = ?',
      whereArgs: [template.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateVersionTableKeys.tableName,
      where: '${TemplateVersionTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInListOfCategory(
      int categoryId, List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateVersionTableKeys.tableName,
        where:
            'category_id = ? AND template_id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: [categoryId] + ids,
      );
    } else {
      return await db.delete(
        TemplateVersionTableKeys.tableName,
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );
    }
  }
}
