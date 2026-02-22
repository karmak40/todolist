import 'package:flutter/material.dart';
import '../models/board.dart';
import '../models/task.dart';

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
    final board = _boards.firstWhere(
      (b) => b.id == boardId,
      orElse: () => Board(id: '', name: '', icon: ''),
    );
    return board.tasks.where((task) => !task.isCompleted).length;
  }

  void addTaskToBoard(String boardId, Task task) {
    final boardIndex = _boards.indexWhere((board) => board.id == boardId);
    if (boardIndex != -1) {
      final board = _boards[boardIndex];
      final updatedTasks = [...board.tasks, task];
      _boards[boardIndex] = board.copyWith(tasks: updatedTasks);
      notifyListeners();
    }
  }

  void updateTaskInBoard(String boardId, Task updatedTask) {
    final boardIndex = _boards.indexWhere((board) => board.id == boardId);
    if (boardIndex != -1) {
      final board = _boards[boardIndex];
      final taskIndex = board.tasks.indexWhere((t) => t.id == updatedTask.id);
      if (taskIndex != -1) {
        final updatedTasks = [...board.tasks];
        updatedTasks[taskIndex] = updatedTask;
        _boards[boardIndex] = board.copyWith(tasks: updatedTasks);
        notifyListeners();
      }
    }
  }
}
