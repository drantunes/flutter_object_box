import 'package:flutter/material.dart';
import 'package:flutter_object_box/database/objectbox.g.dart';
import 'package:flutter_object_box/database/objectbox_database.dart';
import 'package:flutter_object_box/entities/todo.dart';

class ToDoRepository extends ChangeNotifier {
  List<ToDo> _todos = [];

  late final ObjectBoxDatabase _database;

  ToDoRepository(this._database);

  List<ToDo> get todos => _todos;

  Future<Box> getBox() async {
    final store = await _database.getStore();
    return store.box<ToDo>();
  }

  save(String task) async {
    final todo = ToDo(done: false, task: task);
    final box = await getBox();
    box.put(todo);
    todos.add(todo);
    notifyListeners();
  }

  update(ToDo todo) async {
    final box = await getBox();
    box.put(todo);
    todos.add(todo);
    notifyListeners();
  }

  getAll() async {
    final box = await getBox();
    _todos = box.getAll() as List<ToDo>;
    notifyListeners();
  }

  remove(ToDo todo) async {
    final box = await getBox();
    box.remove(todo.id);
    todos.remove(todo);
    notifyListeners();
  }

  getTodosNotDone() async {
    final box = await getBox();
    final query = box.query(ToDo_.done.equals(false)).build();
    _todos = query.find() as List<ToDo>;
    query.close();
    notifyListeners();
  }
}
