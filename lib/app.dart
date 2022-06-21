import 'package:flutter/material.dart';

import 'package:flutter_object_box/routes/routes.dart';

class App extends StatelessWidget {
  final MaterialColor colorSeed = Colors.deepPurple;

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: colorSeed,
        // appBarTheme: Theme.of(context).appBarTheme.copyWith(
        //       backgroundColor: Colors.black,
        //     ),
      ),
      routes: Routes.list,
      initialRoute: Routes.authCheck,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
