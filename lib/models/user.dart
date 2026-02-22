import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? avatarUrl;

  User({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  User copyWith({
    String? id,
    String? name,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
