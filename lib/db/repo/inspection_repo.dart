import 'dart:developer';

import 'package:auditdat/db/model/inspection.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class InspectionRepo {
  static final InspectionRepo instance = InspectionRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  InspectionRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${InspectionTableKeys.tableName} ( 
        ${InspectionTableKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${InspectionTableKeys.realId} INTEGER,
        ${InspectionTableKeys.templateVersionId} INTEGER NOT NULL,
        ${InspectionTableKeys.reportDate} TEXT,
        ${InspectionTableKeys.siteId} INTEGER,
        ${InspectionTableKeys.customerId} INTEGER,
        ${InspectionTableKeys.statusId} INTEGER NOT NULL,
        ${InspectionTableKeys.createdAt} INTEGER NOT NULL,
        ${InspectionTableKeys.synced} INTEGER NOT NULL
        )
      ''';
  }

  Future<Inspection> create(Inspection inspection) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        InspectionTableKeys.tableName, inspection.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return inspection.copy(id: id);
  }

  Future<Inspection?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      InspectionTableKeys.tableName,
      columns: InspectionTableKeys.values,
      where: '${InspectionTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Inspection.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<Inspection>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(InspectionTableKeys.tableName,
        orderBy: '${InspectionTableKeys.createdAt} DESC');

    return result.map((json) => Inspection.fromJson(json)).toList();
  }

  Future<int> update(Inspection inspection) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      InspectionTableKeys.tableName,
      inspection.toJson(),
      where: '${InspectionTableKeys.id} = ?',
      whereArgs: [inspection.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      InspectionTableKeys.tableName,
      where: '${InspectionTableKeys.id} = ?',
      whereArgs: [id],
    );
  }
}
