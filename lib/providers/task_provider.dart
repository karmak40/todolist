import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Купить продукты',
      description: 'Купить хлеб, молоко, яйца и масло на рынке',
      durationMinutes: 30,
      date: DateTime.now(),
      isCompleted: false,
    ),
    Task(
      id: '2',
      title: 'Написать отчет',
      description: 'Завершить квартальный отчет для начальника',
      durationMinutes: 120,
      date: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      id: '3',
      title: 'Спортзал',
      description: 'Тренировка: 20 минут кардио + силовые упражнения',
      durationMinutes: 90,
      date: DateTime.now(),
      isCompleted: false,
    ),
    Task(
      id: '4',
      title: 'Позвонить маме',
      description: 'Обновить на встречу в выходной',
      durationMinutes: 15,
      date: DateTime.now().add(const Duration(days: 1)),
      isCompleted: false,
    ),
    Task(
      id: '5',
      title: 'Прочитать статью',
      description: 'Новая статья по Flutter разработке',
      durationMinutes: 45,
      date: DateTime.now(),
      isCompleted: false,
    ),
  ];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    updateTask(updatedTask);
  }

  List<Task> getTasksByDate(DateTime date) {
    return _tasks
        .where((task) =>
            task.date.year == date.year &&
            task.date.month == date.month &&
            task.date.day == date.day)
        .toList();
  }

  List<Task> getAllTasks() => _tasks;

  int getCompletionPercentageForDate(DateTime date) {
    final tasksForDate = getTasksByDate(date);
    if (tasksForDate.isEmpty) return 0;
    final completed =
        tasksForDate.where((task) => task.isCompleted).length;
    return ((completed / tasksForDate.length) * 100).toInt();
  }

  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }
}
