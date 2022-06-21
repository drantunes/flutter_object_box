import 'package:flutter_object_box/database/objectbox_database.dart';
import 'package:flutter_object_box/repositories/feed_repository.dart';
import 'package:flutter_object_box/repositories/todo_repository.dart';
import 'package:flutter_object_box/services/local_auth_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final providers = <SingleChildWidget>[
  Provider<LocalAuthService>(
    create: (context) => LocalAuthService(
      auth: LocalAuthentication(),
    ),
  ),
  ChangeNotifierProvider<PhotosRepository>(
    create: (context) => PhotosRepository(),
  ),
  Provider<ObjectBoxDatabase>(
    create: (context) => ObjectBoxDatabase(),
  ),
  ChangeNotifierProvider<ToDoRepository>(
    create: (context) => ToDoRepository(
      context.read(),
    ),
  ),
];
