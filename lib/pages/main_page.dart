import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe_frontend/widgets/tic_tac_toe_game.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
      ),
      body: const TicTacToeGame(),
    );
  }
}
