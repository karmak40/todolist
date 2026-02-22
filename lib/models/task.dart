class Task {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  DateTime date;
  bool isCompleted;
  final String? userIcon; // URL or asset path
  final String? boardId; // Board reference

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
