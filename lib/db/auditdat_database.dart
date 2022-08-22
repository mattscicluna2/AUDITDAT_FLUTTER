import 'package:auditdat/constants/db_constants.dart';
import 'package:auditdat/db/model/sync_last_updated.dart';
import 'package:auditdat/db/model/template.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/note_repo.dart';
import 'package:auditdat/db/repo/sync_last_updated_repo.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';
import 'package:auditdat/db/repo/template_repo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer';
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

    return await openDatabase(path, version: DBConstants.version, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(SyncLastUpdatedRepo.createTable());

    await db.execute(NoteRepo.createTable());
    await db.execute(TemplateCategoryRepo.createTable());
    await db.execute(TemplateRepo.createTable());
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    log("SQLiteDatabase.onUpgrade ($oldVersion => $newVersion)");
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE IF EXISTS ${SyncLastUpdatedTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS $tableNotes");
      await db.execute("DROP TABLE IF EXISTS ${TemplateCategoryTableKeys.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${TemplateTableKeys.tableName}");

      await _createDB(db, newVersion);
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}