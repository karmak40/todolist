import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import '../models/board.dart';

class StorageService {
  static const String tasksBoxName = 'tasks';
  static const String boardsBoxName = 'boards';

  late Box<Task> _tasksBox;
  late Box<Board> _boardsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters (only register if not already registered)
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BoardAdapter());
    }

    // Open boxes
    _tasksBox = await Hive.openBox<Task>(tasksBoxName);
    _boardsBox = await Hive.openBox<Board>(boardsBoxName);
  }

  // Tasks operations
  Future<void> saveTask(Task task) async {
    await _tasksBox.put(task.id, task);
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksBox.delete(taskId);
  }

  List<Task> getAllTasks() {
    return _tasksBox.values.toList();
  }

  Task? getTask(String taskId) {
    return _tasksBox.get(taskId);
  }

  Future<void> clearAllTasks() async {
    await _tasksBox.clear();
  }

  // Boards operations
  Future<void> saveBoard(Board board) async {
    await _boardsBox.put(board.id, board);
  }

  Future<void> deleteBoard(String boardId) async {
    await _boardsBox.delete(boardId);
  }

  List<Board> getAllBoards() {
    return _boardsBox.values.toList();
  }

  Board? getBoard(String boardId) {
    return _boardsBox.get(boardId);
  }

  Future<void> clearAllBoards() async {
    await _boardsBox.clear();
  }

  // Cleanup
  Future<void> close() async {
    await Hive.close();
  }
}
