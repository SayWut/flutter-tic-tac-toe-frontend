import 'package:flutter_tic_tac_toe_frontend/entities/gameover.dart';

class GameoverModel extends Gameover {
  GameoverModel({
    required WinnerPattern winnerPattern,
    String? winnerId,
  }) : super(
          winnerId: winnerId,
          winnerPattern: winnerPattern,
        );

  factory GameoverModel.fromJson(Map<String, dynamic> json) {
    return GameoverModel(
      winnerPattern: WinnerPatternModel.fromJson(json["winnerPattern"]),
      winnerId: json["winnerId"],
    );
  }
}

class WinnerPatternModel extends WinnerPattern {
  WinnerPatternModel({
    int? row,
    int? col,
    int? diag,
  }) : super(
          row: row,
          col: col,
          diag: diag,
        );

  factory WinnerPatternModel.fromJson(Map<String, dynamic> json) {
    return WinnerPatternModel(
      row: json["row"],
      col: json["col"],
      diag: json["diag"],
    );
  }
}
