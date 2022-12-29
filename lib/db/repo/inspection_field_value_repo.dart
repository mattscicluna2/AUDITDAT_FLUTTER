import 'dart:developer';

import 'package:auditdat/db/auditdat_database.dart';
import 'package:auditdat/db/model/inspection_field_value.dart';
import 'package:sqflite/sqflite.dart';

class InspectionFieldValueRepo {
  static final InspectionFieldValueRepo instance =
      InspectionFieldValueRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  InspectionFieldValueRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${InspectionFieldValueTableKeys.tableName} ( 
        ${InspectionFieldValueTableKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${InspectionFieldValueTableKeys.realId} INTEGER,
        ${InspectionFieldValueTableKeys.inspectionId} INTEGER NOT NULL,
        ${InspectionFieldValueTableKeys.templateFieldId} INTEGER NOT NULL,
        ${InspectionFieldValueTableKeys.repeatableSectionId} INTEGER,
        ${InspectionFieldValueTableKeys.value} TEXT,
        ${InspectionFieldValueTableKeys.fileId} INTEGER,
        ${InspectionFieldValueTableKeys.comments} TEXT,
        ${InspectionFieldValueTableKeys.createdAt} INTEGER NOT NULL,
        ${InspectionFieldValueTableKeys.synced} INTEGER NOT NULL
        )
      ''';
  }

  Future<InspectionFieldValue> create(
      InspectionFieldValue inspectionFieldValue) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        InspectionFieldValueTableKeys.tableName, inspectionFieldValue.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return inspectionFieldValue.copy(id: id);
  }

  Future<InspectionFieldValue?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      InspectionFieldValueTableKeys.tableName,
      columns: InspectionFieldValueTableKeys.values,
      where: '${InspectionFieldValueTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return InspectionFieldValue.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<InspectionFieldValue>> getAll(int inspectionId) async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(InspectionFieldValueTableKeys.tableName,
        where: '${InspectionFieldValueTableKeys.inspectionId} = ?',
        whereArgs: [inspectionId],
        orderBy: '${InspectionFieldValueTableKeys.createdAt} DESC');

    return result.map((json) => InspectionFieldValue.fromJson(json)).toList();
  }

  Future<int> update(InspectionFieldValue inspectionFieldValue) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      InspectionFieldValueTableKeys.tableName,
      inspectionFieldValue.toJson(),
      where: '${InspectionFieldValueTableKeys.id} = ?',
      whereArgs: [inspectionFieldValue.id],
    );
  }

  Future<int> deleteInspectionFieldValues(int inspectionId) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      InspectionFieldValueTableKeys.tableName,
      where: '${InspectionFieldValueTableKeys.inspectionId} = ?',
      whereArgs: [inspectionId],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      InspectionFieldValueTableKeys.tableName,
      where: '${InspectionFieldValueTableKeys.id} = ?',
      whereArgs: [id],
    );
  }
}
