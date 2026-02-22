import '../models/task.dart';

class Board {
  final String id;
  final String name;
  final String icon;
  final List<Task> tasks;

  Board({
    required this.id,
    required this.name,
    required this.icon,
    this.tasks = const [],
  });

  Board copyWith({
    String? id,
    String? name,
    String? icon,
    List<Task>? tasks,
  }) {
    return Board(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      tasks: tasks ?? this.tasks,
    );
  }
}
