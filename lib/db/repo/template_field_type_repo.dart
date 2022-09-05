import 'package:auditdat/db/model/template_field_type.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class TemplateFieldTypeRepo {
  static final TemplateFieldTypeRepo instance = TemplateFieldTypeRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  TemplateFieldTypeRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${TemplateFieldTypeTableKeys.tableName} ( 
        ${TemplateFieldTypeTableKeys.id} INTEGER PRIMARY KEY,
        ${TemplateFieldTypeTableKeys.name} TEXT NOT NULL
        )
      ''';
  }

  Future<TemplateFieldType> create(TemplateFieldType fieldType) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        TemplateFieldTypeTableKeys.tableName, fieldType.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return fieldType.copy(id: id);
  }

  Future<TemplateFieldType?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      TemplateFieldTypeTableKeys.tableName,
      columns: TemplateFieldTypeTableKeys.values,
      where: '${TemplateFieldTypeTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TemplateFieldType.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<TemplateFieldType>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(TemplateFieldTypeTableKeys.tableName);

    return result.map((json) => TemplateFieldType.fromJson(json)).toList();
  }

  Future<int> update(TemplateFieldType fieldType) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      TemplateFieldTypeTableKeys.tableName,
      fieldType.toJson(),
      where: '${TemplateFieldTypeTableKeys.id} = ?',
      whereArgs: [fieldType.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      TemplateFieldTypeTableKeys.tableName,
      where: '${TemplateFieldTypeTableKeys.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotInList(List<int> ids) async {
    final db = await updatDatabaseInstance.database;

    if (ids.length > 0) {
      return await db.delete(
        TemplateFieldTypeTableKeys.tableName,
        where: 'id NOT IN (${ids.map((_) => '?').join(', ')})',
        whereArgs: ids,
      );
    } else {
      return await db.delete(
        TemplateFieldTypeTableKeys.tableName,
        where: '',
        whereArgs: [],
      );
    }
  }
}
