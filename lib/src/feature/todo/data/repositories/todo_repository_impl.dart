import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource local;

  TodoRepositoryImpl({required this.local});

  @override
  Future<List<Todo>> getTodos() async {
    final models = await local.fetchTodos();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Todo> addTodo(String title) async {
    final model = await local.create(title);
    return model.toEntity();
  }

  @override
  Future<Todo> toggleTodo(String id) async {
    final model = await local.toggle(id);
    return model.toEntity();
  }

  @override
  Future<void> deleteTodo(String id) => local.remove(id);
}
