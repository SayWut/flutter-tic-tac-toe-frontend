import 'package:flutter_tic_tac_toe_frontend/entities/game_data.dart';

class GameDataModel extends GameData {
  GameDataModel({
    required String playerTurn,
    required List<List<String?>> board,
  }) : super(
          playerTurn: playerTurn,
          board: board,
        );

  factory GameDataModel.fromJson(Map<String, dynamic> json) {
    List gameBoardList = json["board"];
    List<List<String?>> castGameBoard = gameBoardList
        .map<List<String?>>((e) => (e as List).cast<String?>())
        .toList();

    return GameDataModel(
      playerTurn: json["playerTurn"],
      board: castGameBoard,
    );
  }
}
