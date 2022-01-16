class Gameover {
  final String? winnerId;
  final WinnerPattern winnerPattern;

  Gameover({
    required this.winnerPattern,
    this.winnerId,
  });
}

class WinnerPattern {
  final int? row;
  final int? col;
  final int? diag;

  WinnerPattern({
    this.row,
    this.col,
    this.diag,
  });
}
