import 'dart:convert';
import 'package:listadetarefas/models/todos.dart';
import 'package:shared_preferences/shared_preferences.dart';

const todoListKey = 'todo_list';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  // Carrega a lista de tarefas do armazenamento local
  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  // Salva a lista de tarefas no armazenamento local
  void saveTodoList(List<Todo> todos) {
    final String jsonString = json.encode(
      todos.map((todo) => todo.toJson()).toList(),
    );
    sharedPreferences.setString(todoListKey, jsonString);
  }
}
