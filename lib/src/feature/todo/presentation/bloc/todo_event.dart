part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {
  const LoadTodos();
}

class AddTodoPressed extends TodoEvent {
  final String title;

  const AddTodoPressed(this.title);

  @override
  List<Object?> get props => [title];
}

class ToggleTodoPressed extends TodoEvent {
  final String id;

  const ToggleTodoPressed(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteTodoPressed extends TodoEvent {
  final String id;

  const DeleteTodoPressed(this.id);

  @override
  List<Object?> get props => [id];
}
