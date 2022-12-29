import 'dart:developer';

import 'package:auditdat/db/auditdat_database.dart';
import 'package:auditdat/db/model/inspection_check.dart';
import 'package:sqflite/sqflite.dart';

class InspectionCheckRepo {
  static final InspectionCheckRepo instance = InspectionCheckRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  InspectionCheckRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${InspectionCheckTableKeys.tableName} ( 
        ${InspectionCheckTableKeys.id} INTEGER PRIMARY KEY, 
        ${InspectionCheckTableKeys.realId} INTEGER,
        ${InspectionCheckTableKeys.inspectionId} INTEGER NOT NULL,
        ${InspectionCheckTableKeys.templateCheckId} INTEGER NOT NULL,
        ${InspectionCheckTableKeys.repeatableSectionId} INTEGER,
        ${InspectionCheckTableKeys.notApplicable} INTEGER,
        ${InspectionCheckTableKeys.responseId} INTEGER,
        ${InspectionCheckTableKeys.comments} TEXT,
        ${InspectionCheckTableKeys.createdAt} INTEGER NOT NULL,
        ${InspectionCheckTableKeys.synced} INTEGER NOT NULL
        )
      ''';
  }

  Future<InspectionCheck> create(InspectionCheck inspectionCheck) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        InspectionCheckTableKeys.tableName, inspectionCheck.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return inspectionCheck.copy(id: id);
  }

  Future<InspectionCheck?> get(int? id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      InspectionCheckTableKeys.tableName,
      columns: InspectionCheckTableKeys.values,
      where: '${InspectionCheckTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return InspectionCheck.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<InspectionCheck>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(InspectionCheckTableKeys.tableName,
        orderBy: '${InspectionCheckTableKeys.createdAt} DESC');

    return result.map((json) => InspectionCheck.fromJson(json)).toList();
  }

  Future<int> update(InspectionCheck inspectionCheck) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      InspectionCheckTableKeys.tableName,
      inspectionCheck.toJson(),
      where: '${InspectionCheckTableKeys.id} = ?',
      whereArgs: [inspectionCheck.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      InspectionCheckTableKeys.tableName,
      where: '${InspectionCheckTableKeys.id} = ?',
      whereArgs: [id],
    );
  }
}
