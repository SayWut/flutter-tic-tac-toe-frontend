import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe_frontend/controllers/tic_tac_toe_conroller.dart';
import 'package:get/get.dart';

class TicTacToeGame extends GetView<TicTacToeConroller> {
  const TicTacToeGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              crossAxisCount: 3,
              childAspectRatio: 2,
            ),
            itemBuilder: (_, index) {
              final row = index ~/ 3;
              final col = index % 3;

              return GetBuilder(
                init: TicTacToeConroller(),
                builder: (_) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onSurface: controller.isWinnerSquare(index)
                          ? Colors.red.shade900
                          : Colors.blue,
                    ),
                    onPressed: controller.enableButtons
                        ? () {
                            controller.selectedSquare(row, col);
                          }
                        : null,
                    child: Text(
                      controller.gameGrid[row][col],
                      style: const TextStyle(fontSize: 50.0),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Obx(
          () => Text(
            controller.gameStatusText.value,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Obx(
          () => Visibility(
            visible: !controller.isConnected.value,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: ElevatedButton(
              onPressed: () {
                controller.reconnectNewGame();
              },
              child: const Text("New Game"),
            ),
          ),
        ),
      ],
    );
  }
}
