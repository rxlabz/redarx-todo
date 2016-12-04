import 'package:redarx/redarx.dart';
import 'package:todomvc0/model/todo.dart';

class TodoModel extends AbstractModel {
  List<Todo> items;

  List<Todo> get todos =>
      items.where((t) => showCompleted ? t.completed : !t.completed).toList();

  int get numCompleted => items.length - todos.length;

  bool showCompleted;

  TodoModel.empty() {
    showCompleted = false;
    items = [];
  }

  @override
  AbstractModel initial() => new TodoModel.empty();

  @override
  String toString() {
    return '''
Model{
  showCompleted = $showCompleted,
  todos : $todos
}
''';
  }
}
