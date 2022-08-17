import 'package:auditdat/db/repo/noteRepo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/note.dart';

class UpdatDatabase {
  static final UpdatDatabase instance = UpdatDatabase._init();

  static Database? _database;

  UpdatDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(NoteRepo.createTable());
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}