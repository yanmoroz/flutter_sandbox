import '../repositories/todo_repository.dart';

class DeleteTodo {
  final TodoRepository _repo;

  DeleteTodo(this._repo);

  Future<void> call(String id) => _repo.deleteTodo(id);
}
