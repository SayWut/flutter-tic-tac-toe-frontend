import 'dart:convert';

import 'package:flutter_tic_tac_toe_frontend/core/constants.dart';
import 'package:flutter_tic_tac_toe_frontend/entities/game_data.dart';
import 'package:flutter_tic_tac_toe_frontend/entities/gameover.dart';
import 'package:flutter_tic_tac_toe_frontend/models/game_data_model.dart';
import 'package:flutter_tic_tac_toe_frontend/models/gameover_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart' show kIsWeb;

typedef ParamEventHandler<T> = dynamic Function(T data);
typedef GameDataEventHandler = void Function(GameData data);
typedef GameoverEventHandler = void Function(Gameover data);
typedef EventHandler = void Function();

class TicTacToeClient {
  static TicTacToeClient? _instance;

  late final IO.Socket socket;

  TicTacToeClient._internal() {
    final optionBuilder = IO.OptionBuilder();
    optionBuilder
      ..disableAutoConnect()
      ..disableReconnection();

    if (!kIsWeb) {
      optionBuilder.setTransports(["websocket"]);
    }

    socket = IO.io(Contants.serverUri, optionBuilder.build());
  }

  static TicTacToeClient getInstance() {
    return _instance ??= TicTacToeClient._internal();
  }

  void onConnect(EventHandler handler) {
    socket.onConnect((data) => handler());
  }

  void onDisconnect(EventHandler handler) {
    socket.onDisconnect((data) => handler());
  }

  void onWaitForPlayer(EventHandler handler) =>
      socket.on(_ServerEvents.waitForPlayer, (data) => handler());

  void onStartGame(GameDataEventHandler handler) =>
      socket.on(_ServerEvents.startGame, (data) {
        GameData gameData = GameDataModel.fromJson(data);
        handler(gameData);
      });

  void onUpdateGameData(GameDataEventHandler handler) =>
      socket.on(_ServerEvents.updateGameData, (data) {
        GameData gameData = GameDataModel.fromJson(data);
        handler(gameData);
      });

  void onGameover(GameoverEventHandler handler) =>
      socket.on(_ServerEvents.gameover, (data) {
        Gameover gameover = GameoverModel.fromJson(data);
        handler(gameover);
      });

  void emitSelectSquare(int row, int col) =>
      socket.emit(_ClientEvents.selectSquare, [row, col]);

  void connect() => socket.connect();
}

abstract class _ServerEvents {
  static const waitForPlayer = "server::waitForPlayer";
  static const startGame = "server::startGame";
  static const updateGameData = "server::updateGameData";
  static const gameover = "server::gameover";
}

abstract class _ClientEvents {
  static const selectSquare = "client::selectSquare";
}
