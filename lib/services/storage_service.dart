import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import '../models/board.dart';
import '../models/user.dart';

class StorageService {
  static const String tasksBoxName = 'tasks';
  static const String boardsBoxName = 'boards';
  static const String userBoxName = 'user';
  static const String userKey = 'current_user';

  late Box<Task> _tasksBox;
  late Box<Board> _boardsBox;
  late Box<User> _userBox;

  Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters (only register if not already registered)
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BoardAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(UserAdapter());
    }

    // Open boxes
    _tasksBox = await Hive.openBox<Task>(tasksBoxName);
    _boardsBox = await Hive.openBox<Board>(boardsBoxName);
    _userBox = await Hive.openBox<User>(userBoxName);
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

  // User operations
  Future<void> saveUser(User user) async {
    await _userBox.put(userKey, user);
  }

  User? getUser() {
    return _userBox.get(userKey);
  }

  Future<void> deleteUser() async {
    await _userBox.delete(userKey);
  }

  // Cleanup
  Future<void> close() async {
    await Hive.close();
  }
}
