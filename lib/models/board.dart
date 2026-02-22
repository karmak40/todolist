import 'package:hive/hive.dart';
import 'task.dart';

part 'board.g.dart';

@HiveType(typeId: 1)
class Board {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String icon;
  @HiveField(3)
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
