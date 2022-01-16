import 'package:flutter_tic_tac_toe_frontend/tic_tac_toe_client.dart';
import 'package:get/get.dart';

class TicTacToeConroller extends GetxController {
  late List<List<String>> gameGrid;
  late TicTacToeClient client;
  List<int>? winnerSquares;
  late bool enableButtons;
  late bool isGameover;
  RxBool isConnected = false.obs;
  RxString gameStatusText = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initProperties();

    client.onConnect(() {
      isConnected.value = true;
      gameStatusText.value = "Connected to the server";
    });

    client.onDisconnect(() {
      if (!isGameover) {
        gameStatusText.value = "Couldn't find any player";
      }
      isConnected.value = false;
    });

    client.onUpdateGameData((gameData) {
      for (var i = 0; i < gameData.board.length; i++) {
        for (var j = 0; j < gameData.board[i].length; j++) {
          final squareValue = gameData.board[i][j];
          if (squareValue == client.socket.id) {
            gameGrid[i][j] = "X";
          } else if (squareValue != null) {
            gameGrid[i][j] = "O";
          }
        }
      }

      enableButtons = client.socket.id == gameData.playerTurn;
      update();
    });

    client.onWaitForPlayer(() {
      enableButtons = false;
      gameStatusText.value = "Waiting for player";
      update();
    });

    client.onStartGame((gameData) {
      gameStatusText.value = "Game Started";
      enableButtons = client.socket.id == gameData.playerTurn;
      update();
    });

    client.onGameover((data) {
      isGameover = true;
      gameStatusText.value = "Game over: ";
      gameStatusText.value +=
          data.winnerId == client.socket.id ? "You Win" : "You Lose";

      final winnerRow = data.winnerPattern.row;
      final winnerCol = data.winnerPattern.col;
      final winnerDiag = data.winnerPattern.diag;

      if (winnerRow != null) {
        final firstRowIndex = winnerRow * 3;
        winnerSquares = [
          ...?winnerSquares,
          firstRowIndex,
          firstRowIndex + 1,
          firstRowIndex + 2
        ];
      }

      if (winnerCol != null) {
        final firstColIndex = winnerCol;
        winnerSquares = [
          ...?winnerSquares,
          firstColIndex,
          firstColIndex + 3,
          firstColIndex + 6
        ];
      }

      if (winnerDiag != null) {
        if (winnerDiag == 0) {
          winnerSquares = [...?winnerSquares, 0, 4, 8];
        }
        if (winnerDiag == 1) {
          winnerSquares = [...?winnerSquares, 2, 4, 6];
        }
      }

      enableButtons = false;
      update();
    });

    client.connect();
  }

  void _initProperties() {
    gameGrid = List.generate(3, (_) => List.filled(3, ""));
    client = TicTacToeClient.getInstance();
    winnerSquares = null;
    enableButtons = false;
    isGameover = false;
    isConnected.value = false;
  }

  void reconnectNewGame() {
    _initProperties();
    client.connect();
    update();
  }

  void selectedSquare(int row, int col) {
    client.emitSelectSquare(row, col);
  }

  bool isWinnerSquare(int index) =>
      isGameover && (winnerSquares?.contains(index) ?? false);
}
