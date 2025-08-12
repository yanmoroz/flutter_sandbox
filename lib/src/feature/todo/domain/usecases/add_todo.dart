import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository _repo;

  AddTodo(this._repo);

  Future<Todo> call(String title) => _repo.addTodo(title);
}
