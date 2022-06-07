import 'package:flutter/material.dart';
import 'package:flutter_object_box/pages/todo_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/todos/list': (_) => const ToDoPage(),
  };

  static String initial = '/todos/list';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState to = Routes.navigatorKey!.currentState!;
}
