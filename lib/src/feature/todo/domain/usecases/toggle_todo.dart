import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class ToggleTodo {
  final TodoRepository _repo;

  ToggleTodo(this._repo);

  Future<Todo> call(String id) => _repo.toggleTodo(id);
}
