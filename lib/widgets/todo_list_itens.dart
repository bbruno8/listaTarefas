import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listadetarefas/models/todos.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo, required this.onDelete});

  // Objeto que representa a tarefa
  final Todo todo;

  // Função a ser chamada quando a tarefa for deletada
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Slidable(
        // Widget que permite deslizar para mostrar o botão de deletar
        key: ValueKey(todo.title),
        endActionPane: ActionPane(
          extentRatio: 0.28,
          motion: const DrawerMotion(),
          children: [
            // Botão de deletar que aparece ao deslizar
            SlidableAction(
              onPressed: (context) {
                onDelete(todo);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
              spacing: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              // Deixa o container esticado horizontalmente
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Mostra a data e hora da criação da tarefa formatada
                Text(
                  DateFormat('dd/MM/yy – HH:mm - EEE').format(todo.dateTime),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 4),
                // Mostra o título da tarefa
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
