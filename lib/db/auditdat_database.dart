import 'dart:developer';

import 'package:auditdat/constants/db_constants.dart';
import 'package:auditdat/db/model/sync_last_updated.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/model/template_check.dart';
import 'package:auditdat/db/model/template_component.dart';
import 'package:auditdat/db/model/template_field.dart';
import 'package:auditdat/db/model/template_page.dart';
import 'package:auditdat/db/model/template_section.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/note_repo.dart';
import 'package:auditdat/db/repo/sync_last_updated_repo.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';
import 'package:auditdat/db/repo/template_check_repo.dart';
import 'package:auditdat/db/repo/template_component_repo.dart';
import 'package:auditdat/db/repo/template_field_repo.dart';
import 'package:auditdat/db/repo/template_page_repo.dart';
import 'package:auditdat/db/repo/template_repo.dart';
import 'package:auditdat/db/repo/template_section_repo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/note.dart';

class UpdatDatabase {
  static final UpdatDatabase instance = UpdatDatabase._init();

  static Database? _database;

  UpdatDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(DBConstants.name);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: DBConstants.version,
        onCreate: _createDB,
        onUpgrade: _upgradeDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(SyncLastUpdatedRepo.createTable());

    await db.execute(NoteRepo.createTable());
    await db.execute(TemplateCategoryRepo.createTable());

    await db.execute(TemplateVersionRepo.createTable());
    await db.execute(TemplatePageRepo.createTable());
    await db.execute(TemplateComponentRepo.createTable());
    await db.execute(TemplateSectionRepo.createTable());
    await db.execute(TemplateCheckRepo.createTable());
    await db.execute(TemplateFieldRepo.createTable());
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    log("SQLiteDatabase.onUpgrade ($oldVersion => $newVersion)");
    if (oldVersion < newVersion) {
      await db.execute(
          "DROP TABLE IF EXISTS ${SyncLastUpdatedTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS $tableNotes");
      await db.execute(
          "DROP TABLE IF EXISTS ${TemplateCategoryTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${TemplateTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${TemplatePageTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${TemplateComponentTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${TemplateSectionTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${TemplateCheckTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${TemplateFieldTableKeys.tableName}");

      await _createDB(db, newVersion);
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
