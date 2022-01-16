import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe_frontend/ingection_controller.dart';
import 'package:flutter_tic_tac_toe_frontend/pages/main_page.dart';

void main() async {
  await initIngection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
