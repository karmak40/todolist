import 'package:flutter/material.dart';
import '../models/board.dart';

class BoardProvider extends ChangeNotifier {
  final List<Board> _boards = [
    Board(
      id: '1',
      name: 'Спорт',
      icon: '⚽',
    ),
    Board(
      id: '2',
      name: 'Работа',
      icon: '💼',
    ),
    Board(
      id: '3',
      name: 'Личное',
      icon: '📝',
    ),
  ];

  List<Board> get boards => _boards;

  void addBoard(Board board) {
    _boards.add(board);
    notifyListeners();
  }

  void removeBoard(String boardId) {
    _boards.removeWhere((board) => board.id == boardId);
    notifyListeners();
  }

  int getActiveBoardTaskCount(String boardId) {
    // Placeholder - in real app this would count tasks with this board
    return 4;
  }
}
