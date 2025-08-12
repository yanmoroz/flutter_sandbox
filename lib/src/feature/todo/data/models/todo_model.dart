import '../../domain/entities/todo.dart';

class TodoModel {
  final String id;
  final String title;
  final bool completed;
  final DateTime createdAt;

  const TodoModel({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdAt,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    bool? completed,
    DateTime? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
    id: map['id'] as String,
    title: map['title'] as String,
    completed: map['completed'] as bool,
    createdAt: DateTime.parse(map['createdAt'] as String),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'completed': completed,
    'createdAt': createdAt.toIso8601String(),
  };

  Todo toEntity() =>
      Todo(id: id, title: title, completed: completed, createdAt: createdAt);

  factory TodoModel.fromEntity(Todo e) => TodoModel(
    id: e.id,
    title: e.title,
    completed: e.completed,
    createdAt: e.createdAt,
  );
}
