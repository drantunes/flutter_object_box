import 'package:flutter_object_box/database/objectbox_database.dart';
import 'package:flutter_object_box/repositories/todo_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final providers = <SingleChildWidget>[
  Provider<ObjectBoxDatabase>(
    create: (context) => ObjectBoxDatabase(),
  ),
  ChangeNotifierProvider<ToDoRepository>(
    create: (context) => ToDoRepository(
      context.read(),
    ),
  ),
];
