// Importa os pacotes e arquivos necessários
import 'package:flutter/material.dart';
import 'package:listadetarefas/models/todos.dart';
import 'package:listadetarefas/pages/todo_list_page.dart';
import 'package:listadetarefas/widgets/todo_list_itens.dart';

// Página principal da lista de tarefas
class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // Controlador do campo de texto para capturar o que o usuário digita
  final TextEditingController todoController = TextEditingController();

  // Lista de tarefas ativas
  List<Todo> todos = [];

  // Armazena temporariamente uma tarefa deletada, para permitir desfazer
  Todo? deletedTodo;

  // Guarda a posição da tarefa deletada para inserir no mesmo lugar, se desfazer
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campo de adicionar nova tarefa
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Adicione uma tarefa",
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Botão que adiciona a nova tarefa à lista
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(() {
                          // Cria um novo objeto Todo com título e hora atual
                          Todo newTodo = Todo(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          // Adiciona à lista de tarefas
                          todos.add(newTodo);
                        });
                        // Limpa o campo de texto após adicionar
                        todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Icon(Icons.add, size: 25, color: Colors.white),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Lista de tarefas na tela
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(todo: todo, onDelete: onDelete),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Linha inferior com contador e botão de limpar tudo
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Você possue ${todos.length} tarefas pendentes",
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: showDeletedTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        "Limpar tudo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função chamada ao deletar uma tarefa individual
  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });

    // Mostra uma snackbar com opção de desfazer a exclusão
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} foi removida com sucesso!",
          style: TextStyle(color: Color(0xff060708)),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: "Desfazer",
          textColor: Colors.green,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  // Abre um diálogo para confirmar se o usuário quer apagar todas as tarefas
  void showDeletedTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Limpar tudo?"),
        content: Text(
          "Você tem certeza que deseja apagar todas as tarefas?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar", style: TextStyle(color: Colors.green)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deletedAllTodos();
            },
            child: Text("Confirmar", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  // Função que remove todas as tarefas da lista
  void deletedAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
