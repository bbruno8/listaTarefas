// Modelo de dados para uma tarefa
class Todo {
  // Construtor
  Todo({required this.title, required this.dateTime});

  // Construtor a partir de JSON
  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        dateTime = DateTime.parse(json['dateTime']);

  // Título da tarefa
  String title;

  // Data e hora de criação da tarefa
  DateTime dateTime;

  // Converte para JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
