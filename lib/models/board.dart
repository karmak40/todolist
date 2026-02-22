class Board {
  final String id;
  final String name;
  final String icon;

  Board({
    required this.id,
    required this.name,
    required this.icon,
  });

  Board copyWith({
    String? id,
    String? name,
    String? icon,
  }) {
    return Board(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }
}
