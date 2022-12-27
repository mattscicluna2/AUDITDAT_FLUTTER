import 'dart:developer';

import 'package:auditdat/db/model/inspection_status.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class InspectionStatusRepo {
  static final InspectionStatusRepo instance = InspectionStatusRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  InspectionStatusRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${InspectionStatusTableKeys.tableName} ( 
        ${InspectionStatusTableKeys.id} INTEGER PRIMARY KEY, 
        ${InspectionStatusTableKeys.name} TEXT NOT NULL,
        ${InspectionStatusTableKeys.colour} TEXT NOT NULL
        )
      ''';
  }

  Future<InspectionStatus> create(InspectionStatus inspection) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(
        InspectionStatusTableKeys.tableName, inspection.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return inspection.copy(id: id);
  }

  Future<InspectionStatus?> get(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      InspectionStatusTableKeys.tableName,
      columns: InspectionStatusTableKeys.values,
      where: '${InspectionStatusTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return InspectionStatus.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<int> update(InspectionStatus inspection) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      InspectionStatusTableKeys.tableName,
      inspection.toJson(),
      where: '${InspectionStatusTableKeys.id} = ?',
      whereArgs: [inspection.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      InspectionStatusTableKeys.tableName,
      where: '${InspectionStatusTableKeys.id} = ?',
      whereArgs: [id],
    );
  }
}
