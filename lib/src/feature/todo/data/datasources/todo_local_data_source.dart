import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> fetchTodos();
  Future<TodoModel> create(String title);
  Future<TodoModel> toggle(String id);
  Future<void> remove(String id);
}
