import 'package:get_it/get_it.dart';

import '../data/datasources/in_memory_todo_local_data_source.dart';
import '../data/datasources/todo_local_data_source.dart';
import '../data/repositories/todo_repository_impl.dart';
import '../domain/repositories/todo_repository.dart';
import '../domain/usecases/add_todo.dart';
import '../domain/usecases/delete_todo.dart';
import '../domain/usecases/get_todos.dart';
import '../domain/usecases/toggle_todo.dart';
import '../presentation/bloc/todo_bloc_factory.dart';

class TodoAssembly {
  static void register(GetIt sl) {
    // Data sources
    sl.registerLazySingleton<TodoLocalDataSource>(
      () => InMemoryTodoLocalDataSource(),
    );

    // Repositories
    sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(local: sl()),
    );

    // Use cases
    sl.registerLazySingleton(() => GetTodos(sl()));
    sl.registerLazySingleton(() => AddTodo(sl()));
    sl.registerLazySingleton(() => ToggleTodo(sl()));
    sl.registerLazySingleton(() => DeleteTodo(sl()));

    // Bloc factory
    sl.registerFactory(
      () => TodoBlocFactory(
        getTodos: sl(),
        addTodo: sl(),
        toggleTodo: sl(),
        deleteTodo: sl(),
      ),
    );
  }
}
