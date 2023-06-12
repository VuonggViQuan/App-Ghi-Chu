import 'package:flutter_noteapp/dao/database.dart';
import 'package:flutter_noteapp/model/note_model.dart';
import 'package:sqflite/sql.dart';

class Note_DAO {
  static const TABLE_NAME = "notetable";
  static const COL_ID = "Note_ID";
  static const COL_TITLE = "Title";
  static const COL_DESCRIPTION = "Description";
  static String createTable() => '''
    create table if not exists $TABLE_NAME (
      $COL_ID integer primary key autoincrement not null,
      $COL_TITLE text ,
      $COL_DESCRIPTION text
    );
 ''';
  Map<String, dynamic> _toMap(Note_Model noteModel) {
    return {COL_TITLE: noteModel.title, COL_DESCRIPTION: noteModel.description};
  }

  Note_Model _toNote(Map<String, dynamic> map) {
    return Note_Model.withArgs(
        id: map[COL_ID],
        title: map[COL_TITLE],
        description: map[COL_DESCRIPTION]);
  }

  Future<bool> insert(Note_Model note_model) async {
    final db = await DB().open();
    final result = await db.insert(TABLE_NAME, _toMap(note_model),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.close();
    return result > 0;
  }

  Future<bool> delete(int id) async {
    final db = await DB().open();
    final result =
        await db.delete(TABLE_NAME, where: '$COL_ID = ?', whereArgs: [id]);
    db.close();
    return result > 0;
  }

  Future<bool> update(Note_Model note_model) async {
    final db = await DB().open();
    final result = await db.update(TABLE_NAME, _toMap(note_model),
        where: '$COL_ID = ?', whereArgs: [note_model.id]);
    db.close();
    return result > 0;
  }

  Future<Note_Model?> get(int id) async {
    final db = await DB().open();
    final results =
        await db.query(TABLE_NAME, where: '$COL_ID = ?', whereArgs: [id]);
    db.close();
    return results.isEmpty ? null : _toNote(results[0]);
  }

  Future<List<Note_Model>> getNotes() async {
    final db = await DB().open();
    final results = await db.query(TABLE_NAME);
    db.close();
    return List.generate(results.length, (index) => _toNote(results[index]));
  }
}
