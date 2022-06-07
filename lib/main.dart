import 'package:flutter/material.dart';
import 'package:flutter_object_box/app.dart';
import 'package:flutter_object_box/providers.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: providers,
      child: const App(),
    ),
  );
}
