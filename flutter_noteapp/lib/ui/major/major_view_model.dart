import 'package:flutter_noteapp/model/login_info.dart';
import 'package:flutter_noteapp/model/major.dart';
import 'package:flutter_noteapp/utils/app_variables.dart';
import 'package:scoped_model/scoped_model.dart';

class MajorViewModel extends Model {
  static final MajorViewModel _instance = MajorViewModel._internal();
  factory MajorViewModel() => _instance;
  MajorViewModel._internal() {
    updateList();
  }
  List<Major> majors = [];
 
  void updateList() async {
    final results = await AppVariable.api.getMajors();
    majors = results.data ?? [];

    notifyListeners();
  }

  void save(Major major) async {
    major.id == 0
        ? await AppVariable.api.addMajor(major)
        : await AppVariable.api.updateMajor(major.id, major);
  }

  void delete(Major major) async {
    await AppVariable.api.deleteMajor(major.id);
    updateList();
  }
}
