import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../widgets/todo_item_tile.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clean Todos')),
      body: BlocConsumer<TodoBloc, TodoState>(
        listenWhen: (prev, curr) =>
            prev.error != curr.error && curr.error != null,
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case TodoStatus.initial:
            case TodoStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case TodoStatus.failure:
              return Center(
                child: Text('Failed: ${state.error ?? 'unknown error'}'),
              );
            case TodoStatus.success:
              if (state.todos.isEmpty) {
                return const Center(child: Text('No todos yet. Add one!'));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.todos.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  return TodoItemTile(
                    todo: todo,
                    onToggle: () => context.read<TodoBloc>().add(
                      ToggleTodoPressed(todo.id),
                    ),
                    onDelete: () => context.read<TodoBloc>().add(
                      DeleteTodoPressed(todo.id),
                    ),
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final title = await showDialog<String>(
            context: context,
            builder: (_) => const _AddTodoDialog(),
          );
          if (title != null && context.mounted) {
            context.read<TodoBloc>().add(AddTodoPressed(title));
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}

class _AddTodoDialog extends StatefulWidget {
  const _AddTodoDialog();

  @override
  State<_AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<_AddTodoDialog> {
  final _controller = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_form.currentState!.validate()) {
      Navigator.of(context).pop(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Todo'),
      content: Form(
        key: _form,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'What needs to be done?',
            border: OutlineInputBorder(),
          ),
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Please enter a title'
              : null,
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
