import 'dart:developer';

import 'package:auditdat/constants/db_constants.dart';
import 'package:auditdat/db/auditdat_seeders.dart';
import 'package:auditdat/db/model/inspection.dart';
import 'package:auditdat/db/model/inspection_check.dart';
import 'package:auditdat/db/model/inspection_field_value.dart';
import 'package:auditdat/db/model/inspection_repeatable_section.dart';
import 'package:auditdat/db/model/inspection_status.dart';
import 'package:auditdat/db/model/note.dart';
import 'package:auditdat/db/model/sync_last_updated.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/model/template_check.dart';
import 'package:auditdat/db/model/template_component.dart';
import 'package:auditdat/db/model/template_field.dart';
import 'package:auditdat/db/model/template_field_type.dart';
import 'package:auditdat/db/model/template_page.dart';
import 'package:auditdat/db/model/template_response.dart';
import 'package:auditdat/db/model/template_response_group.dart';
import 'package:auditdat/db/model/template_section.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/inspection_check_repo.dart';
import 'package:auditdat/db/repo/inspection_field_value_repo.dart';
import 'package:auditdat/db/repo/inspection_repeatable_section_repo.dart';
import 'package:auditdat/db/repo/inspection_repo.dart';
import 'package:auditdat/db/repo/inspection_status_repo.dart';
import 'package:auditdat/db/repo/note_repo.dart';
import 'package:auditdat/db/repo/sync_last_updated_repo.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';
import 'package:auditdat/db/repo/template_check_repo.dart';
import 'package:auditdat/db/repo/template_component_repo.dart';
import 'package:auditdat/db/repo/template_field_repo.dart';
import 'package:auditdat/db/repo/template_field_type_repo.dart';
import 'package:auditdat/db/repo/template_page_repo.dart';
import 'package:auditdat/db/repo/template_response_group_repo.dart';
import 'package:auditdat/db/repo/template_response_repo.dart';
import 'package:auditdat/db/repo/template_section_repo.dart';
import 'package:auditdat/db/repo/template_version_repo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AuditdatDatabase {
  static final AuditdatDatabase instance = AuditdatDatabase._init();

  static Database? _database;

  AuditdatDatabase._init();

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
    List<String> tablesToCreate = [
      SyncLastUpdatedRepo.createTable(),
      NoteRepo.createTable(),
      TemplateCategoryRepo.createTable(),
      TemplateResponseGroupRepo.createTable(),
      TemplateResponseRepo.createTable(),
      TemplateFieldTypeRepo.createTable(),
      TemplateVersionRepo.createTable(),
      TemplatePageRepo.createTable(),
      TemplateComponentRepo.createTable(),
      TemplateSectionRepo.createTable(),
      TemplateCheckRepo.createTable(),
      TemplateFieldRepo.createTable(),
      InspectionStatusRepo.createTable(),
      InspectionRepo.createTable(),
      InspectionRepeatableSectionRepo.createTable(),
      InspectionFieldValueRepo.createTable(),
      InspectionCheckRepo.createTable(),
    ];

    for (var element in tablesToCreate) {
      await db.execute(element);
    }

    //Seed Static data
    await (AuditdatSeeders()).run();
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    log("SQLiteDatabase.onUpgrade ($oldVersion => $newVersion)");
    if (oldVersion < newVersion) {
      List<String> tablesToDrop = [
        SyncLastUpdatedTableKeys.tableName,
        tableNotes,
        TemplateResponseGroupTableKeys.tableName,
        TemplateResponseTableKeys.tableName,
        TemplateFieldTypeTableKeys.tableName,
        TemplateCategoryTableKeys.tableName,
        TemplateVersionTableKeys.tableName,
        TemplatePageTableKeys.tableName,
        TemplateComponentTableKeys.tableName,
        TemplateSectionTableKeys.tableName,
        TemplateCheckTableKeys.tableName,
        TemplateFieldTableKeys.tableName,
        InspectionStatusTableKeys.tableName,
        InspectionTableKeys.tableName,
        InspectionRepeatableSectionTableKeys.tableName,
        InspectionFieldValueTableKeys.tableName,
        InspectionCheckTableKeys.tableName,
      ];

      for (var element in tablesToDrop) {
        await db.execute("DROP TABLE IF EXISTS ${element}");
      }

      await _createDB(db, newVersion);
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
