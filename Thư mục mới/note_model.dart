class Note_Model {
  int id;
  String title;
  String description;

  Note_Model.withArgs(
      {this.id = 0, required this.title, required this.description});
}
