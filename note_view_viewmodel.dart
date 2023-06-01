import 'package:flutter_noteapp/dao/Note_DAO.dart';
import 'package:flutter_noteapp/model/note_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Note_View_Model extends Model {
  static final Note_View_Model _instance = Note_View_Model._internal();
  factory Note_View_Model() => _instance;
  Note_DAO _repo = Note_DAO();
  List<Note_Model> notes = [];

  Note_View_Model._internal() {
    updateList();
    notifyListeners();
  }
  void updateList() async {
    notes = await _repo.getNotes();
    notifyListeners();
  }

  void save(Note_Model? note_model) async {
    note_model!.id == 0
        ? await _repo.insert(note_model)
        : await _repo.update(note_model);
  }

  void delete(Note_Model note_model) async {
    await _repo.delete(note_model.id);
    updateList();
  }
}
