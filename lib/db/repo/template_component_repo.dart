import 'dart:developer';

import 'package:auditdat/db/model/template_component.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateComponentRepo {
  static final TemplateComponentRepo instance = TemplateComponentRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  TemplateComponentRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateComponentTableKeys.tableName} ( 
        ${TemplateComponentTableKeys.id} INTEGER PRIMARY KEY, 
        ${TemplateComponentTableKeys.templateVersionId} INTEGER NOT NULL,
        ${TemplateComponentTableKeys.pageId} INTEGER NOT NULL,
        ${TemplateComponentTableKeys.parentSectionId} INTEGER NULL,
        ${TemplateComponentTableKeys.sectionId} INTEGER NULL,
        ${TemplateComponentTableKeys.checkId} INTEGER NULL,
        ${TemplateComponentTableKeys.fieldId} INTEGER NULL,
        ${TemplateComponentTableKeys.note} STRING NULL,
        ${TemplateComponentTableKeys.index} INTEGER NOT NULL
        )
      ''';
  }

  Future<TemplateComponent> create(TemplateComponent component) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        TemplateComponentTableKeys.tableName, component.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return component.copy(id: id);
  }

  Future<TemplateComponent?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateComponentTableKeys.tableName,
      columns: TemplateComponentTableKeys.values,
      where: '${TemplateComponentTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplateComponent.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<TemplateComponent>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateComponentTableKeys.tableName);

    return result.map((json) => TemplateComponent.fromJson(json)).toList();
  }

  Future<List<TemplateComponent>> getAllPageComponents(int pageId) async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(
      TemplateComponentTableKeys.tableName,
      columns: TemplateComponentTableKeys.values,
      where: '${TemplateComponentTableKeys.pageId} = ?',
      whereArgs: [pageId],
    );

    if (result.isNotEmpty) {
      return result.map((json) => TemplateComponent.fromJson(json)).toList();
    }

    return [];
  }

  Future<int> update(TemplateComponent component) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      TemplateComponentTableKeys.tableName,
      component.toJson(),
      where: '${TemplateComponentTableKeys.id} = ?',
      whereArgs: [component.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateComponentTableKeys.tableName,
      where: '${TemplateComponentTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInList(List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateComponentTableKeys.tableName,
        where: 'id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: ids,
      );
    } else {
      return await db.delete(
        TemplateComponentTableKeys.tableName,
        where: '',
        whereArgs: [],
      );
    }
  }
}
