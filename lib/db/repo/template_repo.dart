
import 'package:auditdat/db/model/template.dart';
import 'package:flutter/material.dart';

import '../auditdat_database.dart';

class TemplateRepo {
  static final TemplateRepo instance = TemplateRepo._init();
  final UpdatDatabase updatDatabaseInstance = UpdatDatabase.instance;

  TemplateRepo._init();

  static String createTable(){
    return '''
      CREATE TABLE ${TemplateTableKeys.tableName} ( 
        ${TemplateTableKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${TemplateTableKeys.name} TEXT NOT NULL,
        ${TemplateTableKeys.version} TEXT NOT NULL
        )
      ''';
  }

  Future<Template> create(Template template) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(TemplateTableKeys.tableName, template.toJson());
    return template.copy(id: id);
  }

  Future<Template> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateTableKeys.tableName,
      columns: TemplateTableKeys.values,
      where: '${TemplateTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Template.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Template>?> getAllByCategory(int? categoryId) async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(
      TemplateTableKeys.tableName,
      columns: TemplateTableKeys.values,
      where: '${TemplateTableKeys.categoryId} = ?',
      whereArgs: [categoryId],
    );

    if (result.isNotEmpty){
      return result.map((json) => Template.fromJson(json)).toList();
    }

    return null;
  }

  Future<List<Template>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateTableKeys.tableName);

    return result.map((json) => Template.fromJson(json)).toList();
  }

  Future<int> update(Template template) async {
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
}