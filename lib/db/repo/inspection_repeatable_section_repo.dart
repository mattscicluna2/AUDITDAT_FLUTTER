import 'dart:developer';

import 'package:auditdat/db/model/inspection_repeatable_section.dart';
import 'package:sqflite/sqflite.dart';

import '../auditdat_database.dart';

class InspectionRepeatableSectionRepo {
  static final InspectionRepeatableSectionRepo instance =
      InspectionRepeatableSectionRepo._init();
  final AuditdatDatabase updatDatabaseInstance = AuditdatDatabase.instance;

  InspectionRepeatableSectionRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE ${InspectionRepeatableSectionTableKeys.tableName} ( 
        ${InspectionRepeatableSectionTableKeys.id} INTEGER PRIMARY KEY, 
        ${InspectionRepeatableSectionTableKeys.realId} INTEGER,
        ${InspectionRepeatableSectionTableKeys.inspectionId} INTEGER NOT NULL,
        ${InspectionRepeatableSectionTableKeys.repeatableSectionId} INTEGER,
        ${InspectionRepeatableSectionTableKeys.templateSectionId} INTEGER NOT NULL,
        ${InspectionRepeatableSectionTableKeys.createdAt} INTEGER NOT NULL,
        ${InspectionRepeatableSectionTableKeys.synced} INTEGER NOT NULL
        )
      ''';
  }

  Future<InspectionRepeatableSection> create(
      InspectionRepeatableSection inspectionRepeatableSection) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(InspectionRepeatableSectionTableKeys.tableName,
        inspectionRepeatableSection.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return inspectionRepeatableSection.copy(id: id);
  }

  Future<InspectionRepeatableSection?> get(int? id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      InspectionRepeatableSectionTableKeys.tableName,
      columns: InspectionRepeatableSectionTableKeys.values,
      where: '${InspectionRepeatableSectionTableKeys.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return InspectionRepeatableSection.fromJson(maps.first);
    } else {
      log("empty");
      return null;
    }
  }

  Future<List<InspectionRepeatableSection>> getAll() async {
    final db = await updatDatabaseInstance.database;

    final result = await db.query(
        InspectionRepeatableSectionTableKeys.tableName,
        orderBy: '${InspectionRepeatableSectionTableKeys.createdAt} DESC');

    return result
        .map((json) => InspectionRepeatableSection.fromJson(json))
        .toList();
  }

  Future<int> update(
      InspectionRepeatableSection inspectionRepeatableSection) async {
    final db = await updatDatabaseInstance.database;

    return await db.update(
      InspectionRepeatableSectionTableKeys.tableName,
      inspectionRepeatableSection.toJson(),
      where: '${InspectionRepeatableSectionTableKeys.id} = ?',
      whereArgs: [inspectionRepeatableSection.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      InspectionRepeatableSectionTableKeys.tableName,
      where: '${InspectionRepeatableSectionTableKeys.id} = ?',
      whereArgs: [id],
    );
  }
}
