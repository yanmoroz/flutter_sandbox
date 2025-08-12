import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/toggle_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos _getTodos;
  final AddTodo _addTodo;
  final ToggleTodo _toggleTodo;
  final DeleteTodo _deleteTodo;

  TodoBloc({
    required GetTodos getTodos,
    required AddTodo addTodo,
    required ToggleTodo toggleTodo,
    required DeleteTodo deleteTodo,
  }) : _getTodos = getTodos,
       _addTodo = addTodo,
       _toggleTodo = toggleTodo,
       _deleteTodo = deleteTodo,
       super(const TodoState()) {
    on<LoadTodos>(_onLoad);
    on<AddTodoPressed>(_onAdd);
    on<ToggleTodoPressed>(_onToggle);
    on<DeleteTodoPressed>(_onDelete);
  }

  Future<void> _onLoad(LoadTodos event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final todos = await _getTodos();
      emit(state.copyWith(status: TodoStatus.success, todos: todos));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onAdd(AddTodoPressed event, Emitter<TodoState> emit) async {
    try {
      final created = await _addTodo(event.title);
      final updated = [created, ...state.todos];
      emit(state.copyWith(status: TodoStatus.success, todos: updated));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onToggle(
    ToggleTodoPressed event,
    Emitter<TodoState> emit,
  ) async {
    try {
      final toggled = await _toggleTodo(event.id);
      final updated = state.todos
          .map((t) => t.id == toggled.id ? toggled : t)
          .toList();
      emit(state.copyWith(status: TodoStatus.success, todos: updated));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteTodoPressed event,
    Emitter<TodoState> emit,
  ) async {
    try {
      await _deleteTodo(event.id);
      final updated = state.todos.where((t) => t.id != event.id).toList();
      emit(state.copyWith(status: TodoStatus.success, todos: updated));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure, error: e.toString()));
    }
  }
}
