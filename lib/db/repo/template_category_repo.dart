
import 'package:auditdat/db/model/template_category.dart';
import 'package:flutter/material.dart';

import '../auditdat_database.dart';

class TemplateCategoryRepo {
  static final TemplateCategoryRepo instance = TemplateCategoryRepo._init();
  final UpdatDatabase updatDatabaseInstance = UpdatDatabase.instance;

  TemplateCategoryRepo._init();

  static String createTable(){
    return '''
      CREATE TABLE ${TemplateCategoryTableKeys.tableName} ( 
        ${TemplateCategoryTableKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${TemplateCategoryTableKeys.name} TEXT NOT NULL
        )
      ''';
  }

  Future<TemplateCategory> create(TemplateCategory category) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(TemplateCategoryTableKeys.tableName, category.toJson());
    return category.copy(id: id);
  }

  Future<TemplateCategory> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateCategoryTableKeys.tableName,
      columns: TemplateCategoryTableKeys.values,
      where: '${TemplateCategoryTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplateCategory.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TemplateCategory>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateCategoryTableKeys.tableName);

    return result.map((json) => TemplateCategory.fromJson(json)).toList();
  }

  Future<int> update(TemplateCategory category) async {
    final db = await updatDatabaseInstance.database;

    return db.update(
      TemplateCategoryTableKeys.tableName,
      category.toJson(),
      where: '${TemplateCategoryTableKeys.id} = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateCategoryTableKeys.tableName,
      where: '${TemplateCategoryTableKeys.id} = ?',
      whereArgs: [id],
    );
  }
}