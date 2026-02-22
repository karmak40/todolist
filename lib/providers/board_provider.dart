import 'package:flutter/material.dart';
import '../models/board.dart';
import '../models/task.dart';
import '../services/storage_service.dart';

class BoardProvider extends ChangeNotifier {
  late List<Board> _boards = [];
  final StorageService _storageService = StorageService();

  List<Board> get boards => _boards;

  Future<void> init() async {
    await _storageService.init();
    await loadBoards();
  }

  Future<void> loadBoards() async {
    _boards = _storageService.getAllBoards();
    if (_boards.isEmpty) {
      // Add default boards if empty
      _boards = [
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
      // Save default boards
      for (var board in _boards) {
        await _storageService.saveBoard(board);
      }
    }
    notifyListeners();
  }

  Future<void> addBoard(Board board) async {
    _boards.add(board);
    await _storageService.saveBoard(board);
    notifyListeners();
  }

  Future<void> removeBoard(String boardId) async {
    _boards.removeWhere((board) => board.id == boardId);
    await _storageService.deleteBoard(boardId);
    notifyListeners();
  }

  int getActiveBoardTaskCount(String boardId) {
    final board = _boards.firstWhere(
      (b) => b.id == boardId,
      orElse: () => Board(id: '', name: '', icon: ''),
    );
    return board.tasks.where((task) => !task.isCompleted).length;
  }

  Future<void> addTaskToBoard(String boardId, Task task) async {
    final boardIndex = _boards.indexWhere((board) => board.id == boardId);
    if (boardIndex != -1) {
      final board = _boards[boardIndex];
      final updatedTasks = [...board.tasks, task];
      _boards[boardIndex] = board.copyWith(tasks: updatedTasks);
      await _storageService.saveBoard(_boards[boardIndex]);
      notifyListeners();
    }
  }

  Future<void> updateTaskInBoard(String boardId, Task updatedTask) async {
    final boardIndex = _boards.indexWhere((board) => board.id == boardId);
    if (boardIndex != -1) {
      final board = _boards[boardIndex];
      final taskIndex = board.tasks.indexWhere((t) => t.id == updatedTask.id);
      if (taskIndex != -1) {
        final updatedTasks = [...board.tasks];
        updatedTasks[taskIndex] = updatedTask;
        _boards[boardIndex] = board.copyWith(tasks: updatedTasks);
        await _storageService.saveBoard(_boards[boardIndex]);
        notifyListeners();
      }
    }
  }
}
