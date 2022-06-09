import 'package:flutter/material.dart';
import 'package:flutter_object_box/app.dart';
import 'package:flutter_object_box/providers.dart';

import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
  timeago.setDefaultLocale('pt_br');

  runApp(
    MultiProvider(
      providers: providers,
      child: const App(),
    ),
  );
}
