import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';

class TodoItemTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItemTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red.withValues(alpha: 0.1),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete_outline, color: Colors.red),
      ),
      confirmDismiss: (_) async {
        final ok = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Delete todo?'),
            content: Text('Are you sure you want to delete "${todo.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        return ok ?? false;
      },
      onDismissed: (_) => onDelete(),
      child: ListTile(
        leading: Checkbox(value: todo.completed, onChanged: (_) => onToggle()),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? Colors.grey : null,
          ),
        ),
        subtitle: Text(
          'Created ${_formatTime(todo.createdAt)}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Icon(
          todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: todo.completed ? Colors.green : Colors.grey,
        ),
        onTap: onToggle,
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} h ago';
    return '${dt.year}/${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}';
  }
}
