import 'package:flutter/material.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:witt/witt.dart';

import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: WRouter.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: WServiceBuilder(
        serviceBuilder: (context) {
          WService.addSingleton(() => TodoController(), preventDuplicate: false);
        },
        child: const MainPage(),
      ),
    );
  }
}
