import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';
import 'todo_local_data_source.dart';

class InMemoryTodoLocalDataSource implements TodoLocalDataSource {
  final _uuid = const Uuid();
  final List<TodoModel> _store = [
    TodoModel(
      id: 'seed-1',
      title: 'Explore Clean Architecture',
      completed: false,
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    TodoModel(
      id: 'seed-2',
      title: 'Wire BLoC + DI',
      completed: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  Future<T> _delay<T>(T value) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return value;
  }

  @override
  Future<List<TodoModel>> fetchTodos() => _delay(List.unmodifiable(_store));

  @override
  Future<TodoModel> create(String title) async {
    final model = TodoModel(
      id: _uuid.v4(),
      title: title.trim(),
      completed: false,
      createdAt: DateTime.now(),
    );
    _store.insert(0, model);
    return _delay(model);
  }

  @override
  Future<TodoModel> toggle(String id) async {
    final idx = _store.indexWhere((t) => t.id == id);
    if (idx == -1) {
      throw StateError('Todo not found');
    }
    final toggled = _store[idx].copyWith(completed: !_store[idx].completed);
    _store[idx] = toggled;
    return _delay(toggled);
  }

  @override
  Future<void> remove(String id) async {
    _store.removeWhere((t) => t.id == id);
    await _delay(null);
  }
}
