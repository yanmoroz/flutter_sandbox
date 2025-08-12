import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/toggle_todo.dart';
import 'todo_bloc.dart';

class TodoBlocFactory {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final ToggleTodo toggleTodo;
  final DeleteTodo deleteTodo;

  TodoBlocFactory({
    required this.getTodos,
    required this.addTodo,
    required this.toggleTodo,
    required this.deleteTodo,
  });

  TodoBloc create() => TodoBloc(
    getTodos: getTodos,
    addTodo: addTodo,
    toggleTodo: toggleTodo,
    deleteTodo: deleteTodo,
  );
}
