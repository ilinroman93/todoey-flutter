class Task {
  final int id;
  final String name;
  bool isDone;

  Task({this.id, this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['is_done'] = isDone ? 1 : 0;
    return map;
  }

  Task.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        isDone = map['is_done'] == 1;
}
