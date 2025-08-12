import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodos {
  final TodoRepository _repo;

  GetTodos(this._repo);

  Future<List<Todo>> call() => _repo.getTodos();
}
