import 'package:auditdat/db/model/note.dart';
import 'package:flutter/material.dart';

import '../auditdat_database.dart';

class NoteRepo {
  static final NoteRepo instance = NoteRepo._init();
  final UpdatDatabase updatDatabaseInstance = UpdatDatabase.instance;

  NoteRepo._init();

  static String createTable() {
    return '''
      CREATE TABLE $tableNotes ( 
        ${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${NoteFields.isImportant} BOOLEAN NOT NULL,
        ${NoteFields.number} INTEGER NOT NULL,
        ${NoteFields.title} TEXT NOT NULL,
        ${NoteFields.description} TEXT NOT NULL,
        ${NoteFields.time} TEXT NOT NULL
        )
      ''';
  }

  Future<Note> create(Note note) async {
    final db = await updatDatabaseInstance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await updatDatabaseInstance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await updatDatabaseInstance.database;

    final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await updatDatabaseInstance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await updatDatabaseInstance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }
}
