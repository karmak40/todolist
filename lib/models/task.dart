import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int durationMinutes;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  bool isCompleted;
  @HiveField(6)
  final String? userIcon;
  @HiveField(7)
  final String? boardId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.date,
    this.isCompleted = false,
    this.userIcon,
    this.boardId,
  });

  // Копирование с изменениями
  Task copyWith({
    String? id,
    String? title,
    String? description,
    int? durationMinutes,
    DateTime? date,
    bool? isCompleted,
    String? userIcon,
    String? boardId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      userIcon: userIcon ?? this.userIcon,
      boardId: boardId ?? this.boardId,
    );
  }
}
