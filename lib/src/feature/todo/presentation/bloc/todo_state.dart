part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

class TodoState extends Equatable {
  final TodoStatus status;
  final List<Todo> todos;
  final String? error;

  const TodoState({
    this.status = TodoStatus.initial,
    this.todos = const [],
    this.error,
  });

  TodoState copyWith({TodoStatus? status, List<Todo>? todos, String? error}) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, todos, error];
}
