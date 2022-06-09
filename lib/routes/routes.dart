import 'package:flutter/material.dart';
import 'package:flutter_object_box/pages/feed_page.dart';
import 'package:flutter_object_box/pages/todo_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/todos/list': (_) => const ToDoPage(),
    '/feed': (_) => const FeedPage(),
  };

  static String initial = '/feed';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState to = Routes.navigatorKey!.currentState!;
}
